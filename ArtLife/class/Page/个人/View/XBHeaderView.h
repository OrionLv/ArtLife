//
//  XBHeaderView.h
//  ArtLife
//
//  Created by lxb on 2017/3/7.
//  Copyright © 2017年 lxb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XBHeaderView : UIView

/**控制器*/
@property (nonatomic, weak) UIViewController *controller;

+(instancetype)loadHeadView;

@end
