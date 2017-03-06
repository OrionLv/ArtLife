//
//  XBVideoListCell.m
//  ArtLife
//
//  Created by lxb on 2017/3/5.
//  Copyright © 2017年 lxb. All rights reserved.
//

#import "XBVideoListCell.h"
#import "GobelDefine.h"
#import "UIView+Addition.h"

@implementation XBVideoListCell

// 在这个方法中添加所有的子控件
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIImageView *image = [[UIImageView alloc] init];
        [self.contentView addSubview:image];
        self.ImageView = image;
        
        UIImageView *shadeView = [[UIImageView alloc]init];
        shadeView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
        self.shadeView = shadeView;
        [image addSubview:self.shadeView];
        
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.font = [UIFont fontWithName:MyChinFont size:15.f];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:titleLabel];
        self.titleLabel = titleLabel;
        
        UILabel *messageLabel = [[UILabel alloc] init];
        messageLabel.textColor = [UIColor whiteColor];
        messageLabel.font = [UIFont systemFontOfSize:12.f];
        messageLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:messageLabel];
        self.messageLabel = messageLabel;
    }
    return self;
}

// 设置所有的子控件的frame
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.ImageView.frame = self.bounds;
    
    self.shadeView.frame = self.bounds;
    
    /** 标题 */
    self.titleLabel.frame = CGRectMake(5, self.bounds.size.height/2 - 20, self.bounds.size.width - 10, 30);
    
    /** 信息 */
    self.messageLabel.frame = CGRectMake(0, _titleLabel.bottom + 5, _titleLabel.width, 25);
}

@end
