//
//  XBNavigationController.m
//  ArtLife
//
//  Created by lxb on 2017/2/17.
//  Copyright © 2017年 lxb. All rights reserved.
//

#import "XBNavigationController.h"
#import "GobelDefine.h"

@interface XBNavigationController ()

@end

@implementation XBNavigationController

//当第一次使用这个类的时候会调用一次
+(void)initialize
{
    UINavigationBar *bar = [UINavigationBar appearance];
    [bar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
    
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if(self.childViewControllers.count > 0)
    {
        UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [leftBtn setTitle:@"" forState:UIControlStateNormal];
        [leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [leftBtn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        [leftBtn setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
        [leftBtn setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateHighlighted];
        [leftBtn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
        leftBtn.frame = CGRectMake(0, 0, 100, 30);
        [leftBtn sizeToFit];
        leftBtn.contentEdgeInsets = UIEdgeInsetsMake(0, - 10 , 0, 0);
        
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
        
        //隐藏tabBar
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    //来控制优先级 让VIewController可以覆盖上面的leftButtonItem
    [super pushViewController:viewController animated:animated];
    
}

-(void)click
{
    [self popViewControllerAnimated:YES];
}

@end
