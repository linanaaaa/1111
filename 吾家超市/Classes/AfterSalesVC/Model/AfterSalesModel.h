//
//  AfterSalesModel.h
//  吾家超市
//
//  Created by iMac15 on 2017/2/16.
//  Copyright © 2017年 iMac15. All rights reserved.
//

#import <Foundation/Foundation.h>

//t =     {
//    address = "北京市海淀区巨山路111";
//    consignee = "王晓瑞";
//    createDate = 1487145808000;
//    customerDeliveryCorp = "顺丰快递";
//    customerTrackingNo = 222222;
//    id = 23;
//    memo = "买重复了";
//    modifyDate = 1487145826000;
//    orderSn = 2017011962418;
//    productName = "[正品国行]华为G9 青春版全网通智能手机 官方标配智能机 仅激活";
//    quantity = 1;
//    rejectReason = "<null>";
//    returnGoodsEditEnable = edit;
//    status = processed;
//    type = returns;
//};


//Status {
//    /** 处理中 */
//    processing,
//    /** 处理完 */
//    processed,
//    /** 驳回 */
//    reject
//}

@interface AfterSalesModel : NSObject
@property (copy, nonatomic) NSString *address;
@property (copy, nonatomic) NSString *consignee;
@property (copy, nonatomic) NSString *createDate;
@property (copy, nonatomic) NSString *customerDeliveryCorp;
@property (copy, nonatomic) NSString *customerTrackingNo;
@property (copy, nonatomic) NSString *id;
@property (copy, nonatomic) NSString *memo;
@property (copy, nonatomic) NSString *modifyDate;
@property (copy, nonatomic) NSString *orderSn;
@property (copy, nonatomic) NSString *productName;
@property (copy, nonatomic) NSString *quantity;
@property (copy, nonatomic) NSString *rejectReason;
@property (copy, nonatomic) NSString *returnGoodsEditEnable;
@property (copy, nonatomic) NSString *status;
@property (copy, nonatomic) NSString *type;
@property (copy, nonatomic) NSString *returnGoodsId;      //查看售后 id
@end

/**
 *  退换货详情
 */
@interface AfterSalesResult : WJBaseRequestResult
@property (strong, nonatomic) AfterSalesModel *t;
@end


/**
 *  退换货列表
 */
@interface AfterSaleListResult : WJBaseRequestResult
@property (strong, nonatomic) NSArray *t;
@end
