//
//  WJConstants.h
//  吾家超市
//
//  Created by iMac15 on 2016/10/24.
//  Copyright © 2016年 iMac15. All rights reserved.
//

#ifndef WJConstants_h
#define WJConstants_h


/**
 *  字体 字符串长度
 */

#define kFontSize(size)                         [UIFont systemFontOfSize:size]
#define kTextFont                               kFontSize(14.0)
#define kLineHeight(fontSize)                   [UIFont systemFontOfSize:fontSize].lineHeight
#define kDefaultLineHeight                      [UIFont systemFontOfSize:14.0].lineHeight

#define kSplitLineHeight                         1 / [UIScreen mainScreen].scale

#define kBoldFontSize(size)                     [UIFont boldSystemFontOfSize:size]
#define kBoldTextFont                           kBoldFontSize(14.0)

#define kTextSize(text, font, maxSize)          [text length] > 0 ? [text boundingRectWithSize:maxSize options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:font} context:nil].size : CGSizeZero;

#define kTextWidth(text, font, maxHeight)       [text length] > 0 ? [text boundingRectWithSize:CGSizeMake(MAXFLOAT, maxHeight) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:font} context:nil].size.width : 0;
#define kTextHeight(text, font, maxWidth)       [text length] > 0 ? [text boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT) options:(NSStringDrawingUsesLineFragmentOrigin) attributes: @{NSFontAttributeName:font} context:nil].size.height : 0;

#define kAttributedTextSize(text, maxSize)                    [text length] > 0 ? [text boundingRectWithSize:maxSize options:(NSStringDrawingUsesLineFragmentOrigin) context:nil].size : CGSizeZero;
#define kAttributedTextWidth(text, maxHeight)                 [text length] > 0 ? [text boundingRectWithSize:CGSizeMake(MAXFLOAT, maxHeight) options:(NSStringDrawingUsesLineFragmentOrigin) context:nil].size.width : 0;
#define kAttributedTextHeight(text, maxWidth)                 [text length] > 0 ? [text boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT) options:(NSStringDrawingUsesLineFragmentOrigin) context:nil].size.height : 0;

#define kDocPath                            NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject
#define kDataCache                  [kDocPath stringByAppendingPathComponent:@"DataCache.data"]

/**
 *  异地登录，退出登录状态 通知
 */
#define kLoginStatus @"user.login"


/**
 * block 防止循环引用
 */
#define kWeakSelf               __weak typeof(self) weakSelf = self;

//NSUserDefaults 实例化
#define kUSER_DEFAULT           [NSUserDefaults standardUserDefaults]

/**
*  the saving objects      存储对象
*
*  @param __VALUE__ V
*  @param __KEY__   K
*
*  @return
*/
#define kUserDefaultSetObjectForKey(__VALUE__,__KEY__) \
{\
[[NSUserDefaults standardUserDefaults] setObject:__VALUE__ forKey:__KEY__];\
[[NSUserDefaults standardUserDefaults] synchronize];\
}

/**
 *  get the saved objects       获得存储的对象
 */
#define kUserDefaultObjectForKey(__KEY__)  [[NSUserDefaults standardUserDefaults] objectForKey:__KEY__]

/**
 *  delete objects      删除对象
 */
#define kUserDefaultRemoveObjectForKey(__KEY__) \
{\
[[NSUserDefaults standardUserDefaults] removeObjectForKey:__KEY__];\
[[NSUserDefaults standardUserDefaults] synchronize];\
}

/**
 *       字典 数组 字符串 对象 ---是否为空?
 */

//字符串是否为空
#define kStringIsEmpty(str) ([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1 ? YES : NO )

//数组是否为空
#define kArrayIsEmpty(array) (array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0)

//字典是否为空
#define kDictIsEmpty(dic) (dic == nil || [dic isKindOfClass:[NSNull class]] || dic.allKeys == 0)

//是否是空对象
#define kObjectIsEmpty(_object) (_object == nil \
|| [_object isKindOfClass:[NSNull class]] \
|| ([_object respondsToSelector:@selector(length)] && [(NSData *)_object length] == 0) \
|| ([_object respondsToSelector:@selector(count)] && [(NSArray *)_object count] == 0))




#endif
