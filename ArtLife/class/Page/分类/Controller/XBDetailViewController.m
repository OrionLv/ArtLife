//
//  XBDetailViewController.m
//  ArtLife
//
//  Created by lxb on 2017/3/3.
//  Copyright © 2017年 lxb. All rights reserved.
//

#import "XBDetailViewController.h"
#import "UIImageView+WebCache.h"
#import "SDWebImageManager.h"
#import "Masonry.h"

@interface XBDetailViewController ()


@property (weak, nonatomic)  UILabel *titleLabel;

@property (weak, nonatomic)  UIImageView *icon;

@property (weak, nonatomic)  UILabel *contentLabel;

@end

@implementation XBDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.title = @"详情";
    
    [self setupSubViews];
}

#pragma mark - load Method
-(void)setupSubViews{
    
    UILabel *titleLable = [[UILabel alloc] init];
    titleLable.frame = CGRectMake(100, 87, 200, 30);
    titleLable.textColor = [UIColor blackColor];
    titleLable.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:titleLable];
    self.titleLabel = titleLable;
    
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.text = @"作者 : 无铭        时间 : 2017.3.1";
    nameLabel.textColor = [UIColor grayColor];
    nameLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:nameLabel];
    
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLable.mas_bottom).offset(20);
        make.centerX.equalTo(titleLable);
    }];
    
    UIImageView *imaeg = [[UIImageView alloc] init];
    imaeg.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:imaeg];
    self.icon = imaeg;
    
    [imaeg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameLabel.mas_bottom).offset(20);
        make.centerX.equalTo(titleLable);
        make.height.mas_equalTo(150);
        make.width.mas_equalTo(250);
    }];
    
    UILabel *contentLable = [[UILabel alloc] init];
    contentLable.textColor = [UIColor blackColor];
    contentLable.numberOfLines = 0;
    contentLable.textAlignment = NSTextAlignmentLeft;
    contentLable.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:contentLable];
    self.contentLabel = contentLable;
    
    [contentLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imaeg.mas_bottom).offset(30);
        make.left.equalTo(self).offset(30);
        make.right.equalTo(self).offset(30);
    }];
    
    [self setModel:self.model];

}


-(void)setModel:(ReadSecondListModel *)model
{
    _model = model;
    
    [self.icon sd_setImageWithURL:[NSURL URLWithString:model.coverimg]];
    self.titleLabel.text = model.title;
    self.contentLabel.text = [NSString stringWithFormat:@"%@ \n 年少轻狂的时候觉得总有一天老娘会征服星辰大海浩瀚宇宙，金融圈一提起就让众生瑟瑟发抖的大佬，不知道是第几轮惨绝人寰的金融危机席卷全球，一帮精英们束手无策最后小心翼翼的提出来，不如我们去请泰斗出山吧。﻿到头发现征途不过分析师桌上的报表和永远喝不完的酒。﻿", model.content];

}
@end
