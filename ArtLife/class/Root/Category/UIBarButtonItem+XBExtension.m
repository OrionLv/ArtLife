//
//  UIBarButtonItem+XBExtension.m
//  ArtLife
//
//  Created by lxb on 2017/2/17.
//  Copyright © 2017年 lxb. All rights reserved.
//

#import "UIBarButtonItem+XBExtension.h"

@implementation UIBarButtonItem (XBExtension)

+(instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highimage traget:(id)traget  action:(SEL)action
{
    //设置导航栏的内容
    
    UIButton *Btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [Btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [Btn setBackgroundImage:[UIImage imageNamed:highimage] forState:UIControlStateHighlighted];
    [Btn addTarget:traget action:action forControlEvents:UIControlEventTouchUpInside];
    Btn.frame = CGRectMake(10, 10, Btn.currentBackgroundImage.size.width, Btn.currentBackgroundImage.size.height);
    
    return [[self alloc] initWithCustomView:Btn];
}

@end
