//
//  XBRefreshFooter.m
//  ArtLife
//
//  Created by lxb on 2017/3/3.
//  Copyright © 2017年 lxb. All rights reserved.
//

#import "XBRefreshFooter.h"

@implementation XBRefreshFooter

#pragma mark - 重写方法
#pragma mark 基本设置
- (void)prepare
{
    [super prepare];
    
    // 设置正在刷新状态的动画图片
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (int i = 0; i < 28; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"refresh%d", i]];
        [refreshingImages addObject:image];
    }
    [self setImages:refreshingImages forState:MJRefreshStateRefreshing];
    
    //隐藏状态
    self.refreshingTitleHidden = YES;
    self.stateLabel.hidden = YES;
}


@end
