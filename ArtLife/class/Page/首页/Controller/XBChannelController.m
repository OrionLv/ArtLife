//
//  XBChannelController.m
//  ArtLife
//
//  Created by lxb on 2017/3/6.
//  Copyright © 2017年 lxb. All rights reserved.
//

#import "XBChannelController.h"
#import "MJRefresh.h"
#import "UIView+Addition.h"
#import "AFOwnerHTTPSessionManager.h"
#import "MJExtension.h"
#import "XBItem.h"
#import "LYItemCell.h"
#import "XBRefreshHeader.h"
#import "XBRefreshFooter.h"
#import "XBLoadingView.h"
#import "XBDetailController.h"

@interface XBChannelController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, copy) NSString *next_url;

/**等待框*/
@property (nonatomic, strong) XBLoadingView *waitView;
/**
 *  item数组
 */
@property (nonatomic, strong) NSMutableArray *items;

@end

@implementation XBChannelController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化表格
    [self setupTable];
    
    // 刷新
    [self.tableView.mj_header beginRefreshing];
}

/**
 *  初始化表格
 */
- (void)setupTable {

    self.tableView.contentInset = UIEdgeInsetsMake(64 + 36, 0, self.tabBarController.tabBar.sd_height, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
    // 给表格视图添加下拉刷新
    self.tableView.mj_header = [XBRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewInfo)];
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    // 给表格视图添加上拉加载
    self.tableView.mj_footer = [XBRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreInfo)];
    
    // 注册单元格
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LYItemCell class]) bundle:nil] forCellReuseIdentifier:@"cell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = 160;
}

/**
 *  请求数据
 */
- (void)loadItemInfo:(NSString *)urlString withType:(NSInteger)type{
    
    //添加waitView
    self.waitView = [[XBLoadingView alloc] initWithFrame:self.view.bounds];
    [self.waitView showLoadingTo:self.tableView];
    
    __weak typeof(self) weakSelf = self;
    
    [[AFOwnerHTTPSessionManager manager] getURL:urlString Parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSArray *dictArr = responseObject[@"data"][@"items"];
        
        NSMutableArray *items = [XBItem mj_objectArrayWithKeyValuesArray:dictArr];
        if(type == 0) { // 下拉刷新
            weakSelf.items = items;
        } else  {   // 上拉加载
            [weakSelf.items addObjectsFromArray:items];
        }
        
        weakSelf.next_url = responseObject[@"data"][@"paging"][@"next_url"];;
        
        // 刷新表格
        [weakSelf.tableView reloadData];
        
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
        
        [weakSelf.waitView dismiss];

    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [weakSelf.waitView dismiss];
        
    }];
 
}

/**
 *  下拉刷新
 */
- (void)loadNewInfo {
    // 拼接参数
    NSString *urlString = [NSString stringWithFormat:@"http://api.dantangapp.com/v1/channels/%ld/items?gender=1&generation=1&limit=20&offset=0", self.channesID];
    
    [self loadItemInfo:urlString withType:0];
}

/**
 *  上拉加载
 */
- (void)loadMoreInfo {
    if(self.next_url != nil && ![self.next_url isEqual:[NSNull null]]) {
        [self loadItemInfo:self.next_url withType:1];
    }else {
    }
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.items.count;
}

// 返回对应的单元格视图
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LYItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;    // 取消选中样式
    XBItem *item = self.items[indexPath.row];
    cell.item = item;   // 设置数据源
    return cell;
}

#pragma mark - Table view delgate

// 单元格的点击事件处理
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    XBDetailController *detailVc = [[XBDetailController alloc] init];
    detailVc.item = self.items[indexPath.row];
    [self.navigationController pushViewController:detailVc animated:YES];
    
}


#pragma mark - lazy load

- (NSMutableArray *)items {
    
    if(!_items) {
        
        _items = [NSMutableArray array];
        
    }
    
    return _items;
}

@end
