//
//  OrderListModel.m
//  吾家超市
//
//  Created by iMac15 on 2016/11/22.
//  Copyright © 2016年 iMac15. All rights reserved.
//

#import "OrderListModel.h"

@implementation Area

@end

@implementation Coupons

@end

@implementation Member

@end

@implementation OrderItems

- (NSString *)price
{
    return [NSString stringWithFormat:@"%.2f", _price.floatValue];
}
@end

@implementation PaymentMethod

@end

@implementation ShippingMethod

@end

@implementation ShippingItemsModel

@end

@implementation ShippingsModel

+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"shippingItems":@"ShippingItemsModel",
             };
}
@end

@implementation OrderListModel

- (NSString *)amountPayable
{
    return [NSString stringWithFormat:@"%.2f", _amountPayable.floatValue];
}

- (NSString *)price
{
    return [NSString stringWithFormat:@"%.2f", _price.floatValue];
}

+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"orderItems":@"OrderItems",
             @"coupons":@"Coupons",
             @"shippings":@"ShippingsModel",
             @"skuAndNumList":@"SkuAndNumOrderListModel"
             };
}
@end


/**
 *  订单列表
 */

@implementation SkuAndNumOrderListModel

@end


@implementation OrderListResult

+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"t":@"OrderListModel"
             };
}
@end


/**
 *  订单详情
 */

@implementation OrderDetailsResult

@end


/**
 *  获取订单列表-参数
 */

@implementation OrderListParam

@end

/**
 *  获取我的优惠券
 */
@implementation CouponsListParam

@end



/**
 *  订单跟踪
 */
@implementation OrderTrackModel

@end

@implementation OrderTrackData

+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"orderTrack":@"OrderTrackModel"
             };
}
@end

@implementation OrderTrackResult

@end

