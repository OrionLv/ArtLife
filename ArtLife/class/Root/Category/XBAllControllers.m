//
//  XBAllControllers.m
//  ArtLife
//
//  Created by lxb on 2017/3/7.
//  Copyright © 2017年 lxb. All rights reserved.
//

#import "XBAllControllers.h"
#import "XBTabBarContorller.h"

@implementation XBAllControllers

+(void)createViewController
{
    //获取当前类的(唯一)对象
    XBAllControllers *dispatchTool = [XBAllControllers shareOpenController];
    
    //用当前类的对象 执行实际选择执行的方法
    [dispatchTool openViewControllerWithIndex];

}

+ (instancetype)shareOpenController
{
    //获取到调度的唯一对象
    static XBAllControllers *tempTool = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tempTool = [[XBAllControllers alloc] init];
    });
    
    return tempTool;
}

#pragma mark - 实际选择执行的方法
- (void)openViewControllerWithIndex
{
    
    XBTabBarContorller *tabVC = [[XBTabBarContorller alloc] init];
    [UIApplication sharedApplication].keyWindow.rootViewController = tabVC;
    [[UIApplication sharedApplication].keyWindow makeKeyAndVisible];
}


@end
