//
//  XBVideoListCell.h
//  ArtLife
//
//  Created by lxb on 2017/3/5.
//  Copyright © 2017年 lxb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XBVideoListCell : UITableViewCell

/** 图片 */
@property (nonatomic, weak) UIImageView *ImageView;

@property (nonatomic, weak) UIImageView *shadeView;

/** 标题 */
@property (nonatomic, weak) UILabel *titleLabel;

/** Message */
@property (nonatomic, weak) UILabel *messageLabel;

@end
