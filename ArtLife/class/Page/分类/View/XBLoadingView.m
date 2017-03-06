//
//  XBLoadingView.m
//  ArtLife
//
//  Created by lxb on 2017/3/2.
//  Copyright © 2017年 lxb. All rights reserved.
//

#import "XBLoadingView.h"

@interface XBLoadingView ()

/**缓冲动画的数组*/
@property (nonatomic, strong) NSMutableArray *loadImage;
/**播放动画的imageView*/
@property (nonatomic, strong) UIImageView *loadImageView;

@end

@implementation XBLoadingView

#pragma mark - 懒加载
-(NSMutableArray *)loadImage
{
    if(!_loadImage){
        _loadImage = [[NSMutableArray alloc] init];
    }
    return _loadImage;
}

#pragma mark - load Method
-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self setupSubViews];
    }
    return self;
}

#pragma mark - private Method
-(void)setupSubViews{
    
}

-(void)creatLoadImage{
    
    //创建显示文字
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(135, 460, 100, 30);
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:15];
    label.text = @"";
    [self addSubview:label];
    
    //创建图片动画
    self.loadImageView = [[UIImageView alloc] init];
    CGRect rect = CGRectMake(self.center.x - 30, self.center.y - 30, 60, 60);
    self.loadImageView.frame = rect;
    [self addSubview:self.loadImageView];
    
    //加载图片
    if(self.loadImage.count == 0){
        for(int i = 0; i < 28; i ++){
            
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"refresh%d", i]];
            [self.loadImage addObject:image];
        }
    }
    
    //设置动画的
    self.loadImageView.animationImages = self.loadImage;
    self.loadImageView.animationRepeatCount = 0;
    self.loadImageView.animationDuration = 2.5;
    
    [self.loadImageView startAnimating];
}

#pragma mark - public Method
-(void)showLoadingTo:(UIView *)view{
    
    self.backgroundColor = [UIColor whiteColor];
    //播放加载动画
    [self creatLoadImage];
    
    [view addSubview:self];
}

//停止动画
-(void)dismiss{
    self.loadImage = nil;
    self.loadImageView.animationImages = nil;
    [self.loadImageView removeFromSuperview];
    [self removeFromSuperview];
}

-(void)showLoadingViewTo:(UIWindow *)window{
    
    self.backgroundColor = [UIColor blackColor];
    
    //播放加载动画
    [self creatLoadImage];
    
    [window addSubview:self];
}

@end
