//
//  XBVideoPlayViewController.h
//  ArtLife
//
//  Created by lxb on 2017/3/6.
//  Copyright © 2017年 lxb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XBVideoPlayViewController : UIViewController

// 视频地址
@property(nonatomic,strong) NSString *UrlString;
// 视频标题
@property(nonatomic,strong) NSString *titleStr;
// 视频时长
@property(nonatomic, assign) double duration;

@end
