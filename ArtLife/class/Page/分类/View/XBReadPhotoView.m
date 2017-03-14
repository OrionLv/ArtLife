//
//  XBReadPhotoView.m
//  ArtLife
//
//  Created by lxb on 2017/3/2.
//  Copyright © 2017年 lxb. All rights reserved.
//

#import "XBReadPhotoView.h"
#import "Masonry.h"
#import "XBReadListModel.h"
#import "UIImageView+WebCache.h"

@interface XBReadPhotoView ()



/**书名lable*/
@property (nonatomic, strong) UILabel *nameLabel;

/**作者名Lable*/
@property (nonatomic, strong) UILabel *ennameLabel;

@end

@implementation XBReadPhotoView
#pragma mark - 懒加载
- (UIImageView *)coverImageView{
    if(!_coverImageView){
        _coverImageView = [[UIImageView alloc] init];
        _coverImageView.contentMode = UIViewContentModeScaleAspectFit;
        
    }
    return _coverImageView;
}

-(UILabel *)nameLabel{
    if(!_nameLabel){
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.backgroundColor = [UIColor clearColor];
        _nameLabel.userInteractionEnabled = YES;
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.textColor = [UIColor whiteColor];
        _nameLabel.font = [UIFont systemFontOfSize:14];
    }
    return  _nameLabel;
}
- (UILabel *)ennameLabel{
    if(!_ennameLabel){
        _ennameLabel = [[UILabel alloc] init];
        _ennameLabel.backgroundColor = [UIColor clearColor];
        _ennameLabel.userInteractionEnabled = YES;
        _ennameLabel.textAlignment = NSTextAlignmentLeft;
        _ennameLabel.textColor = [UIColor whiteColor];
        _ennameLabel.font = [UIFont systemFontOfSize:11];
    }
    return _ennameLabel;
}

#pragma mark - load Method
-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self setupSubViews];
        [self setupAutoLayout];
    }
    return self;
}

#pragma mark - private Method
-(void)setupSubViews{
    [self addSubview:self.coverImageView];
    [self addSubview:self.nameLabel];
    [self addSubview:self.ennameLabel];
}

-(void)setupAutoLayout{
    
    CGFloat margin = 3;
    __weak typeof(self) weakself = self;
    [weakself.coverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.equalTo(weakself);
    }];
    
    [weakself.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.mas_left).offset(margin);
        make.bottom.equalTo(weakself.mas_bottom).offset(-margin);
        make.right.equalTo(weakself.ennameLabel.mas_left).offset(-margin);
        make.height.mas_equalTo(20);
    }];
    
    [weakself.ennameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.nameLabel.mas_right).offset(margin);
        make.right.equalTo(weakself.mas_right).offset(-margin);
        make.centerY.equalTo(weakself.nameLabel.mas_centerY);
        make.height.mas_equalTo(20);
    }];
 
}

#pragma mark - setter Method
//-(void)setModel:(XBReadListModel *)model
//{
//    _model = model;
//    
//    [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:_model.coverimg]];
//    
//    NSLog(@"%@", _model.coverimg);
//    if(self.coverImageView.image == nil){
//        self.coverImageView.image = [UIImage imageNamed:@"21.jpg"];
//    }
//    
//    self.nameLabel.text = model.name;
//    
//    self.ennameLabel.text = model.enname;
//}
@end
