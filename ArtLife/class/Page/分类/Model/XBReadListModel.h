//
//  XBReadListModel.h
//  ArtLife
//
//  Created by lxb on 2017/3/2.
//  Copyright © 2017年 lxb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XBReadListModel : NSObject
/**类型*/
@property (nonatomic, assign) NSInteger type;
/**标题*/
@property (nonatomic, strong) NSString *name;
/**作者名*/
@property (nonatomic, strong) NSString *enname;
/**图片*/
@property (nonatomic, strong) NSString *coverimg;


@end
