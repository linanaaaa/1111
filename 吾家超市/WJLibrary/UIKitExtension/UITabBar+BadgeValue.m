//
//  UITabBar+BadgeValue.m
//  吾家超市
//
//  Created by iMac15 on 2016/10/24.
//  Copyright © 2016年 iMac15. All rights reserved.
//

#import "UITabBar+BadgeValue.h"

@implementation UITabBar (BadgeValue)
- (void)showBadgeValue:(NSString *)value atIndex:(NSInteger) index {
    
    UILabel *label = [self badgeValueLabelAtIndex:index + 100];
    
    if (label == nil) {
        label = [[UILabel alloc] init];
        label.tag = index + 100;
        label.textColor = [UIColor whiteColor];
        label.backgroundColor = kGlobalRedColor;
        label.font = kFontSize(10.0);
        label.textAlignment = NSTextAlignmentCenter;
        label.layer.masksToBounds = YES;
        
        label.frame = CGRectMake(ceilf((index + 0.5) / 3 * self.frame.size.width), ceilf(self.frame.size.height * 0.1), 24, 15);
        
        label.layer.cornerRadius = 15 * 0.5;
        
        [self addSubview:label];
    }
    

    if (value.integerValue > 99) {
        value = @"99+";
    }
    
    label.text = value;

    if (value.integerValue <= 0) {
        label.hidden = YES;
        return;
    }
    else {
        label.hidden = NO;
    }
}

- (UILabel *)badgeValueLabelAtIndex:(NSInteger)index
{
    
    for (UILabel *label in self.subviews) {
        if (label.tag == index) {
            return label;
        }
    }
    return nil;
}
@end
