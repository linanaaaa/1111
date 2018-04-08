//
//  OrderModel.h
//  吾家超市
//
//  Created by iMac15 on 2016/11/18.
//  Copyright © 2016年 iMac15. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 *  购物方式
 */

@interface ShippingMethodsModel : NSObject
@property (copy,   nonatomic) NSString *createDate;
@property (copy,   nonatomic) NSString *id;
@property (copy,   nonatomic) NSString *modifyDate;
@property (copy,   nonatomic) NSString *order;
@end


/**
 *  付款方式
 */

@interface PaymentMethodsModel : NSObject
@property (copy,   nonatomic) NSString *createDate;
@property (copy,   nonatomic) NSString *id;
@property (copy,   nonatomic) NSString *modifyDate;
@property (copy,   nonatomic) NSString *order;
@end


/**
 *  收货地址
 */

//地址id
@interface AreaModel : NSObject
@property (copy,   nonatomic) NSString *createDate;
@property (copy,   nonatomic) NSString *id;
@property (copy,   nonatomic) NSString *modifyDate;
@property (copy,   nonatomic) NSString *order;
@end

@interface DefaultReceiverModel : NSObject
@property (copy,   nonatomic) NSString *address;
@property (copy,   nonatomic) NSString *areaName;
@property (copy,   nonatomic) NSString *consignee;
@property (copy,   nonatomic) NSString *createDate;
@property (copy,   nonatomic) NSString *createdDate;
@property (copy,   nonatomic) NSString *id;
@property (copy,   nonatomic) NSString *isDefault;
@property (copy,   nonatomic) NSString *lastModifiedDate;
@property (copy,   nonatomic) NSString *modifyDate;
@property (copy,   nonatomic) NSString *phone;
@property (copy,   nonatomic) NSString *zipCode;
@property (copy,   nonatomic) NSString *username;
@property (copy,   nonatomic) NSString *version;


@property (strong, nonatomic) AreaModel *area;
@end

/**
 *  优惠卷
 */
@interface CouponCodeListModel : NSObject

@end


@interface CouponsModel : NSObject

@end

/**
 *  商品
 */

@interface OrderItemsModel : NSObject
//@property (copy,   nonatomic) NSString *image;
//@property (copy,   nonatomic) NSString *createDate;
//@property (copy,   nonatomic) NSString *fullName;
//@property (copy,   nonatomic) NSString *id;
//@property (copy,   nonatomic) NSString *isGift;
//@property (copy,   nonatomic) NSString *modifyDate;
//@property (copy,   nonatomic) NSString *name;
//@property (copy,   nonatomic) NSString *price;
//@property (copy,   nonatomic) NSString *quantity;
//@property (copy,   nonatomic) NSString *sn;
//@property (copy,   nonatomic) NSString *subtotal;
//@property (copy,   nonatomic) NSString *thumbnail;
//@property (copy,   nonatomic) NSString *totalWeight;
//@property (copy,   nonatomic) NSString *weight;
//@property (copy,   nonatomic) NSString *grapId;
//@property (copy,   nonatomic) NSString *productID;

@property (copy,   nonatomic) NSString *commissionTotals;
@property (copy,   nonatomic) NSString *createDate;
@property (copy,   nonatomic) NSString *createdDate;
@property (copy,   nonatomic) NSString *id;
@property (copy,   nonatomic) NSString *isDelivery;
@property (copy,   nonatomic) NSString *jdcost;
@property (copy,   nonatomic) NSString *lastModifiedDate;
@property (copy,   nonatomic) NSString *modifyDate;
@property (copy,   nonatomic) NSString *name;
//@property (copy,   nonatomic) NSString *new;
@property (copy,   nonatomic) NSString *orderGrapSn;
@property (copy,   nonatomic) NSString *orderItemPoint;
@property (copy,   nonatomic) NSString *price;
@property (copy,   nonatomic) NSString *quantity;
@property (copy,   nonatomic) NSString *returnableQuantity;
@property (copy,   nonatomic) NSString *returnedQuantity;

