//
//  ZNGUserInfoDataSource.m
//  吾家超市
//
//  Created by iMac15 on 2017/1/13.
//  Copyright © 2017年 iMac15. All rights reserved.
//

#import "ZNGUser.h"
#import "MJExtension.h"

@interface ZNGUser ()
{
    BOOL _online;
    NSString *_mobile;
    NSString *_username;
    NSString *_enPassword;
    
    NSString *_email;
    NSString *_id;
    NSString *_balance;
    NSString *_blanceCapital;
    NSString *_amount;
    NSString *_totalCapital;
    NSString *_createDate;
    NSString *_gender;
    NSString *_modifyDate;
    NSString *_name;
    NSString *_point;
    NSString *_registerIp;
    NSString *_sumPoint;
}
@end

@implementation ZNGUser

ZNGSingletonM(userInfo)

+ (void)logout
{
    [[self userInfo] logout];
    [[self userInfo] clearCookies];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"UpdateShoppingCartAmountNotification" object:nil];
}

//清除cookies
- (void)clearCookies
{
    NSArray*array =  [[NSHTTPCookieStorage sharedHTTPCookieStorage]cookiesForURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",kLoginUrl]]];
    
    for(NSHTTPCookie*cookie in array)
    {
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie: cookie];
    }
}

+ (void)loginWithT:(ZNGUserData *)t
{
    [[self userInfo] loginWithT:t];
}

- (void)loginWithT:(ZNGUserData *)t
{
    self.online = YES;
    
    self.mobile = t.mobile;
    self.username = t.username;
    self.enPassword = t.enPassword;
    
    self.email = t.email;
    self.id = t.id;
    self.balance = t.balance;
    self.blanceCapital = t.blanceCapital;
    self.amount = t.amount;
    self.totalCapital = t.totalCapital;
    self.createDate = t.createDate;
    self.gender = t.gender;
    self.modifyDate = t.modifyDate;
    self.name = t.name;
    self.point = t.point;
    self.registerIp = t.registerIp;
    self.sumPoint = t.sumPoint;
}

- (void)logout
{
    self.online = NO;
    self.mobile = @"";
    self.username = @"";
    self.enPassword = @"";
    
    self.email = @"";
    self.id = @"";
    self.balance = @"";
    self.blanceCapital = @"";
    self.amount = @"";
    self.totalCapital = @"";
    self.createDate = @"";
    self.gender = @"";
    self.modifyDate = @"";
    self.name = @"";
    self.point = @"";
    self.registerIp = @"";
    self.sumPoint = @"";
    
    [[UIApplication sharedApplication] unregisterForRemoteNotifications];
}

- (void)setOnline:(BOOL)online
{
    _online = online;
    [[NSUserDefaults standardUserDefaults] setBool:online forKey:@"online"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (BOOL)isOnline
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"online"];
}

