//
//  UIBarButtonItem+XBExtension.h
//  ArtLife
//
//  Created by lxb on 2017/2/17.
//  Copyright © 2017年 lxb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (XBExtension)

+(instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highimage traget:(id)traget  action:(SEL)action;

@end
