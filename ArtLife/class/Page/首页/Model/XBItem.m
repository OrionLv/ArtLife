//
//  XBItem.m
//  ArtLife
//
//  Created by lxb on 2017/3/6.
//  Copyright © 2017年 lxb. All rights reserved.
//

#import "XBItem.h"

@implementation XBItem

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"itemID"] = @"id";
    return dict;
}

@end
