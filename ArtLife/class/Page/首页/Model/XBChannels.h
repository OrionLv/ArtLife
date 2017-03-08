//
//  XBChannels.h
//  ArtLife
//
//  Created by lxb on 2017/3/6.
//  Copyright © 2017年 lxb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XBChannels : NSObject

/**
 *  id
 */
@property (nonatomic, assign) NSInteger channelsID;

/**
 *  eidtable
 */
@property (nonatomic, assign) NSInteger editable;

/**
 * name
 */
@property (nonatomic, copy) NSString *name;

@end
