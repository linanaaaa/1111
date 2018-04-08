//
//  WJCountdownButton.m
//  吾家超市
//
//  Created by iMac15 on 2016/10/31.
//  Copyright © 2016年 iMac15. All rights reserved.
//

#import "WJCountdownButton.h"

@interface WJCountdownButton()
@property(nonatomic, strong) NSTimer *timer;
@property(nonatomic, assign) NSUInteger totalSecond;
@property(nonatomic, assign) NSUInteger second;
@property(nonatomic, strong) NSDictionary *param;
@end

@implementation WJCountdownButton

#pragma mark -验证手机号
- (void)checkPhone
{
    [self.superview endEditing:YES];
    
    if (self.phoneNumber.length == 0) {
        [MBProgressHUD showTextMessage:@"请输入手机号"];
        return;
    }
    
    NSString *url;
    
    if (self.type == 0) {               //注册
        url = kCheck_mobileUrl;
        self.param = @{@"mobile":self.phoneNumber};
    }
    else if (self.type == 1) {          //找回密码
        url = kcheckPhoneUrl;
        self.param = @{@"phone":self.phoneNumber};
    }
    
    [WJRequestTool post:url param:self.param successBlock:^(WJBaseRequestResult *result)
     {
         [self sendVertifyCodeWithPhone];
     } failure:^(NSError *error) {
         
     }];
}

#pragma mark -统一获取验证码
- (void)sendVertifyCodeWithPhone
{
    self.param = @{@"phone":self.phoneNumber};
    
    [WJRequestTool post:kSendSMSUrl param:self.param resultClass:[JessonIDResult class] successBlock:^(JessonIDResult *result)
     {
         [self startCountdown];
         [MBProgressHUD showTextMessage:result.content];
         
     } failure:^(NSError *error) {
         
     }];
}

#pragma mark -使用消费资本/余额 -获取验证码
- (void)sendTheGenerateCode
{
    [WJRequestTool post:kGenerateCodeUrl param:nil successBlock:^(WJBaseRequestResult *result)
    {
        [self startCountdown];
        
    } failure:^(NSError *error) {
        
    }];
}


+ (instancetype)countdownButtonWithSecond:(NSUInteger)second
{
    WJCountdownButton *button = [WJCountdownButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"获取验证码" forState:UIControlStateNormal];
    [button setTitleColor:kGlobalTextColor forState:UIControlStateNormal];
    [button setBackgroundColor:kColor(244, 245, 246)];
    button.layer.cornerRadius = 6;
    button.layer.masksToBounds = YES;
    button.second = second;
    [button addTarget:button action:@selector(checkPhone) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

- (void)startCountdown
{
    if (_timer) return;
    
    self.enabled = NO;
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countDownTime) userInfo:nil repeats:YES];
    
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

- (void)endCountdown
{
    self.enabled = YES;
    [self setTitle:@"获取验证码" forState:UIControlStateNormal];
}

- (void)countDownTime
{
    WJLog(@"%@", @(_second));
    if (_second > 0) {
        _second --;
        [self setTitle:[NSString stringWithFormat:@"%@s重新获取",@(_second)] forState:UIControlStateNormal];
        
    } else {
        [self endCountdown];
        [_timer invalidate];
        _timer = nil;
    }
}

- (void)removeFromSuperview
{
    [_timer invalidate];
    _timer = nil;
    
    [super removeFromSuperview];
}

- (BOOL)verifyMobilePhone:(NSString *)phoneStr;
{
    NSString *regex = @"^[1]{10}$";
    NSPredicate * mobilePhone = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    return [mobilePhone evaluateWithObject:phoneStr];
}
@end

