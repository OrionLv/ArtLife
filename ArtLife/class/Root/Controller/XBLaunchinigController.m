//
//  XBLaunchinigController.m
//  ArtLife
//
//  Created by lxb on 2017/3/7.
//  Copyright © 2017年 lxb. All rights reserved.
//

#import "XBLaunchinigController.h"
#import "Masonry.h"
#import "AFOwnerHTTPSessionManager.h"
#import "SVProgressHUD.h"
#import "XBAllControllers.h"

#define LAUNCHING_IMAGEVIEW_NAME @"launchingName"

#define HTTP_LAUNCH_SCREEN @"http://api2.pianke.me/pub/screen"

@interface XBLaunchinigController ()

/**背景图片*/
@property (nonatomic, strong) UIImageView *launchingBackgroundImage;

/**动画关键定时器*/
@property (nonatomic, strong) NSTimer *launchingTimer;

@end

@implementation XBLaunchinigController

#pragma mark - 懒加载
-(UIImageView *)launchingBackgroundImage{
    
    if(!_launchingBackgroundImage){
        _launchingBackgroundImage = [[UIImageView alloc] init];
        [_launchingBackgroundImage setFrame:self.view.frame];
        [_launchingBackgroundImage setBackgroundColor:[UIColor cyanColor]];
        [_launchingBackgroundImage setImage:[UIImage imageNamed:@"defaultCover"]];
    }
    return _launchingBackgroundImage;
}

#pragma mark - load Method
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupSubViews];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    //执行动画
    [UIView animateWithDuration:3.0 animations:^{
        
        CGRect rect = self.launchingBackgroundImage.frame;
        rect.origin = CGPointMake(-100, -100);
        rect.size = CGSizeMake(rect.size.width + 200, rect.size.height + 200);
        _launchingBackgroundImage.frame = rect;
        
    } completion:^(BOOL finished) {
        
        //动画结束直接进入主页
        [XBAllControllers createViewController];
    }];
    
}

#pragma mark - private Method
-(void)setupSubViews{
    
    //加载背景
    [self.view addSubview:self.launchingBackgroundImage];
    
    //先加载本地保存启动图
    [self loadLaunchingImageView];
    
    //向服务器放松请求，获取最新的Launching启动图，并保存到本地，方便下次启动的时候使用
    [self GetNewImageView];
    
}

-(void)loadLaunchingImageView{
    
    NSData *imageData = [[NSUserDefaults standardUserDefaults] objectForKey:LAUNCHING_IMAGEVIEW_NAME];
    
    if(imageData){
        
        self.launchingBackgroundImage.image = [UIImage imageWithData:imageData];
    }
}

-(void)GetNewImageView{
    
    [[AFOwnerHTTPSessionManager manager] postURL:HTTP_LAUNCH_SCREEN
                                      Parameters:@{
                                                   @"client" : @2
            } success:^(NSURLSessionDataTask *task, id responseObject) {
                
                //获取图片的url
                NSString *imageUrl = [[responseObject objectForKey:@"data"] objectForKey:@"picurl"];
                
                //获取图片的data
                NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
                
                //将获取的data本地保存到plist文件当中
                [[NSUserDefaults standardUserDefaults] setObject:imageData forKey:LAUNCHING_IMAGEVIEW_NAME];
                
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                
                //网络请求失败后的block回调
                [SVProgressHUD showErrorWithStatus:@"网络不给力，请检查网络设置"];
            }];
}


@end
