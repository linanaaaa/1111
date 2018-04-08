//
//  CouponVC.h
//  吾家超市
//
//  Created by iMac15 on 2016/12/20.
//  Copyright © 2016年 iMac15. All rights reserved.
//

#import "BaseVC.h"

typedef void(^CouponBlock) (NSString *couponStr);

@interface CouponVC : BaseVC

@property (copy, nonatomic) CouponBlock couponBlock;
@end
