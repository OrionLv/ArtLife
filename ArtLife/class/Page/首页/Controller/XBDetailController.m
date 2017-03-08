//
//  XBDetailController.m
//  ArtLife
//
//  Created by lxb on 2017/3/6.
//  Copyright © 2017年 lxb. All rights reserved.
//

#import "XBDetailController.h"
#import "XBLoadingView.h"
#import "SVProgressHUD.h"

@interface XBDetailController ()<UIWebViewDelegate>

/**
 *  webView
 */
@property (nonatomic, strong) UIWebView *webView;

/**loadding*/
@property (nonatomic, strong) XBLoadingView *waitView;

@end

@implementation XBDetailController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"攻略详情";
    [self.view addSubview:self.webView];
    // 加载数据
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.item.content_url]]];
}

#pragma mark - lazy load

- (UIWebView *)webView {
    
    if(!_webView) {
        UIWebView *web = [[UIWebView alloc] init];
        web.frame = self.view.bounds;
        web.scalesPageToFit = YES;
        web.dataDetectorTypes = UIDataDetectorTypeAll;
        web.delegate = self;
        _webView = web;
    }
    
    return _webView;
}

#pragma mark - <UIWebViewDelegate>

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    self.waitView = [[XBLoadingView alloc] initWithFrame:self.view.bounds];
    [self.waitView showLoadingTo:self.view];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.waitView dismiss];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [self.waitView dismiss];
    [SVProgressHUD showErrorWithStatus:@"出错啦~"];
}


@end