@property (copy,   nonatomic) NSString *shippableQuantity;
@property (copy,   nonatomic) NSString *shippedQuantity;
@property (copy,   nonatomic) NSString *sn;
@property (copy,   nonatomic) NSString *specifications;
@property (copy,   nonatomic) NSString *staticProductPath;
@property (copy,   nonatomic) NSString *weight;
@property (copy,   nonatomic) NSString *subtotal;
@property (copy,   nonatomic) NSString *thumbnail;
@property (copy,   nonatomic) NSString *totalWeight;
@property (copy,   nonatomic) NSString *type;
@property (copy,   nonatomic) NSString *version;

@end

@interface OrderMemberModel : NSObject
@property (copy,   nonatomic) NSString *balance;
@property (copy,   nonatomic) NSString *createDate;
@property (copy,   nonatomic) NSString *email;
@property (copy,   nonatomic) NSString *gender;
@property (copy,   nonatomic) NSString *id;
@property (copy,   nonatomic) NSString *mobile;
@property (copy,   nonatomic) NSString *modifyDate;
@property (copy,   nonatomic) NSString *password;
@property (copy,   nonatomic) NSString *registerIp;
@property (copy,   nonatomic) NSString *username;
@end

@interface SkuAndNumListModel : NSObject
@property (copy,   nonatomic) NSString *num;
@property (copy,   nonatomic) NSString *skuId;
@end


@interface OrderModel : NSObject
//@property (strong, nonatomic) NSArray *coupons;
//@property (strong, nonatomic) OrderMemberModel *member;
//@property (strong, nonatomic) NSArray *orderItems;
//
//@property (copy,   nonatomic) NSString *address;
//@property (copy,   nonatomic) NSString *amount;             //订单金额
//@property (copy,   nonatomic) NSString *amountPaid;         //已付金额
//@property (copy,   nonatomic) NSString *amountPayable;      //应付金额
//@property (copy,   nonatomic) NSString *area;
//@property (copy,   nonatomic) NSString *areaName;
//@property (copy,   nonatomic) NSString *consignee;
//@property (copy,   nonatomic) NSString *couponDiscount;
//
//@property (copy,   nonatomic) NSString *createDate;
//@property (copy,   nonatomic) NSString *fee;
//@property (copy,   nonatomic) NSString *freight;            //运费
//@property (copy,   nonatomic) NSString *id;
//@property (copy,   nonatomic) NSString *invoiceTitle;
//@property (copy,   nonatomic) NSString *isInvoice;
//
//@property (copy,   nonatomic) NSString *memo;
//@property (copy,   nonatomic) NSString *modifyDate;
//@property (copy,   nonatomic) NSString *name;
//@property (copy,   nonatomic) NSString *offsetAmount;
//
//@property (copy,   nonatomic) NSString *orderStatus;
//@property (copy,   nonatomic) NSString *paymentMethod;
//@property (copy,   nonatomic) NSString *paymentMethodName;
//@property (copy,   nonatomic) NSString *paymentStatus;
//@property (copy,   nonatomic) NSString *phone;
//@property (copy,   nonatomic) NSString *point;
//@property (copy,   nonatomic) NSString *price;
//@property (copy,   nonatomic) NSString *promotion;
//@property (copy,   nonatomic) NSString *promotionDiscount;
//@property (copy,   nonatomic) NSString *shippingMethod;
//@property (copy,   nonatomic) NSString *shippingMethodName;
//@property (copy,   nonatomic) NSString *shippingStatus;
//@property (copy,   nonatomic) NSString *tax;
//@property (copy,   nonatomic) NSString *token;
//@property (copy,   nonatomic) NSString *zipCode;


@property (strong, nonatomic) NSArray *orderItems;
@property (strong, nonatomic) NSArray *skuAndNumList;

@property (copy,   nonatomic) NSString *address;
@property (copy,   nonatomic) NSString *amount;             //订单金额
@property (copy,   nonatomic) NSString *amountPaid;         //已付金额
@property (copy,   nonatomic) NSString *amountPayable;      //应付金额
@property (copy,   nonatomic) NSString *amountReceivable;

