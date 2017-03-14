//
//  XBNewReadPageController.m
//  ArtLife
//
//  Created by lxb on 2017/3/2.
//  Copyright © 2017年 lxb. All rights reserved.
//

#import "XBNewReadPageController.h"
#import "XBLoadingView.h"
#import "ReadSecondCell.h"
#import "UIBarButtonItem+Helper.h"
#import "MJRefresh.h"
#import "XBRefreshHeader.h"
#import "XBRefreshFooter.h"
#import "AFOwnerHTTPSessionManager.h"
#import "MJExtension.h"
#import "ReadSecondListModel.h"
#import "SVProgressHUD.h"
#import "XBDetailViewController.h"
#import "GobelDefine.h"

@interface XBNewReadPageController ()<UITableViewDelegate, UITableViewDataSource, UIWebViewDelegate>

/**TableView*/
@property (nonatomic, strong) UITableView *readSecondTableView;
/**数据源*/
@property (nonatomic, strong) NSMutableArray *dataSource;
/**标题*/
@property (nonatomic, strong) NSString *titleStr;
/**加载视图*/
@property (nonatomic, strong) XBLoadingView *waitView;
/**技术*/
@property(nonatomic, assign)NSInteger total;

@end


@implementation XBNewReadPageController

#pragma mark - 懒加载
-(UITableView *)readSecondTableView{
    if(!_readSecondTableView){
        _readSecondTableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
        _readSecondTableView.delegate = self;
        _readSecondTableView.dataSource = self;
        _readSecondTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        //注册
        [_readSecondTableView registerNib:[UINib nibWithNibName:NSStringFromClass([ReadSecondCell class]) bundle:nil] forCellReuseIdentifier:@"cell"];
    }
    return _readSecondTableView;
}

#pragma mark - load Method
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [SVProgressHUD showWithStatus:@"正在加载中"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.title = @"类别";
    
//    [self setupSubViews];
    
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:Blog]];
    
    UIWebView *web = [[UIWebView alloc] init];
    web.frame = self.view.bounds;
    web.delegate = self;
    [web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:Blog]]];
    [self.view addSubview:web];
}

#pragma mark - private Method
-(void)setupSubViews{
    
    [self.view addSubview:self.readSecondTableView];
    
    UIBarButtonItem *backItem = [UIBarButtonItem itemWithTitle:@"返回" target:self action:@selector(back)];
    self.navigationItem.backBarButtonItem = backItem;
    
    self.readSecondTableView.mj_header = [XBRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.readSecondTableView.mj_footer = [XBRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    //发送网络请求
    [self creatURLRequest:@"addtime"];
    
    self.waitView = [[XBLoadingView alloc] initWithFrame:self.view.frame];
    [self.waitView showLoadingTo:self.readSecondTableView];
    self.total = 0;
}

- (void)creatURLRequest:(NSString *)sort
{
    NSDictionary *params = @{
                             @"client" : @"1",
                             @"deviceid" : @"0B0D7528-4F8E-4111-A628-AE4254EDCB64",
                             @"limit" : @10,
                             @"sort" : sort,
                             @"start" : @0,
                             @"typeid" : self.typeID,
                             @"version" : @"3.0.6"
                             };
    [[AFOwnerHTTPSessionManager manager] postURL:@"http://api2.pianke.me/read/columns_detail" Parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        //解析数据
        NSDictionary *dic = responseObject[@"data"];
        self.dataSource = [ReadSecondListModel mj_objectArrayWithKeyValuesArray:dic[@"list"]];
        [self.readSecondTableView reloadData];
        [self.waitView dismiss];
        self.total = 0;
        [self.readSecondTableView.mj_header endRefreshing];

        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.waitView dismiss];
        [SVProgressHUD showErrorWithStatus:@"网络不给力"];
        [self.readSecondTableView.mj_header endRefreshing];
    }];
    
}

-(void)back{
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ReadSecondCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.listModel = self.dataSource[indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 110;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    XBDetailViewController *vc = [[XBDetailViewController alloc] init];
    vc.model = self.dataSource[indexPath.row];
    
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - loadData Method

#pragma mark - 下拉刷新
- (void)loadNewData
{
    [self.dataSource removeAllObjects];
    [self creatURLRequest:@"addtime"];
}


#pragma mark - 上拉加载更多
- (void)loadMoreData
{
    self.total += 10;
    NSDictionary *params = @{
                             @"client" : @"1",
                             @"deviceid" : @"0B0D7528-4F8E-4111-A628-AE4254EDCB64",
                             @"limit" : @10,
                             @"sort" : @"addtime",
                             @"start" : @(self.total),
                             @"typeid" : self.typeID,
                             @"version" : @"3.0.6"
                             };
    
    [[AFOwnerHTTPSessionManager manager] postURL:@"http://api2.pianke.me/read/columns_detail" Parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *dic = responseObject[@"data"];
        NSMutableArray *array = [ReadSecondListModel mj_objectArrayWithKeyValuesArray:dic[@"list"]];
        [self.dataSource addObjectsFromArray:array];
        
        [self.readSecondTableView reloadData];
        [self.waitView dismiss];
        [self.readSecondTableView.mj_footer endRefreshing];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.waitView dismiss];
        [SVProgressHUD showErrorWithStatus:@"网络不给力"];
        [self.readSecondTableView.mj_footer endRefreshing];
    }];
    
}

#pragma mark - webViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView{
//    [SVProgressHUD showWithStatus:@"正在加载"];

    //蒙版的View 展示到主页面上面
    XBLoadingView *loadView = [[XBLoadingView alloc] init];
    [loadView showLoadingTo:self.view];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [SVProgressHUD dismiss];
}

#pragma mark - load Method
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [SVProgressHUD dismiss];
}

@end
