//
//  XBWebViewController.m
//  ArtLife
//
//  Created by lxb on 2017/3/2.
//  Copyright © 2017年 lxb. All rights reserved.
//

#import "XBWebViewController.h"
#import "XBLoadingView.h"
#import "SVProgressHUD.h"

@interface XBWebViewController ()<UIWebViewDelegate>

/**等待视图*/
@property (nonatomic, strong) XBLoadingView *waitView;
/**webView*/
@property (nonatomic, strong) UIWebView *webView;

@end

@implementation XBWebViewController

#pragma mark - 懒加载
-(UIWebView *)webView{
    if(!_webView){
        
        _webView = [[UIWebView alloc] init];
        _webView.frame =self.view.bounds;
        _webView.mediaPlaybackAllowsAirPlay = YES;
        _webView.mediaPlaybackRequiresUserAction = YES;
        _webView.delegate = self;
        _webView.scrollView.bounces = NO;
    }
    
    return _webView;
}

#pragma mark - 加载视图
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.webView];
}

#pragma mark - private Method
-(void)setUrl:(NSString *)url{
    
    _url = url;
    NSString *newUrl = [NSString stringWithFormat:@"http://%@", url];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:newUrl]];
    [self.webView loadRequest:request];
}

#pragma mark - UIWebViewDelegate
- (void)webView:(UIWebView *)webView didFailLoadWithError:(nonnull NSError *)error{
    
    [self.waitView dismiss];
    [SVProgressHUD showErrorWithStatus:@"网络不给力,请稍后再试"];
    NSLog(@"%@", error);
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [self.waitView dismiss];
}

@end
