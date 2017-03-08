//
//  XBHomeViewController.m
//  ArtLife
//
//  Created by lxb on 2017/2/17.
//  Copyright © 2017年 lxb. All rights reserved.
//

#import "XBHomeViewController.h"
#import "AFOwnerHTTPSessionManager.h"
#import "GobelDefine.h"
#import "MJExtension.h"
#import "XBChannels.h"
#import "UIView+Addition.h"
#import "XBChannelController.h"

@interface XBHomeViewController () <UIScrollViewDelegate>

/**
 *  频道数组
 */
@property (nonatomic, strong) NSArray *channels;
// 头部标题视图
@property (nonatomic, weak) UIView *titlesView;
// 当前选中按钮
@property (nonatomic, weak) UIButton *selectedBtn;

/**
 *  红色指示条
 */
@property (nonatomic, weak) UIView *indicatorView;

/**
 *  内容视图
 */
@property (nonatomic, weak) UIScrollView *contentView;

@end

@implementation XBHomeViewController

#pragma mark - load
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 设置导航栏
    [self setNav];
    // 请求头部标题数据
    [self loadTitlesViewInfo];
}

#pragma mark - private Method
-(void)setNav{
    
    self.navigationItem.title = @"首页";
}

-(void)loadTitlesViewInfo{
    __weak typeof(self)weakSelf = self;
    // 网络请求地址
    NSString *url = [NSString stringWithFormat:@"%@%@", BaseAPI, @"v2/channels/preset?gender=1&generation=1"];
    // 发送网络请求
    [[AFOwnerHTTPSessionManager manager] getURL:url Parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
       
        // 将返回的数据转化为对象数组存入当前数组用于设置标题
        NSArray *dictArray = responseObject[@"data"][@"channels"];
        weakSelf.channels = [XBChannels mj_objectArrayWithKeyValuesArray:dictArray];
        // 设置头部标题
        [weakSelf setUpTitles];
        // 设置内容视图
        [weakSelf setContentView];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

- (void)setUpTitles
{
    // 标签栏整体
    UIView *titleView = [[UIView alloc] init];
    titleView.backgroundColor = MRRGBColor(240, 240, 240);
    titleView.sd_y = 64;
    titleView.sd_width = self.view.sd_width;
    titleView.sd_height = 36;
    [self.view addSubview:titleView];
    self.titlesView = titleView;
    
    // 底部的红色指示器
    UIView *indicatorView = [[UIView alloc] init];
    indicatorView.backgroundColor = MRGlobalBg;
    indicatorView.sd_height = 2;
    indicatorView.sd_y = titleView.sd_height - indicatorView.sd_height;
    [titleView addSubview:indicatorView];
    self.indicatorView = indicatorView;
    
    // 内部子标签
    NSInteger count = self.channels.count;
    CGFloat width = self.view.sd_width / count;
    CGFloat height = titleView.sd_height - 2;
    
    for (NSInteger i = 0; i < count; i++) {
        
        UIButton *button = [[UIButton alloc] init];
        button.sd_x = i * width;
        button.sd_width = width;
        button.sd_height = height;
        button.tag = i;
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        XBChannels *channel = self.channels[i];
        [button setTitle:channel.name forState:UIControlStateNormal];
        // [button layoutIfNeeded];    // 强制布局(强制更新子控件的frame)
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:MRGlobalBg forState:UIControlStateDisabled];
        [button addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        // 添加子控制器
        [self addChildVc:self.channels[i]];
        [titleView addSubview:button];
        
        // 默认选中第一个按钮
        if(i == 0) {
            button.enabled = NO;
            self.selectedBtn = button;
            [button.titleLabel sizeToFit]; // 让按钮根据文字内容设置尺寸
            self.indicatorView.sd_width = button.titleLabel.sd_width;
            self.indicatorView.xb_centerX = button.xb_centerX;
        }
    }
}


/**
 *  初始化内容视图
 */
- (void)setContentView {
    
    // 取消自动设置UIScrollView的contentInset
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *contentView = [[UIScrollView alloc] init];
    contentView.frame = self.view.bounds;
    contentView.delegate = self;
    contentView.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.2];
    contentView.pagingEnabled = YES;
    contentView.bounces = NO;
    contentView.showsHorizontalScrollIndicator = NO;
    contentView.contentSize = CGSizeMake(self.channels.count * self.view.sd_width, 0);
    [self.view insertSubview:contentView belowSubview:self.titlesView];
    self.contentView = contentView;
    
    [self scrollViewDidEndScrollingAnimation:contentView];
}


/**
 *  添加子控制器
 */
- (void)addChildVc:(XBChannels *)channel {
    XBChannelController *channelVc = [[XBChannelController alloc] init];
    channelVc.channesID = channel.channelsID;
    [self addChildViewController:channelVc];
}


// 选中按钮的点击事件
- (void)titleClick:(UIButton *)button {
    
    NSInteger index = button.tag;
    // 修改选中按钮状态
    self.selectedBtn.enabled = YES;
    button.enabled = NO;
    self.selectedBtn = button;
    
    [UIView animateWithDuration:0.25 animations:^{
        self.indicatorView.sd_width = button.titleLabel.sd_width;
        self.indicatorView.xb_centerX = button.xb_centerX;
        
    }];
    
    // 滚动
    CGPoint offSet = self.contentView.contentOffset;
    offSet.x = index * self.contentView.sd_width;
    
    // 只有当scrollView偏移量前后不同的时候才会回调scrollViewDidEndScrollingAnimation方法,若两次的偏移量相同,则不会回调
    [self.contentView setContentOffset:offSet animated:YES];
}




#pragma mark - <UIScrollViewDelegate>

// 当每次scrollView切换的时候就会调用
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    
    CGFloat width = scrollView.sd_width;
    
    // 计算下标
    NSInteger index = scrollView.contentOffset.x / width;
    
    // 拿到对应下标的控制器
    UITableViewController *willShowVc = self.childViewControllers[index];
    
    if([willShowVc isViewLoaded]) { // 如果已经显示, 直接返回
        return;
    }
    
    willShowVc.view.sd_x = index * width;
    willShowVc.view.sd_y = 0;   // 设置控制器view的y值为0, 控制器view的默认y为20(状态栏高度)
    willShowVc.view.sd_height = self.view.sd_height;
    
    [scrollView addSubview:willShowVc.view];
}


// 当手指拖动scrollView滑动的时候调用
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    [self scrollViewDidEndScrollingAnimation:_contentView];
    
    CGFloat width = scrollView.sd_width;
    
    // 计算下标
    NSInteger index = scrollView.contentOffset.x / width;
    
    UIButton *btn = self.titlesView.subviews[index + 1];
    
    [self titleClick:btn];
}

#pragma mark - lazy load

- (NSArray *)channels {
    
    if(!_channels) {
        
        _channels = [NSArray array];
        
    }
    
    return _channels;
}


@end
