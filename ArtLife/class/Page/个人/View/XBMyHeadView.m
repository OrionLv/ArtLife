//
//  XBMyHeadView.m
//  ArtLife
//
//  Created by lxb on 2017/3/6.
//  Copyright © 2017年 lxb. All rights reserved.
//

#import "XBMyHeadView.h"

@interface XBMyHeadView ()

@property (weak, nonatomic) IBOutlet UIButton *clickBtn;

@end

@implementation XBMyHeadView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self.clickBtn addTarget:self action:@selector(bClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)bClick
{
    if (self.BtnClick) {
        self.BtnClick();
    }
}

@end
