//
//  AddressModel.h
//  吾家超市
//
//  Created by iMac15 on 2016/11/16.
//  Copyright © 2016年 iMac15. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface addressAreaModel : NSObject

@property(nonatomic, copy)NSString *createDate;     //省份编号
@property(nonatomic, copy)NSString *id;             //省份id
@property(nonatomic, copy)NSString *modifyDate;     //省份编号
@property(nonatomic, copy)NSString *order;          //排序
@end

@interface AddressModel : NSObject
@property(nonatomic, copy)NSString *address;
@property(nonatomic, copy)NSString *areaName;
@property(nonatomic, copy)NSString *areaId;
@property(nonatomic, copy)NSString *consignee;
@property(nonatomic, copy)NSString *createDate;
@property(nonatomic, copy)NSString *createdDate;
@property(nonatomic, copy)NSString *id;
@property(nonatomic, copy)NSString *lastModifiedDate;
@property(nonatomic, copy)NSString *modifyDate;
@property(nonatomic, copy)NSString *phone;
@property(nonatomic, copy)NSString *zipCode;
@property(nonatomic, copy)NSString *version;

@property(nonatomic, assign)BOOL isDefault;

@property(nonatomic, strong)addressAreaModel *area;
@end

@interface AddressListResult : WJBaseRequestResult
@property(nonatomic, strong)NSArray *t;
@end

@interface CreateAddressResult : WJBaseRequestResult
@property(nonatomic, strong)AddressModel *t;
@end


///*
// *  新建/修改 收货地址
// */
//@interface CreateAddressParam : NSObject
//@property(nonatomic, copy)NSString *buyerID;        // 买家ID
//@property(nonatomic, copy)NSString *receiver;       // 收货人
//@property(nonatomic, copy)NSString *mobilePhone;    // 手机号
//@property(nonatomic, copy)NSString *provinceID;     // 所在省份
//@property(nonatomic, copy)NSString *cityID;         // 所在城市
//@property(nonatomic, copy)NSString *countyID;       // 所在区县      (不填系统默认为-1)
//@property(nonatomic, copy)NSString *streetID;       // 所在乡镇街道   (不填系统默认为-1)
//@property(nonatomic, copy)NSString *address;        // 收货地址
//@property(nonatomic, copy)NSString *isDefault;      // 是否默认收货地址(0否 1是)  (不填系统默认为0)
//
//@property(nonatomic, copy)NSString *id;             // 更新收货地址 收货地址id
//@end
//


/*
 *  获取 省市区乡镇信息
 */
@interface AddressChooseModel : NSObject
@property(nonatomic, copy)NSString *id;         //  地区 id
@property(nonatomic, copy)NSString *name;       //  地区 名称
@end

@interface AddressChooseResult : WJBaseRequestResult
@property(nonatomic, strong)NSArray *t;
@end

