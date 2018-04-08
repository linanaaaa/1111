//
//  WJLibrary.h
//  吾家超市
//
//  Created by iMac15 on 2016/10/24.
//  Copyright © 2016年 iMac15. All rights reserved.
//

#ifndef WJLibrary_h
#define WJLibrary_h

#import <WebKit/WebKit.h>

/**
 *  常用工具类
 */
#include "UILabel+Utils.h"
#include "UIView+Utils.h"
#include "NSString+Utils.h"
#include "UIAlertView+Utils.h"
#include "UIActionSheet+Utils.h"
#include "UIColor+Utils.h"
#include "UIImage+Utils.h"
#include "NSObject+Utils.h"


/**
 *  base64
 */
#import "GTMBase64.h"

#import "NSString+Extension.h"
#import "UITextField+InputVerification.h"
#import "UITableViewCell+Extension.h"
#import "UIView+SplitLine.h"
#import "MBProgressHUD+WJ.h"
#import "WJAlertView.h"                 // 自定义AlertView
#import "WJRequestTool.h"
#import "WJInputTextField.h"
#import "WJFilletButton.h"

#import "TabBarController.h"
#import "BaseNavigationController.h"


/**
 *  宏定义
 */
#import "WJConstants.h"
#import "AppMacro.h"
#import "UtilsMacro.h"

/**
 *  第三方库
 */
#import "AFNetworking.h"
#import "IQKeyboardManager.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "UIImageView+WebCache.h"
#import "SDImageCache.h"

#import "MJChiBaoZiHeader.h"
#import "MJChiBaoZiFooter.h"
#import "MJChiBaoZiFooter2.h"

/**
 *  解决控制台显示 uin
 */
#import "NSArray+ZXPUnicode.h"
#import "NSDictionary+ZXPUnicode.h"
#import "NSObject+ZXPUnicode.h"

/**
 *  注册 登录model
 */
#import "ZNGSingleton.h"
#import "ZNGUser.h"

#import "LoginModel.h"

/**
 *  商品模型
 */
#import "GoodsModel.h"



#endif /* WJLibrary_h */
