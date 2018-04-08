//
//  OrderAddressFrame.h
//  吾家超市
//
//  Created by iMac15 on 2016/11/18.
//  Copyright © 2016年 iMac15. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OrderModel.h"

@interface OrderAddressFrame : NSObject

@property (strong, nonatomic) DefaultReceiverModel *dataModel;
@property (assign, nonatomic) CGRect nameF;
@property (assign, nonatomic) CGRect phoneF;
@property (assign, nonatomic) CGRect addressF;
@property (assign, nonatomic) CGRect titleF;
@property (assign, nonatomic) CGFloat cellHeight;
@end
