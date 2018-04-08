//
//  UtilsMacro.h
//  Eventor
//
//  Created by guojiang on 14-5-13.
//  Copyright (c) 2014年 DaCheng. All rights reserved.
//

#ifndef Eventor_UtilsMacro_h
#define Eventor_UtilsMacro_h


/**
 *  代码简写
 */
#pragma mark -代码简写

//获取屏幕宽度与高度
#define kScreenBounds                           [UIScreen mainScreen].bounds

#define kScreenW                                [UIScreen mainScreen].bounds.size.width
#define kScreenH                                [UIScreen mainScreen].bounds.size.height

#define AppVersionNumber                        [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#define AppName                                 [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString*)kCFBundleNameKey]
#define DeviceName                              [[UIDevice currentDevice] name]
#define DeviceModel                             [[UIDevice currentDevice] systemName]
#define URLFromString(str)                      [NSURL URLWithString:str]
#define StringFormat(str)                       [NSString stringWithFormat:@"%@",str]

#pragma mark - Redefine

#define ApplicationDelegate                 ((AppDelegate *)[[UIApplication sharedApplication] delegate])
#define SharedApplication                   [UIApplication sharedApplication]

#define ShowNetworkActivityIndicator()      [UIApplication sharedApplication].networkActivityIndicatorVisible = YES
#define HideNetworkActivityIndicator()      [UIApplication sharedApplication].networkActivityIndicatorVisible = NO
#define NetworkActivityIndicatorVisible(x)  [UIApplication sharedApplication].networkActivityIndicatorVisible = x
#define SelfNavBar                          self.navigationController.navigationBar
#define SelfTabBar                          self.tabBarController.tabBar
#define SelfNavBarHeight                    self.navigationController.navigationBar.bounds.size.height
#define SelfTabBarHeight                    self.tabBarController.tabBar.bounds.size.height

#define Rect(x, y, w, h)                    CGRectMake(x, y, w, h)
#define DATE_COMPONENTS                     NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit
#define TIME_COMPONENTS                     NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit
#define FlushPool(p)                        [p drain]; p = [[NSAutoreleasePool alloc] init]

#define iOSVersion                          [UIDevice currentDevice].systemVersion.floatValue
#define IsiOS7Later                         (IOSVersion >= 7.0)
#define IsiOS8Later                         (IOSVersion >= 8.0)

#define Size(w, h)                          CGSizeMake(w, h)
#define Point(x, y)                         CGPointMake(x, y)
#define IntNumber(i)                        [NSNumber numberWithInt:i]
#define IntegerNumber(i)                    [NSNumber numberWithInteger:i]
#define FloatNumber(f)                      [NSNumber numberWithFloat:f]
#define DoubleNumber(dl)                    [NSNumber numberWithDouble:dl]
#define BoolNumber(b)                       [NSNumber numberWithBool:b]

#define StringNotEmpty(str)                 (str && (str.length > 0))
#define ArrayNotEmpty(arr)                  (arr && (arr.count > 0))


//APP版本号
#define kAppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
//系统版本号
#define kSystemVersion [[UIDevice currentDevice] systemVersion]
//获取当前语言
#define kCurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])
//判断是否为iPhone
#define kISiPhone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
//判断是否为iPad
#define kISiPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

//获取沙盒Document路径
#define kDocumentPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]
//获取沙盒temp路径
#define kTempPath NSTemporaryDirectory()
//获取沙盒Cache路径
#define kCachePath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]

//由角度转换弧度
#define kDegreesToRadian(x)      (M_PI * (x) / 180.0)
//由弧度转换角度
#define kRadianToDegrees(radian) (radian * 180.0) / (M_PI)

//获取一段时间间隔
#define kStartTime CFAbsoluteTime start = CFAbsoluteTimeGetCurrent();
#define kEndTime   NSLog(@"Time: %f", CFAbsoluteTimeGetCurrent() - start)


#endif
