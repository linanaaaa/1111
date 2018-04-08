//
//  UIButton+Extension.m
//  吾家超市
//
//  Created by iMac15 on 2016/10/24.
//  Copyright © 2016年 iMac15. All rights reserved.
//

#import "UIButton+Extension.h"

@implementation UIButton (Extension)

+ (instancetype)hollowBtnWithTitle:(NSString *)title
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:kGlobalTextColor forState:UIControlStateNormal];
    
    button.titleLabel.font = kTextFont;

    button.layer.cornerRadius = 4;
    button.layer.masksToBounds = YES;
    button.layer.borderWidth = kSplitLineHeight;
    button.layer.borderColor = kGlobalTextColor.CGColor;
    return button;
}

@end
