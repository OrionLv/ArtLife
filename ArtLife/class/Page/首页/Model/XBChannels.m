//
//  XBChannels.m
//  ArtLife
//
//  Created by lxb on 2017/3/6.
//  Copyright © 2017年 lxb. All rights reserved.
//

#import "XBChannels.h"

@implementation XBChannels

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"channelsID"] = @"id";
    return dic;
}

@end
