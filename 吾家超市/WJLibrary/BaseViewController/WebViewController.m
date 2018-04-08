//
//  WebViewController.m
//  吾家超市
//
//  Created by iMac15 on 2016/10/24.
//  Copyright © 2016年 iMac15. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController () <UIWebViewDelegate>
@property(nonatomic, strong)UIWebView *webView;
@property(nonatomic, strong)NSURLRequest *request;
@end

@implementation WebViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)setUrl:(NSString *)url
{
//    _url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    _url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    _request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:_url]];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.webView loadRequest:self.request];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(closeVC)];
}

- (void)closeVC
{
    if (self.navigationController.viewControllers.count > 1) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
}

- (UIWebView *)webView
{
    if (_webView == nil) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH - 64)];
        _webView.scalesPageToFit = YES;
        _webView.delegate = self;
        [self.view addSubview:_webView];
    }
    return _webView;
}
@end
