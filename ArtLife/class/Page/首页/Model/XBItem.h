//
//  XBItem.h
//  ArtLife
//
//  Created by lxb on 2017/3/6.
//  Copyright © 2017年 lxb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XBItem : NSObject

/**
 * cover_image_url
 */
@property (nonatomic, copy) NSString *cover_image_url;
/**
 *  itemID
 */
@property (nonatomic, assign) NSInteger itemID;
/**
 * published_at
 */
@property (nonatomic, copy) NSString *published_at;

/**
 * content_url
 */
@property (nonatomic, copy) NSString *content_url;
/**
 * url
 */
@property (nonatomic, copy) NSString *url;
/**
 * type
 */
@property (nonatomic, copy) NSString *type;
/**
 * share_msg
 */
@property (nonatomic, copy) NSString *share_msg;
/**
 * title
 */
@property (nonatomic, copy) NSString *title;
/**
 * short_title
 */
@property (nonatomic, copy) NSString *short_title;
/**
 * likes_count
 */
@property (nonatomic, assign) NSInteger likes_count;
/**
 *  status
 */
@property (nonatomic, assign) NSInteger status;

@end
