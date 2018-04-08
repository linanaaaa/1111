//
//  BaseNavigationController.h
//  吾家超市
//
//  Created by iMac15 on 2016/10/24.
//  Copyright © 2016年 iMac15. All rights reserved.
//

#import "BaseNavigationController.h"


@interface BaseNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation BaseNavigationController

+ (void)initialize
{
    [self setupNavBar];
    [self setupBarButtonItem];
}

//重写自定义的UINavigationController中的push方法
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count==1) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    [super pushViewController:viewController animated:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.interactivePopGestureRecognizer.delegate = self;
    
    if (IS_IPHONE_X) {
        
    }
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if (self.childViewControllers.count == 1) {
        return NO;
    }else{
        return YES;
    }
}

+ (void)setupNavBar
{
    UINavigationBar *navBar = [UINavigationBar appearance];
    
    navBar.tintColor = kGlobalTextColor;
    
    // 3.设置文字样式
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = kGlobalTextColor;
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowOffset = CGSizeZero;
    attrs[NSShadowAttributeName] = shadow;
    attrs[NSFontAttributeName] = [UIFont boldSystemFontOfSize:14.0];
    [navBar setTitleTextAttributes:attrs];
    
    [navBar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];
    navBar.shadowImage = [UIImage new];
    
    
//    navBar.backIndicatorImage = [UIImage imageNamed:@"backIco"];
//    navBar.backIndicatorTransitionMaskImage = [UIImage imageNamed:@"backIco_heighlight"];

}

+ (void)setupBarButtonItem
{
//    UIBarButtonItem *item = [UIBarButtonItem appearance];
//    item.tintColor = kGlobalRedColor;
}
@end
