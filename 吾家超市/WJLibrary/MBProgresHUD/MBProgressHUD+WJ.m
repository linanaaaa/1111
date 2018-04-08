//
//  MBProgressHUD+ZNG.m
//  吾家超市
//
//  Created by iMac15 on 2016/10/24.
//  Copyright © 2016年 iMac15. All rights reserved.
//

#import "MBProgressHUD+WJ.h"

#define MESSAGE_HIDE_TIME 2

@implementation MBProgressHUD (WJ)

+ (UIView *)currentView
{
    UIViewController * rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    UIViewController *currentVC;
    
    UIView *view;

    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabBarVC = (UITabBarController *)rootVC;
        UINavigationController *nav = (UINavigationController *)tabBarVC.selectedViewController;
        currentVC = nav.topViewController;
    }
    else if ([rootVC isKindOfClass:[UINavigationController class]]) {
        UINavigationController *nav = (UINavigationController *)rootVC;
        
        if ([nav.topViewController isKindOfClass:[UITabBarController class]]) {
            UITabBarController *tabBarVC = (UITabBarController *)nav.topViewController;
            UINavigationController *childNav = (UINavigationController *)tabBarVC.selectedViewController;
            currentVC = childNav.topViewController;
        }
        else {
            currentVC = nav.topViewController;
        }
    }
    else {
        currentVC = rootVC;
    }
    
    while (currentVC.presentedViewController) {
        currentVC = currentVC.presentedViewController;
    }
    
    if ([currentVC isKindOfClass:[UINavigationController class]]) {
        UINavigationController *nav = (UINavigationController *)currentVC;
        currentVC = nav.topViewController;

    }
    view = currentVC.view;
    
    return view;
}

+ (void)showTextMessage:(NSString *)message
{
    return [self showTextMessage:message toView:[self currentView] hideAfter:MESSAGE_HIDE_TIME];
}

+ (void)showTextMessage:(NSString *)message hideAfter:(NSUInteger)after
{
    return [self showTextMessage:message toView:[self currentView] hideAfter:after];
}

+ (void)showTextMessage:(NSString *)message toView:(UIView *)view
{
    return [self showTextMessage:message toView:view hideAfter:MESSAGE_HIDE_TIME];
}

+ (void)showTextMessage:(NSString *)message toView:(UIView *)view hideAfter:(NSUInteger)after
{
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];

    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.detailsLabelText = message;
    hud.detailsLabelFont = [UIFont systemFontOfSize:14.0];

    hud.margin = 15;
    hud.dimBackground = NO;

    hud.mode = MBProgressHUDModeText;
    
    hud.removeFromSuperViewOnHide = YES;
    
    hud.dimBackground = NO;
    
    [hud hide:YES afterDelay:after];
}

+ (void)showLoadingMessage
{
    [self showLoadingMessage:@"火速处理中..."];
}

+ (void)showLoadingMessage:(NSString *)message
{
    [self showLoadingMessage:message toView:[self currentView]];
}

+ (void)showLoadingMessage:(NSString *)message toView:(UIView *)view
{
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    
    /*
     // 文本框和其相关属性
     @property (copy) NSString *labelText;
     @property (MB_STRONG) UIFont* labelFont;
     @property (MB_STRONG) UIColor* labelColor;
     
     //详情文本框和其相关属性
     @property (copy) NSString *detailsLabelText;
     @property (MB_STRONG) UIFont* detailsLabelFont;
     @property (MB_STRONG) UIColor* detailsLabelColor;
     
     // 背景框的透明度，默认值是0.8
     @property (assign) float opacity;
     // 背景框的颜色, 如果设置了这个属性，则opacity属性会失效，即不会有半透明效果
     @property (MB_STRONG) UIColor *color;
     // 背景框的圆角半径。默认值是10.0
     @property (assign) float cornerRadius;
     // 菊花的颜色，默认是白色
     @property (MB_STRONG) UIColor *activityIndicatorColor;
     
     另外还有一个比较有意思的属性是dimBackground，用于为HUD窗口的视图区域覆盖上一层径向渐变(radial gradient)层，其定义如下：
     */
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.detailsLabelText = message;
    hud.detailsLabelFont = [UIFont systemFontOfSize:14.0];
    hud.detailsLabelColor = [UIColor darkGrayColor];
    hud.activityIndicatorColor = kGlobalRedColor;
    hud.dimBackground = NO;
    hud.color = [UIColor clearColor];
    hud.removeFromSuperViewOnHide = YES;
}

+ (void)hideHUD
{
    [self hideHUDForView:[self currentView]];
}

+ (void)hideHUDForView:(UIView *)view
{
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    [self hideHUDForView:view animated:YES];
}
@end
