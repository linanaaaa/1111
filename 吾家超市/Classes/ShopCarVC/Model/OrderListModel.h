//
//  OrderListModel.h
//  吾家超市
//
//  Created by iMac15 on 2016/11/22.
//  Copyright © 2016年 iMac15. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Area : NSObject

@property (copy,   nonatomic) NSString *createDate;
@property (copy,   nonatomic) NSString *id;
@property (copy,   nonatomic) NSString *modifyDate;
@property (copy,   nonatomic) NSString *order;
@end


@interface Coupons : NSObject

@end


@interface Member : NSObject
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

/**
 *  商品
 */

@interface OrderItems : NSObject
@property (copy,   nonatomic) NSString *grapId;
@property (copy,   nonatomic) NSString *productID;

@property (copy,   nonatomic) NSString *image;
@property (copy,   nonatomic) NSString *createDate;
@property (copy,   nonatomic) NSString *fullName;
@property (copy,   nonatomic) NSString *id;
@property (copy,   nonatomic) NSString *isGift;
@property (copy,   nonatomic) NSString *modifyDate;
@property (copy,   nonatomic) NSString *name;
@property (copy,   nonatomic) NSString *price;
@property (copy,   nonatomic) NSString *quantity;
@property (copy,   nonatomic) NSString *sn;
@property (copy,   nonatomic) NSString *subtotal;
@property (copy,   nonatomic) NSString *thumbnail;
@property (copy,   nonatomic) NSString *totalWeight;
@property (copy,   nonatomic) NSString *weight;
@property (copy,   nonatomic) NSString *returnGoodsEnable;  //save 申请  view 查看 null 不显示
@property (copy,   nonatomic) NSString *returnGoodsId;      //查看售后 id
@end

@interface PaymentMethod : NSObject

@property (copy,   nonatomic) NSString *createDate;
@property (copy,   nonatomic) NSString *id;
@property (copy,   nonatomic) NSString *modifyDate;
@property (copy,   nonatomic) NSString *order;
@end


@interface ShippingMethod : NSObject
@property (copy,   nonatomic) NSString *createDate;
@property (copy,   nonatomic) NSString *id;
@property (copy,   nonatomic) NSString *modifyDate;
@property (copy,   nonatomic) NSString *order;
@end

@interface ShippingItemsModel : NSObject
@property (copy,   nonatomic) NSString *createDate;
@property (copy,   nonatomic) NSString *id;
@property (copy,   nonatomic) NSString *modifyDate;
@property (copy,   nonatomic) NSString *name;
@property (copy,   nonatomic) NSString *quantity;
@property (copy,   nonatomic) NSString *sn;
@end

@interface ShippingsModel : NSObject
@property (strong, nonatomic) NSArray *shippingItems;

@property (copy,   nonatomic) NSString *createDate;
@property (copy,   nonatomic) NSString *deliveryCorp;
@property (copy,   nonatomic) NSString *deliveryCorpUrl;
@property (copy,   nonatomic) NSString *id;
@property (copy,   nonatomic) NSString *modifyDate;
@property (copy,   nonatomic) NSString *sn;
@property (copy,   nonatomic) NSString *trackingNo;
@property (copy,   nonatomic) NSString *zipCode;
@end

@interface SkuAndNumOrderListModel : NSObject
@property (copy,   nonatomic) NSString *num;
@property (copy,   nonatomic) NSString *skuId;
@end

@interface OrderListModel : NSObject

@property (strong, nonatomic) NSArray *skuAndNumList;
@property (strong, nonatomic) ShippingMethod *shippingMethod;
@property (strong, nonatomic) PaymentMethod *paymentMethod;
@property (strong, nonatomic) Member *member;
@property (strong, nonatomic) Area *area;
@property (strong, nonatomic) NSArray *orderItems;
@property (strong, nonatomic) NSArray *coupons;
@property (strong, nonatomic) NSArray *shippings;


@property (copy,   nonatomic) NSString *hasExpired;                
@property (copy,   nonatomic) NSString *sn;                 //订单编号
@property (copy,   nonatomic) NSString *address;
@property (copy,   nonatomic) NSString *amount;             //订单金额
@property (copy,   nonatomic) NSString *amountPaid;         //已付金额
@property (copy,   nonatomic) NSString *amountPayable;      //应付金额

@property (copy,   nonatomic) NSString *areaName;
@property (copy,   nonatomic) NSString *consignee;
@property (copy,   nonatomic) NSString *couponDiscount;     //优惠券优惠金额

@property (copy,   nonatomic) NSString *createDate;
@property (copy,   nonatomic) NSString *expired;
@property (copy,   nonatomic) NSString *fee;                //手续费
@property (copy,   nonatomic) NSString *freight;            //运费
@property (copy,   nonatomic) NSString *id;
@property (copy,   nonatomic) NSString *invoiceTitle;
@property (copy,   nonatomic) NSString *isInvoice;

@property (copy,   nonatomic) NSString *memo;
@property (copy,   nonatomic) NSString *modifyDate;
@property (copy,   nonatomic) NSString *name;
@property (copy,   nonatomic) NSString *offsetAmount;

@property (copy,   nonatomic) NSString *orderStatus;        //订单状态
@property (copy,   nonatomic) NSString *orderStatusShow;     //订单状态

@property (copy,   nonatomic) NSString *paymentMethodName;  //支付方法名称
@property (copy,   nonatomic) NSString *paymentStatus;      //支付状态
@property (copy,   nonatomic) NSString *phone;
@property (copy,   nonatomic) NSString *point;              //赠送多少积分
@property (copy,   nonatomic) NSString *price;
@property (copy,   nonatomic) NSString *promotion;
@property (copy,   nonatomic) NSString *promotionDiscount;   //促销折扣金额

@property (copy,   nonatomic) NSString *shippingMethodName;
@property (copy,   nonatomic) NSString *shippingStatus;
@property (copy,   nonatomic) NSString *tax;
@property (copy,   nonatomic) NSString *token;
@property (copy,   nonatomic) NSString *zipCode;

@property (copy,   nonatomic) NSString *status;             //订单状态
@end


/**
 *  全部订单列表
 */

@interface OrderListResult : WJBaseRequestResult
@property (strong, nonatomic) NSArray *t;
@end


/**
 *  订单详情
 */

@interface OrderDetailsResult : WJBaseRequestResult
@property (strong, nonatomic) OrderListModel *t;
@end

/**
 *  获取订单列表 参数
 */

@interface OrderListParam : NSObject
@property (copy,   nonatomic) NSString *status;

@property (copy,   nonatomic) NSString *pageNumber;
@property (copy,   nonatomic) NSString *shippingStatus;
@property (copy,   nonatomic) NSString *paymentStatus;
@property (copy,   nonatomic) NSString *orderStatus;
@end


/**
 *  获取我的优惠券
 */

@interface CouponsListParam : NSObject
@property (copy,   nonatomic) NSString *isUsed;
@property (copy,   nonatomic) NSString *hasExpired;
@end


/**
 *  订单跟踪
 */

@interface OrderTrackModel : NSObject
@property (copy,   nonatomic) NSString *createTime;
@property (copy,   nonatomic) NSString *opInfo;
@end

@interface OrderTrackData : NSObject
@property (strong, nonatomic) NSArray *orderTrack;
@end

@interface OrderTrackResult : WJBaseRequestResult
@property (strong, nonatomic) OrderTrackData *t;
@end