@property (copy,   nonatomic) NSString *areaName;
@property (copy,   nonatomic) NSString *completeDate;
@property (copy,   nonatomic) NSString *consignee;
@property (copy,   nonatomic) NSString *couponDiscount;
@property (copy,   nonatomic) NSString *createDate;
@property (copy,   nonatomic) NSString *createdDate;
@property (copy,   nonatomic) NSString *exchangePoint;
@property (copy,   nonatomic) NSString *expire;
@property (copy,   nonatomic) NSString *fee;
@property (copy,   nonatomic) NSString *freight;
@property (copy,   nonatomic) NSString *grapSn;
@property (copy,   nonatomic) NSString *hasExpired;
@property (copy,   nonatomic) NSString *id;
@property (copy,   nonatomic) NSString *invoice;
@property (copy,   nonatomic) NSString *isAllocatedStock;
@property (copy,   nonatomic) NSString *isDelivery;
@property (copy,   nonatomic) NSString *isExchangePoint;
@property (copy,   nonatomic) NSString *isUseCouponCode;
@property (copy,   nonatomic) NSString *lastModifiedDate;
@property (copy,   nonatomic) NSString *memo;
@property (copy,   nonatomic) NSString *modifyDate;
@property (copy,   nonatomic) NSString *name;
//@property (copy,   nonatomic) NSString *new;
@property (copy,   nonatomic) NSString *offsetAmount;
@property (copy,   nonatomic) NSString *paymentMethodName;
@property (copy,   nonatomic) NSString *paymentMethodType;
@property (copy,   nonatomic) NSString *phone;
@property (copy,   nonatomic) NSString *price;
@property (copy,   nonatomic) NSString *promotionDiscount;
@property (copy,   nonatomic) NSString *quantity;
@property (copy,   nonatomic) NSString *refundAmount;
@property (copy,   nonatomic) NSString *refundableAmount;
@property (copy,   nonatomic) NSString *returnableQuantity;
@property (copy,   nonatomic) NSString *returnedQuantity;
@property (copy,   nonatomic) NSString *rewardPoint;
@property (copy,   nonatomic) NSString *settlementAmount;
@property (copy,   nonatomic) NSString *shippableQuantity;
@property (copy,   nonatomic) NSString *shippedQuantity;
@property (copy,   nonatomic) NSString *shippingMethodName;
@property (copy,   nonatomic) NSString *sn;
@property (copy,   nonatomic) NSString *status;
@property (copy,   nonatomic) NSString *tax;
@property (copy,   nonatomic) NSString *totalPointlOneDay;
@property (copy,   nonatomic) NSString *type;
@property (copy,   nonatomic) NSString *version;
@property (copy,   nonatomic) NSString *weight;
@property (copy,   nonatomic) NSString *zipCode;
@end

@interface OrderData : NSObject
//@property (copy,   nonatomic) NSString *cartToken;
//@property (strong, nonatomic) NSArray *couponCodeList;
//@property (strong, nonatomic) DefaultReceiverModel *defaultReceiver;
//@property (strong, nonatomic) OrderModel *order;
//@property (strong, nonatomic) NSArray *paymentMethods;
//@property (strong, nonatomic) NSArray *shippingMethods;

@property (copy,   nonatomic) NSString *amount;         //订单金额
@property (copy,   nonatomic) NSString *amountPayable;  //应付金额
@property (copy,   nonatomic) NSString *cartTag;
@property (copy,   nonatomic) NSString *couponDiscount;
@property (copy,   nonatomic) NSString *fee;
@property (copy,   nonatomic) NSString *freight;
@property (copy,   nonatomic) NSString *isDelivery;
@property (copy,   nonatomic) NSString *orderType;
@property (copy,   nonatomic) NSString *price;
@property (copy,   nonatomic) NSString *promotionDiscount;
@property (copy,   nonatomic) NSString *rewardPoint;
@property (copy,   nonatomic) NSString *tax;                //税金

@property (strong, nonatomic) NSArray *order;
@property (strong, nonatomic) DefaultReceiverModel *defaultReceiver;
@end


@interface OrderResult : WJBaseRequestResult
@property (strong, nonatomic) OrderData *t;
@end


/**
 *  生成订单
 */

