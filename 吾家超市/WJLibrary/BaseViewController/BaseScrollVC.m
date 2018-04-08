//
//  BaseScrollVC.m
//  吾家超市
//
//  Created by iMac15 on 2016/10/24.
//  Copyright © 2016年 iMac15. All rights reserved.
//

#import "BaseScrollVC.h"

@interface BaseScrollVC ()

@end

@implementation BaseScrollVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = YES;
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH - kNavigationBarHeight)];
    self.scrollView.backgroundColor = [UIColor clearColor];
    self.scrollView.bounces = YES;
    self.scrollView.alwaysBounceVertical = YES;
    self.scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.scrollView];
    
    self.container = [[UIView alloc] initWithFrame:self.scrollView.bounds];
    self.container.backgroundColor = [UIColor clearColor];
    [self.scrollView addSubview:self.container];
}

@end
