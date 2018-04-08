//
//  LoginModel.h
//  吾家超市
//
//  Created by iMac15 on 2016/11/2.
//  Copyright © 2016年 iMac15. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginModel : NSObject

@end

/**
 *  存储 cook
 */
@interface JessonIDData : NSObject
@property (nonatomic, copy) NSString *jessionid;         //验证密码 id
@end

@interface JessonIDResult : WJBaseRequestResult
@property (nonatomic, strong) JessonIDData *t;
@end

/*
 *  获取公钥
 **/

@interface SetPasswordData : NSObject
@property (nonatomic, copy) NSString *publicKey;         //公钥
@end

@interface SetPasswordDataResult : WJBaseRequestResult
@property (nonatomic, strong) SetPasswordData *t;
@end

/**
 *  注册参数-提交
 */
@interface RegisterParam : NSObject
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *enPassword;
@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, copy) NSString *generateCode;
@end

/**
 *  登录-提交
 */
@interface LoginParam : NSObject
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *enPassword;
@end

/**
 *  修改密码-提交
 */
@interface ResetPasswordParam : NSObject
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *generateCode;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *passwordAgain;
@end
