//
//  XBTabBar.m
//  ArtLife
//
//  Created by lxb on 2017/2/17.
//  Copyright © 2017年 lxb. All rights reserved.
//

#import "XBTabBar.h"

@interface XBTabBar ()

@property (nonatomic, strong) UIButton *publishBtn; //发布按钮

@end

@implementation XBTabBar

-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        UIButton *publishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [publishBtn setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [publishBtn setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        [publishBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:publishBtn];
        self.publishBtn = publishBtn;
    }
    
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    
    // 设置发布按钮的frame
    self.publishBtn.bounds = CGRectMake(0, 0, self.publishBtn.currentBackgroundImage.size.width, self.publishBtn.currentBackgroundImage.size.height);
    self.publishBtn.center = CGPointMake(width * 0.5, height * 0.5);
    
    //设置其他按钮的frame
    CGFloat ButtonY = 0;
    CGFloat ButtonW = width / 5;
    CGFloat ButtonH = height;
    NSInteger index = 0;
    
    for(UIButton *btn in self.subviews)
    {
        if (![btn isKindOfClass:NSClassFromString(@"UITabBarButton")]){continue;}
        
        //计算按钮的x
        CGFloat ButtonX = ButtonW * ((index > 1)?(index + 1):index);
        
        btn.frame = CGRectMake(ButtonX, ButtonY, ButtonW, ButtonH);
        
        index ++;
    }
}

-(void)btnClick:(UIButton *)sender{
    
}

@end
