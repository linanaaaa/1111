//
//  WJFilletButton.h
//  吾家超市
//
//  Created by iMac15 on 2016/10/25.
//  Copyright © 2016年 iMac15. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WJFilletButton : UIButton
+ (instancetype)filletButtonWithTittle:(NSString *)title;
+ (instancetype)customButtonWithTittle:(NSString *)title;
+ (instancetype)lineButtonWithTittle:(NSString *)title;
@end
