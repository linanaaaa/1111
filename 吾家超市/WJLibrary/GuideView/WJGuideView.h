//
//  WJGuideView.h
//  吾家超市
//
//  Created by iMac15 on 2017/2/7.
//  Copyright © 2017年 iMac15. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface WJGuideView : NSObject

@property (strong, nonatomic) UIWindow *window;

/**
 *  创建单例模式
 *
 *  @return 单例
 */
+ (instancetype)sharedInstance;

/**
 *  引导页图片
 *
 *  @param images      引导页图片
 *  @param title       按钮文字
 *  @param titleColor  文字颜色
 *  @param bgColor     按钮背景颜色
 *  @param borderColor 按钮边框颜色
 */
- (void)showGuideViewWithImages:(NSArray *)images
                 andButtonTitle:(NSString *)title
            andButtonTitleColor:(UIColor *)titleColor
               andButtonBGColor:(UIColor *)bgColor
           andButtonBorderColor:(UIColor *)borderColor;

@end
