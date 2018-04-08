//
//  ZNGUserInfoDataSource.h
//  吾家超市
//
//  Created by iMac15 on 2017/1/13.
//  Copyright © 2017年 iMac15. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZNGSingleton.h"

/**
 *  会员信息
 */

/*
 t =     {
 amount = 0;                    累计消费金额
 balance = 0;                   当前余额
 blanceCapital = 0;             消费资本余额
 createDate = 1479865920000;    创建日期
 email = "<null>";
 gender = "<null>";             性别
 id = 4587;                     id
 mobile = 18601219084;          手机号
 modifyDate = 1482218466000;    修改日期
 name = "<null>";               姓名
 password = 7ad03bde14ff0b60;   假密码
 point = 0;                     返利余额
 registerIp = "192.168.16.208";
 totalCapital = 0;              总共消费多少 消费资本
 username = "李华";              姓名
 };
 
 */

@interface ZNGUserData : NSObject

@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *enPassword;

@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *balance;
@property (nonatomic, copy) NSString *blanceCapital;    //回馈值
@property (nonatomic, copy) NSString *amount;
@property (nonatomic, copy) NSString *totalCapital;
@property (nonatomic, copy) NSString *createDate;
@property (nonatomic, copy) NSString *gender;
@property (nonatomic, copy) NSString *modifyDate;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *point;    //贡献值
@property (nonatomic, copy) NSString *registerIp;
@property (nonatomic, copy) NSString *sumPoint;
@end

@interface ZNGLoginResult : WJBaseRequestResult
@property (nonatomic, strong) ZNGUserData *t;
@end


@interface ZNGUser : NSObject
ZNGSingletonH(userInfo)

@property (nonatomic, assign, getter=isOnline) BOOL online;

@property (nonatomic, copy, readonly) NSString *mobile;
@property (nonatomic, copy, readonly) NSString *username;
@property (nonatomic, copy, readonly) NSString *enPassword;

@property (nonatomic, copy, readonly) NSString *email;
@property (nonatomic, copy, readonly) NSString *id;
@property (nonatomic, copy, readonly) NSString *balance;
@property (nonatomic, copy, readonly) NSString *blanceCapital;
@property (nonatomic, copy, readonly) NSString *amount;
@property (nonatomic, copy, readonly) NSString *totalCapital;
@property (nonatomic, copy, readonly) NSString *createDate;
@property (nonatomic, copy, readonly) NSString *gender;
@property (nonatomic, copy, readonly) NSString *modifyDate;
@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, copy, readonly) NSString *point;
@property (nonatomic, copy, readonly) NSString *registerIp;
@property (nonatomic, copy, readonly) NSString *sumPoint;

+ (void)loginWithT:(ZNGUserData *)t;

/** 退出 */
+ (void)logout;

- (void)clearCookies; //清除cooks

@end

