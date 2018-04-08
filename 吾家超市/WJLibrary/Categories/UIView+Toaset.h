//
//  UIView+Toaset.h
//  吾家超市
//
//  Created by iMac15 on 2016/10/24.
//  Copyright © 2016年 iMac15. All rights reserved.
//

#import <Foundation/Foundation.h>

#define DEFAULT_DISPLAY_DURATION 2.0f

@interface UIView_Toaset : NSObject

+ (void)showWithText:(NSString *)text inView:(UIView *)view;
+ (void)showWithText:(NSString *)text inView:(UIView *)view duration:(CGFloat)duration;

+ (void)showWithText:(NSString *)text inView:(UIView *)view topOffset:(CGFloat) topOffset;
+ (void)showWithText:(NSString *)text inView:(UIView *)view topOffset:(CGFloat) topOffset duration:(CGFloat) duration;

+ (void)showWithText:(NSString *)text inView:(UIView *)view bottomOffset:(CGFloat) bottomOffset;
+ (void)showWithText:(NSString *)text inView:(UIView *)view bottomOffset:(CGFloat) bottomOffset duration:(CGFloat) duration;

@end
