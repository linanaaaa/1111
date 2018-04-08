//
//  CouponModel.h
//  吾家超市
//
//  Created by iMac15 on 2017/1/23.
//  Copyright © 2017年 iMac15. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CouponModel : NSObject
@property (copy, nonatomic) NSString *beginDate;    //开始 日期
@property (copy, nonatomic) NSString *endDate;      //使用 结束时间
@property (copy, nonatomic) NSString *code;         //优惠码
@property (copy, nonatomic) NSString *id;           //优惠码 ID
@property (copy, nonatomic) NSString *couponId;     //优惠券 ID
@property (copy, nonatomic) NSString *createDate;   //创建时间
@property (copy, nonatomic) NSString *hasBegun;     //1 已经 开始
@property (copy, nonatomic) NSString *hasExpired;   //0 已过期
@property (copy, nonatomic) NSString *introduction; //优惠券名字
@property (copy, nonatomic) NSString *isUsed;       //是否使用过 0 未使用
@property (copy, nonatomic) NSString *modifyDate;
@property (copy, nonatomic) NSString *name;         //价格
@property (copy, nonatomic) NSString *usedDate;     //使用时间
@property (copy, nonatomic) NSString *minimumPrice; //满减价格
@property (copy, nonatomic) NSString *minimumQuantity;  //满数量减 
@end

@interface CouponModelResult : WJBaseRequestResult
@property (strong, nonatomic) NSArray *t;
@end

