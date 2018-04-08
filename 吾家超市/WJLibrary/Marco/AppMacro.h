//
//  AppMarco.h
//  Eventor
//
//  Created by guojiang on 14-5-13.
//  Copyright (c) 2014年 DaCheng. All rights reserved.
//

#ifndef Eventor_AppMarco_h
#define Eventor_AppMarco_h


/**
 *  u颜色
 */
#pragma mark -颜色相关

#define kClearColor [UIColor clearColor]     //清除背景色

#define kTransparentColor(r, g, b, a)       [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]                                                         // 透明色

#define kColor(r, g, b)                     kTransparentColor(r, g, b, 1.0) // 不透明色

#define kRandomColor                        kColor(arc4random_uniform(255), arc4random_uniform(255), arc4random_uniform(255))                                                // 随机色

#define kGlobalBackColor                    kColor(63, 63, 63)              // 全局黑色
#define kGlobalBackgroundColor              kColor(238, 238, 238)           // 全局背景色
#define kGrayBackgroundColor                kColor(240, 241, 242)           // 全局背景色-灰色

#define kGlobalRedColor                     kColor(228, 38, 22)             // 按钮全局红色
#define kBtnHighlightedColor                kColor(241, 72, 72)             // 按钮选中高亮时颜色
#define kBtnDisabledColor                   kColor(170, 170, 170)           // 按钮不可点击时颜色
#define kGlobalLineColor                    kColor(221, 221, 221)           // 分割线、描边颜色
#define kGlobalTextColor                    kColor(102, 102, 102)           // 全局文本颜色
#define kGlobalHighlightTextColor           kColor(51, 51, 51)              // 高亮显示文本颜色

#define kColorWithHex(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0 \
green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0 \
blue:((float)(rgbValue & 0xFF)) / 255.0 alpha:1.0]


/**
 *  Fram有关的宏
 */

// 下拉刷新 分页数量
#define kPageSize 10

// 左边距
#define kLeftMargin       10
// 上间距
#define KTopMargin        10
// 右边距
#define KRightMargin      10
// 底边距
#define KbootomMargin     10
// 行高
#define KHightMargin       20
// 行距
#define KWidthMargin       kScreenW - 20
// 边距 x2
#define KGlobalMargin2x     20

#define kNavigationBarHeight                64
#define kTabbarHeight                        49

/**
 *  界面有关的宏
 */
#pragma mark -界面有关的宏

#define SIZE_TextSmall                          10.0f
#define SIZE_TextContentNormal                  13.0f
#define SIZE_TextTitleMini                      15.0f
#define SIZE_TextTitleNormal                    17.0f
#define SIZE_TextTitleLarge                     20.0f
#define SIZE_TextLarge                          16.0f
#define SIZE_TextHuge                           18.0f

/**
 *  屏幕尺寸
 */

#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

#define __kScreenHeight ([[UIScreen mainScreen]bounds].size.height)
#define __kScreenWidth ([[UIScreen mainScreen]bounds].size.width)
#define SCREEN_MAX_LENGTH (MAX(__kScreenWidth, __kScreenHeight))
#define SCREEN_MIN_LENGTH (MIN(__kScreenWidth, __kScreenHeight))

#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6_7_8 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P_7P_8P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)
#define IS_IPHONE_X (IS_IPHONE && SCREEN_MAX_LENGTH == 1218.0)

#endif
