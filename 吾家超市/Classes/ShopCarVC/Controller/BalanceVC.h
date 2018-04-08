//
//  BalanceVC.h
//  吾家超市
//
//  Created by iMac15 on 2016/12/20.
//  Copyright © 2016年 iMac15. All rights reserved.
//

#import "BaseVC.h"

typedef void (^BalanceBlock) (NSString *blance);

@interface BalanceVC : BaseVC
@property (strong, nonatomic) NSString *priceStr;
@property (strong, nonatomic) NSString *balanceTFStr;
@property (copy, nonatomic) BalanceBlock balanceBlock;
@end
