//
//  XBLoadingView.h
//  ArtLife
//
//  Created by lxb on 2017/3/2.
//  Copyright © 2017年 lxb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XBLoadingView : UIView

- (void)showLoadingTo:(UIView *)view;

- (void)dismiss;

- (void)showLoadingViewTo:(UIWindow *)window;

@end
