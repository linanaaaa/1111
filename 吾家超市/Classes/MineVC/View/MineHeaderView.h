//
//  MineHeaderView.h
//  吾家超市
//
//  Created by iMac15 on 2016/10/26.
//  Copyright © 2016年 iMac15. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^LoginClick)();

@interface MineHeaderView : UIView
@property (strong, nonatomic) UIImageView *headerImage;
@property (strong, nonatomic) NSString *balanceMineStr;
@property (strong, nonatomic) NSString *catibalMineStr;
@property (strong, nonatomic) NSString *loginNameStr;
@property (copy, nonatomic) LoginClick loginClik;
@end
