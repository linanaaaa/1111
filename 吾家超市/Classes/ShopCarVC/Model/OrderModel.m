//
//  OrderModel.m
//  吾家超市
//
//  Created by iMac15 on 2016/11/18.
//  Copyright © 2016年 iMac15. All rights reserved.
//

#import "OrderModel.h"


@implementation ShippingMethodsModel

@end


@implementation PaymentMethodsModel

@end


@implementation AreaModel

@end

@implementation DefaultReceiverModel

@end



@implementation CouponCodeListModel

@end


@implementation OrderMemberModel

@end

@implementation CouponsModel

@end

@implementation OrderItemsModel

- (NSString *)price
{
    return [NSString stringWithFormat:@"%.2f", _price.floatValue];
}

@end


@implementation OrderModel

- (NSString *)amountPaid
{
    return [NSString stringWithFormat:@"%.2f", _amountPaid.floatValue];
}

- (NSString *)price
{
    return [NSString stringWithFormat:@"%.2f", _price.floatValue];
}

- (NSString *)amountPayable
{
    return [NSString stringWithFormat:@"%.2f", _amountPayable.floatValue];
}

+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"coupons":@"CouponsModel",
             @"orderItems":@"OrderItemsModel",
             };
}

@end

@implementation OrderData
+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"order":@"OrderModel",
             };
}
@end

@implementation OrderResult

+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"shippingMethods":@"shippingMethodsModel"
             };
}

@end

/**
 *  生成订单
 */
@implementation OrderSuccessMember

@end

@implementation OrderSuccessArea

@end

@implementation OrderSuccessModel

+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"coupons":@"CouponsModel",
             @"orderItems":@"OrderItemsModel"
             };
}
@end


@implementation OrderSuccessResult

+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"t":@"OrderModel"
             };
}
@end



/**
 *  优惠券
 */

@implementation CouponsData

@end

@implementation CouponResult

@end

/**
 *  商品是否可售
 */
@implementation OrderAddressGoodsModel

@end

@implementation OrderAddressGoodsResult

+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"t":@"OrderAddressGoodsModel",
             };
}
@end