- (void)setMobile:(NSString *)mobile
{
    _mobile = mobile;
    [[NSUserDefaults standardUserDefaults] setValue:mobile forKey:@"mobile"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)mobile
{
    return [[NSUserDefaults standardUserDefaults] valueForKey:@"mobile"];
}

- (void)setUsername:(NSString *)username
{
    _username = username;
    [[NSUserDefaults standardUserDefaults] setValue:username forKey:@"username"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)username
{
    return [[NSUserDefaults standardUserDefaults] valueForKey:@"username"];
}

- (void)setEnPassword:(NSString *)enPassword
{
    _enPassword = enPassword;
    [[NSUserDefaults standardUserDefaults] setValue:enPassword forKey:@"enPassword"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)enPassword
{
    return [[NSUserDefaults standardUserDefaults] valueForKey:@"enPassword"];
}

- (void)setEmail:(NSString *)email
{
    _email = email;
    [[NSUserDefaults standardUserDefaults] setValue:email forKey:@"email"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)email
{
    return [[NSUserDefaults standardUserDefaults] valueForKey:@"email"];
}

- (void)setRegisterIp:(NSString *)registerIp
{
    _registerIp = registerIp;
    [[NSUserDefaults standardUserDefaults] setValue:registerIp forKey:@"registerIp"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)registerIp
{
    return [[NSUserDefaults standardUserDefaults] valueForKey:@"registerIp"];
}

- (void)setPoint:(NSString *)point
{
    _point = point;
    [[NSUserDefaults standardUserDefaults] setValue:point forKey:@"point"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)point
{
    return [[NSUserDefaults standardUserDefaults] valueForKey:@"point"];
}

- (void)setName:(NSString *)name
{
    _name = name;
    [[NSUserDefaults standardUserDefaults] setValue:name forKey:@"name"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)name
{
    return [[NSUserDefaults standardUserDefaults] valueForKey:@"name"];
}

- (void)setModifyDate:(NSString *)modifyDate
{
    _modifyDate = modifyDate;
    [[NSUserDefaults standardUserDefaults] setValue:modifyDate forKey:@"modifyDate"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)modifyDate
{
    return [[NSUserDefaults standardUserDefaults] valueForKey:@"modifyDate"];
}

- (void)setGender:(NSString *)gender
{
    _gender = gender;
    [[NSUserDefaults standardUserDefaults] setValue:gender forKey:@"gender"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)gender
{
    return [[NSUserDefaults standardUserDefaults] valueForKey:@"gender"];
}

- (void)setCreateDate:(NSString *)createDate
{
    _createDate = createDate;
    [[NSUserDefaults standardUserDefaults] setValue:createDate forKey:@"createDate"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)createDate
{
    return [[NSUserDefaults standardUserDefaults] valueForKey:@"createDate"];
}

- (void)setTotalCapital:(NSString *)totalCapital
{
    _totalCapital = totalCapital;
    [[NSUserDefaults standardUserDefaults] setValue:totalCapital forKey:@"totalCapital"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)totalCapital
{
    return [[NSUserDefaults standardUserDefaults] valueForKey:@"totalCapital"];
}

- (void)setAmount:(NSString *)amount
{
    _amount = amount;
    [[NSUserDefaults standardUserDefaults] setValue:amount forKey:@"amount"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)amount
{
    return [[NSUserDefaults standardUserDefaults] valueForKey:@"amount"];
}

- (void)setBlanceCapital:(NSString *)blanceCapital
{
    _blanceCapital = blanceCapital;
    [[NSUserDefaults standardUserDefaults] setValue:blanceCapital forKey:@"blanceCapital"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)blanceCapital
{
    return [[NSUserDefaults standardUserDefaults] valueForKey:@"blanceCapital"];
}

- (void)setSumPoint:(NSString *)sumPoint
{
    _sumPoint = sumPoint;
    [[NSUserDefaults standardUserDefaults] setValue:sumPoint forKey:@"sumPoint"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)sumPoint
{
    return [[NSUserDefaults standardUserDefaults] valueForKey:@"sumPoint"];
}

- (void)setBalance:(NSString *)balance
{
    _balance = balance;
    [[NSUserDefaults standardUserDefaults] setValue:balance forKey:@"balance"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)balance
{
    return [[NSUserDefaults standardUserDefaults] valueForKey:@"balance"];
}

- (void)setId:(NSString *)id
{
    _id = id;
    [[NSUserDefaults standardUserDefaults] setValue:id forKey:@"id"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)id
{
    return [[NSUserDefaults standardUserDefaults] valueForKey:@"id"];
}


@end

@implementation ZNGUserData

- (NSString *)point
{
    return [NSString stringWithFormat:@"%.2f", _point.floatValue];
}

- (NSString *)blanceCapital
{
    return [NSString stringWithFormat:@"%.2f", _blanceCapital.floatValue];
}

- (NSString *)sumPoint
{
    return [NSString stringWithFormat:@"%.2f", _sumPoint.floatValue];
}

@end

@implementation ZNGLoginResult

@end
