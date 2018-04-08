//
//  BaseVC.m
//  吾家超市
//
//  Created by iMac15 on 2016/10/24.
//  Copyright © 2016年 iMac15. All rights reserved.
//

#import "BaseVC.h"

@implementation BaseVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (![self.parentViewController isKindOfClass:NSClassFromString(@"HomeVC")]) {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

#pragma mark -返回上一页
- (void)popVC
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.view.backgroundColor = [UIColor whiteColor];

    if (self.navigationController.viewControllers.count > 1) {
        UIBarButtonItem *backButotn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(popVC)];
        
        [backButotn setImageInsets:UIEdgeInsetsMake(0, -5, 0, 0)];
        
        self.navigationItem.leftBarButtonItem = backButotn;
    }
    
}

- (void)dealloc
{
    WJLog(@"销毁%@", self.title);
}

@end
