//
//  WebUrlVC.m
//  吾家超市
//
//  Created by iMac15 on 2016/12/19.
//  Copyright © 2016年 iMac15. All rights reserved.
//

#import "WebUrlVC.h"

@interface WebUrlVC ()<UIWebViewDelegate>
@property (strong, nonatomic) UIWebView * webView;
@end

@implementation WebUrlVC

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.webView.frame = self.view.bounds;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"广告位";
    [self.view addSubview:self.webView];
    
    if (self.urlStr.length == 0) {
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://m.wujiaw.com"]]];
    }
    else{
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlStr]]];
    }
    
    self.webView.backgroundColor = kGlobalBackgroundColor;
}

- (void)popVC
{
    if (self.webView.canGoBack) {
        [self.webView goBack];
    }
    else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - UIWebViewDelegate
- (UIWebView *)webView
{
    if (_webView == nil) {
        _webView = [UIWebView new];
        _webView.delegate = self;
    }
    return _webView;
}

@end
