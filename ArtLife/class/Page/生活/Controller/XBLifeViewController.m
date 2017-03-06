//
//  XBLifeViewController.m
//  ArtLife
//
//  Created by lxb on 2017/2/17.
//  Copyright © 2017年 lxb. All rights reserved.
//

#import "XBLifeViewController.h"
#import "AFOwnerHTTPSessionManager.h"
#import "MJRefresh.h"
#import "GobelDefine.h"
#import "SVProgressHUD.h"
#import "XBLoadingView.h"
#import "MJExtension.h"
#import "XBVideoListCell.h"
#import "UIImageView+WebCache.h"
#import "XBDeilyViewController.h"
#import "XBRefreshHeader.h"
#import "XBRefreshFooter.h"


@interface XBLifeViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
// 网络请求
@property(nonatomic,strong)AFOwnerHTTPSessionManager *manager;

/**动画*/
@property (nonatomic, strong) XBLoadingView *waitView;

@property (nonatomic, strong) NSMutableArray *ListArr;

@property (nonatomic, strong) NSString *NextPageStr;



@end

@implementation XBLifeViewController

#pragma mark - 旋转屏的设置
- (BOOL)shouldAutorotate//是否支持旋转屏幕
{
    return NO;
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations//支持哪些方向
{
    return UIInterfaceOrientationMaskPortrait;
}
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation//默认显示的方向
{
    return UIInterfaceOrientationPortrait;
}

#pragma mark - load Method
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //背景色的设置
    self.view.backgroundColor = [UIColor grayColor];
    
    //初始化导航栏
    [self setupNavigation];
    
    //初始化控件
    [self setupSubViews];
    
  
}

#pragma mark - private Method
-(void)setupNavigation{
    
    self.navigationItem.title = @"生活";
}

-(void)setupSubViews{
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 40)];
    label.text = @"生活小视频";
    label.font = [UIFont fontWithName:MyEnFontTwo size:24];
    label.textColor = [UIColor blackColor];
    self.navigationItem.titleView = label;
    
    // 设置TableView
    [self setTableView];
    // 获取网络数据
    [self getNetData];
    
    //默认【下拉刷新】
    self.tableView.mj_header = [XBRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(getNetData)];
    //默认【上拉加载】
    self.tableView.mj_footer = [XBRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
    
    [self setupRefresh];
    
}

#pragma mark - NETWrok method

- (void)setupRefresh{
    
    //默认【下拉刷新】
    self.tableView.mj_header = [XBRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(getNetData)];
    //默认【上拉加载】
    self.tableView.mj_footer = [XBRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
}

// 设置TableView
- (void)setTableView{
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.rowHeight = SCREENWIDTH/3;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = NO;
    [self.view addSubview:self.tableView];
}

// 获取数据
- (void)getNetData{
    
    _ListArr = [[NSMutableArray alloc]init];
    
    //添加等待动画
    self.waitView = [[XBLoadingView alloc] initWithFrame:self.view.frame];
    [self.waitView showLoadingTo:self.view];
    
    NSString *str = [self changeTime:[self getdate]];
    NSString *urlStr = [NSString stringWithFormat:dailyList,10,str];
    
    
    //网络请求
    [[AFOwnerHTTPSessionManager manager] getURL:urlStr Parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        self.NextPageStr = [NSString stringWithFormat:@"%@",responseObject[@"nextPageUrl"]];
        
        NSDictionary *dailyListDict = [responseObject objectForKey:@"dailyList"];
  
        for (NSDictionary *videoList in dailyListDict) {
            NSArray *temp = [videoList objectForKey:@"videoList"];
        
            for (NSDictionary *dict in temp) {
                XBVideoListModel *model = [[XBVideoListModel alloc]init];
                model.ImageView = [NSString stringWithFormat:@"%@",dict[@"coverForDetail"]];
                model.titleLabel = [NSString stringWithFormat:@"%@",dict[@"title"]];
                model.category = [NSString stringWithFormat:@"%@",dict[@"category"]];
                model.duration = [NSString stringWithFormat:@"%@",dict[@"duration"]];
                model.desc = [NSString stringWithFormat:@"%@",dict[@"description"]];
                model.playUrl = [NSString stringWithFormat:@"%@",dict[@"playUrl"]];
                NSDictionary *Dic = dict[@"consumption"];
                model.consumption = Dic;
                
                [_ListArr addObject:model];
            }
        }
        
        [self.tableView reloadData];
        [self.waitView dismiss];
        [self endRefresh];
        
        self.navigationItem.title = @"生活";

    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self endRefresh];
        [self.waitView dismiss];
    }];
    
}