@interface OrderSuccessMember : NSObject
@property (copy,   nonatomic) NSString *amount;
@property (copy,   nonatomic) NSString *balance;
@property (copy,   nonatomic) NSString *blanceCapital;
@property (copy,   nonatomic) NSString *createDate;
@property (copy,   nonatomic) NSString *email;
@property (copy,   nonatomic) NSString *gender;
@property (copy,   nonatomic) NSString *id;
@property (copy,   nonatomic) NSString *mobile;
@property (copy,   nonatomic) NSString *modifyDate;
@property (copy,   nonatomic) NSString *name;
@property (copy,   nonatomic) NSString *password;
@property (copy,   nonatomic) NSString *point;
@property (copy,   nonatomic) NSString *registerIp;
@property (copy,   nonatomic) NSString *totalCapital;
@property (copy,   nonatomic) NSString *username;
@end

@interface OrderSuccessArea : NSObject
@property (copy,   nonatomic) NSString *createDate;
@property (copy,   nonatomic) NSString *id;
@property (copy,   nonatomic) NSString *modifyDate;
@property (copy,   nonatomic) NSString *order;
@end

@interface OrderSuccessModel : NSObject
@property (strong, nonatomic) NSArray *coupons;
@property (strong, nonatomic) NSArray *orderItems;
@property (strong, nonatomic) OrderSuccessMember *member;
@property (strong, nonatomic) OrderSuccessArea *area;
@property (strong, nonatomic) OrderSuccessArea *paymentMethod;
@property (strong, nonatomic) OrderSuccessArea *shippingMethod;

@property (copy,   nonatomic) NSString *address;
@property (copy,   nonatomic) NSString *amount;             //订单金额
@property (copy,   nonatomic) NSString *amountPaid;         //已付金额
@property (copy,   nonatomic) NSString *amountPayable;      //应付金额
@property (copy,   nonatomic) NSString *areaName;
@property (copy,   nonatomic) NSString *consignee;
@property (copy,   nonatomic) NSString *couponDiscount;

@property (copy,   nonatomic) NSString *createDate;
@property (copy,   nonatomic) NSString *fee;
@property (copy,   nonatomic) NSString *freight;            //运费
@property (copy,   nonatomic) NSString *id;
@property (copy,   nonatomic) NSString *invoiceTitle;
@property (copy,   nonatomic) NSString *isInvoice;

@property (copy,   nonatomic) NSString *memo;
@property (copy,   nonatomic) NSString *modifyDate;
@property (copy,   nonatomic) NSString *name;
@property (copy,   nonatomic) NSString *offsetAmount;

@property (copy,   nonatomic) NSString *orderStatus;
@property (copy,   nonatomic) NSString *paymentMethodName;
@property (copy,   nonatomic) NSString *paymentStatus;
@property (copy,   nonatomic) NSString *phone;
@property (copy,   nonatomic) NSString *point;
@property (copy,   nonatomic) NSString *price;
@property (copy,   nonatomic) NSString *promotion;
@property (copy,   nonatomic) NSString *promotionDiscount;

@property (copy,   nonatomic) NSString *shippingMethodName;
@property (copy,   nonatomic) NSString *shippingStatus;
@property (copy,   nonatomic) NSString *sn;
@property (copy,   nonatomic) NSString *tax;
@property (copy,   nonatomic) NSString *token;
@property (copy,   nonatomic) NSString *zipCode;
@end


@interface OrderSuccessResult : WJBaseRequestResult
@property (strong, nonatomic) NSArray *t;
@end



/**
 *  优惠券
 */

@interface CouponsData : NSObject
@property (copy,   nonatomic) NSString *couponDiscount;
@end

@interface CouponResult : WJBaseRequestResult
@property (strong, nonatomic) CouponsData *t;
@end

/**
 *  商品是否可售模型
 */
@interface OrderAddressGoodsModel : NSObject
@property (copy, nonatomic) NSString *isSale;   //0不可售 1可售
@property (copy, nonatomic) NSString *gropID;   //商品sku id
@end

@interface OrderAddressGoodsResult : WJBaseRequestResult
@property (strong, nonatomic) NSArray *t;
@end
