//
//  MBProgressHUD+ZNG.h
//  吾家超市
//
//  Created by iMac15 on 2016/10/24.
//  Copyright © 2016年 iMac15. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (WJ)

+ (UIView *)currentView;

+ (void)showLoadingMessage;

+ (void)showLoadingMessage:(NSString *)message;

+ (void)showLoadingMessage:(NSString *)message toView:(UIView *)view;

+ (void)showTextMessage:(NSString *)message;

+ (void)showTextMessage:(NSString *)message hideAfter:(NSUInteger)after;

+ (void)showTextMessage:(NSString *)message toView:(UIView *)view;

+ (void)hideHUD;

+ (void)hideHUDForView:(UIView *)view;

@end
