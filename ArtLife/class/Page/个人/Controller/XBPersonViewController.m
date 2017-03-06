//
//  XBPersonViewController.m
//  ArtLife
//
//  Created by lxb on 2017/2/17.
//  Copyright © 2017年 lxb. All rights reserved.
//

#import "XBPersonViewController.h"

@interface XBPersonViewController ()

@end

@implementation XBPersonViewController

#pragma mark - load
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //初始化导航栏
    [self setupNavigation];
    //初始化控件
    [self setupSubViews];
}

#pragma mark - private Method
-(void)setupNavigation{
    
    self.navigationItem.title = @"个人";
}

-(void)setupSubViews{
    
}


@end
