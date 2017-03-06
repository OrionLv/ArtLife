//
//  XBTabBarContorller.m
//  ArtLife
//
//  Created by lxb on 2017/2/17.
//  Copyright © 2017年 lxb. All rights reserved.
//

#import "XBTabBarContorller.h"
#import "XBTabBar.h"
#import "XBNavigationController.h"
#import "XBHomeViewController.h"
#import "XBLifeViewController.h"
#import "XBCategoryViewController.h"
#import "XBPersonViewController.h"

@interface XBTabBarContorller ()

@end

@implementation XBTabBarContorller

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //通过appearance统一设置所有的属性
    //方法后面带有UI_APPEARANCE_SELECTOR 都可以通过appearance对象统一设置
    NSMutableDictionary *atts = [NSMutableDictionary dictionary];
    atts[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    atts[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    NSMutableDictionary *selectAtts = [NSMutableDictionary dictionary];
    selectAtts[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    selectAtts[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    
    //统一设置字体
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:atts forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectAtts forState:UIControlStateSelected];
    
    //创建子控制器
    [self setupChildVc:[[XBHomeViewController alloc] init] Title:@"首页" image:@"recommendation_1" AndSelectImage:@"recommendation_2"];
    [self setupChildVc:[[XBLifeViewController alloc] init] Title:@"生活" image:@"broadwood_1" AndSelectImage:@"broadwood_2"];
    [self setupChildVc:[[XBCategoryViewController alloc] init] Title:@"分类" image:@"classification_1" AndSelectImage:@"classification_2"];
    [self setupChildVc:[[XBPersonViewController alloc] init] Title:@"个人" image:@"my_1" AndSelectImage:@"my_2"];
    
//    //更换TabBar
//    [self setValue:[[XBTabBar alloc] init] forKeyPath:@"tabBar"];
    
    [self.tabBar setBackgroundImage:[UIImage imageNamed:@"tabbar-light"]];
}

//提取的方法
-(void)setupChildVc:(UIViewController *)vc Title:(NSString *)title image:(NSString *)image AndSelectImage:(NSString *)selectImage
{
    //添加子控制器
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectImage];
    
    //包装导航控制器，添加导航控制器为自控制器
    XBNavigationController *nav = [[XBNavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
}

- (BOOL)shouldAutorotate//是否支持旋转屏幕
{
    return YES;
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations//支持哪些方向
{
    return UIInterfaceOrientationMaskPortrait;
}
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation//默认显示的方向
{
    return UIInterfaceOrientationPortrait;
}

@end
