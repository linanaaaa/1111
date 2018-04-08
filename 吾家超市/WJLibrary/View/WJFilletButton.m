//
//  WJFilletButton.m
//  吾家超市
//
//  Created by iMac15 on 2016/10/25.
//  Copyright © 2016年 iMac15. All rights reserved.
//

#import "WJFilletButton.h"

@implementation WJFilletButton

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.layer.cornerRadius = 4;
    self.layer.masksToBounds = YES;
    self.titleLabel.font = kTextFont;
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    
    [self setBackgroundImage:[UIImage imageWithColor:kGlobalRedColor] forState:UIControlStateNormal];
    
    [self setBackgroundImage:[UIImage imageWithColor:kBtnHighlightedColor] forState:UIControlStateHighlighted];
    
    [self setBackgroundImage:[UIImage imageWithColor:kBtnDisabledColor] forState:UIControlStateDisabled];
}

+ (instancetype)filletButtonWithTittle:(NSString *)title
{
    WJFilletButton *button = [WJFilletButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    
    button.layer.cornerRadius = 2;
    button.layer.masksToBounds = YES;
    button.titleLabel.font = kFontSize(15.0);
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    
    [button setBackgroundImage:[UIImage imageWithColor:kGlobalRedColor] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageWithColor:kBtnHighlightedColor] forState:UIControlStateHighlighted];
    
    [button setBackgroundImage:[UIImage imageWithColor:kBtnDisabledColor] forState:UIControlStateDisabled];
    
    return button;
}

+ (instancetype)customButtonWithTittle:(NSString *)title
{
    WJFilletButton *button = [WJFilletButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    
//    button.layer.cornerRadius = 6;
//    button.layer.masksToBounds = YES;
    button.titleLabel.font = kFontSize(15.0);
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    
    [button setBackgroundImage:[UIImage imageWithColor:kGlobalRedColor] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageWithColor:kBtnHighlightedColor] forState:UIControlStateHighlighted];
    
    [button setBackgroundImage:[UIImage imageWithColor:kBtnDisabledColor] forState:UIControlStateDisabled];
    
    return button;
}


+ (instancetype)lineButtonWithTittle:(NSString *)title
{
    WJFilletButton *button = [WJFilletButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:title forState:UIControlStateNormal];
    button.layer.cornerRadius = 4;
    button.layer.masksToBounds = YES;
    button.titleLabel.font = kTextFont;
    button.layer.borderColor = kGlobalLineColor.CGColor;
    [button setTitleColor:kGlobalTextColor forState:UIControlStateNormal];
    button.layer.borderWidth = kSplitLineHeight;
    
    return button;
}


@end