// 加载更多
- (void)loadMore{
    
    if ([self.NextPageStr isEqualToString:@"<null>"]) {
        
        UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT/3)];
        footView.backgroundColor = [UIColor whiteColor];
        
        UILabel *footLabel = [[UILabel alloc]init];
        footLabel.frame = CGRectMake(0, self.view.frame.size.height /2 - 10, self.view.frame.size.width, 20);
        footLabel.font = [UIFont fontWithName:MyEnFontTwo size:14.f];
        footLabel.text = @"- The End -";
        [footView addSubview:footLabel];
        self.tableView.tableFooterView = footView;
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
        
    }else{
        
        //添加等待动画
        self.waitView = [[XBLoadingView alloc] initWithFrame:self.view.frame];
        [self.waitView showLoadingTo:self.view];

        [[AFOwnerHTTPSessionManager manager] getURL:self.NextPageStr Parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
            
            self.NextPageStr = [responseObject objectForKey:@"nextPageUrl"];
            
            NSDictionary *dailyListDict = [responseObject objectForKey:@"dailyList"];
            for (NSDictionary *videoList in dailyListDict) {
                NSArray *temp = [videoList objectForKey:@"videoList"];
                
                for (NSDictionary *dict in temp) {
                    XBVideoListModel *model = [[XBVideoListModel alloc]init];
                    model.ImageView = [NSString stringWithFormat:@"%@",dict[@"coverForDetail"]];
                    model.titleLabel = [NSString stringWithFormat:@"%@",dict[@"title"]];
                    model.category = [NSString stringWithFormat:@"%@",dict[@"category"]];
                    model.duration = [NSString stringWithFormat:@"%@",dict[@"duration"]];
                    model.desc = [NSString stringWithFormat:@"%@",dict[@"description"]];
                    model.playUrl = [NSString stringWithFormat:@"%@",dict[@"playUrl"]];
                    NSDictionary *Dic = dict[@"consumption"];
                    model.consumption = Dic;
                    
                    [_ListArr addObject:model];
                }
            }
            
            self.navigationItem.title = @"生活";
            [self.tableView reloadData];
            [self.waitView dismiss];
            [self endRefresh];

              
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
              
              [self endRefresh];
              [self.waitView dismiss];
        }];
        
    }
}

- (void)endRefresh{
    
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}

-(NSTimeInterval)getdate{
    
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970]* 1000;
    return a;
}

// 获取当天的时间
-(NSString *)changeTime:(NSTimeInterval)time{
    
    time = time - 86400000 *5;
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:time/ 1000.0 ];
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    [objDateformat setDateFormat:@"yyyyMMdd"];
    NSString *str  = [objDateformat stringFromDate: date];
    return str;
}

#pragma mark -- TableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _ListArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    XBVideoListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[XBVideoListCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    
    XBVideoListModel *model = _ListArr[indexPath.row];
    
    [cell.ImageView sd_setImageWithURL:[NSURL URLWithString:model.ImageView]];
    cell.titleLabel.text = model.titleLabel;
    cell.messageLabel.text = [NSString stringWithFormat:@"#%@%@%@",model.category,@" / ",[self timeStrFormTime:model.duration]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    XBDeilyViewController *detail = [[XBDeilyViewController alloc]init];
    detail.model = _ListArr[indexPath.row];
    [self.navigationController pushViewController:detail animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return SCREENHEIGHT / 3;
}

//转换时间格式
-(NSString *)timeStrFormTime:(NSString *)timeStr
{
    int time = [timeStr intValue];
    int minutes = time / 60;
    int second = (int)time % 60;
    return [NSString stringWithFormat:@"%02d'%02d\"",minutes,second];
}



@end
