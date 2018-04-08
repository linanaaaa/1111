//
//  UIFont+Extension.m
//  吾家超市
//
//  Created by iMac15 on 2016/10/24.
//  Copyright © 2016年 iMac15. All rights reserved.
//

#import "UIFont+Extension.h"

@implementation UIFont (Extension)
+ (void)load
{
    Method imp = class_getClassMethod([self class], @selector(systemFontOfSize:));
    Method myImp = class_getClassMethod([self class], @selector(myFontOfSize:));
    method_exchangeImplementations(imp, myImp);
}

+ (UIFont *)myFontOfSize:(CGFloat)fontSize
{
    return [UIFont myFontOfSize:14.0];
//    return [UIFont fontWithName:@"Microsoft YaHei" size:fontSize];
}
@end
