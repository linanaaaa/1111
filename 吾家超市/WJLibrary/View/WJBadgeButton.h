//
//  WJBadgeButton.h
//  吾家超市
//
//  Created by iMac15 on 2016/10/26.
//  Copyright © 2016年 iMac15. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    BadgeButtonStyleDefault,
    BadgeButtonStyleTopImage
} BadgeButtonStyle;

@interface WJBadgeButton : UIButton
@property(nonatomic, copy)NSString *badgeValue;
@property (assign, nonatomic) BOOL appressTitle;
@property (assign, nonatomic) BOOL hideBadgeValue;
@property (assign, nonatomic) BadgeButtonStyle style;
@end
