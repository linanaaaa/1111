//
//  WJCountdownButton.h
//  吾家超市
//
//  Created by iMac15 on 2016/10/31.
//  Copyright © 2016年 iMac15. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WJCountdownButton : UIButton

+ (instancetype)countdownButtonWithSecond:(NSUInteger)second;
- (void)startCountdown;

@property (copy, nonatomic)   NSString *phoneNumber;
@property (assign, nonatomic) int type;
@property (assign, nonatomic) int generType;
@end
