//
//  ResetPasswordVC.m
//  吾家超市
//
//  Created by iMac15 on 2016/10/25.
//  Copyright © 2016年 iMac15. All rights reserved.
//

#import "ResetPasswordVC.h"
#import "NSString+RSA.h"

@interface ResetPasswordVC ()<UITextFieldDelegate>
@property (nonatomic, weak)   UIButton *doneBtn;
@property (nonatomic, strong) UITextField *password;
@property (nonatomic, strong) UITextField *passwordAgain;
@end

@implementation ResetPasswordVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadThePublicKey];
}

#pragma mark -重置密码 完成
- (void)doneBtnDidClick
{
    [self.view endEditing:YES];
    
    if (![self.password.text isEqualToString:self.passwordAgain.text]) {
        [MBProgressHUD showTextMessage:@"两次密码输入不一致"];
        return;
    }else if(![self passwordIsValid:self.password.text]){
        [MBProgressHUD showTextMessage:@"密码由6-30位英文字母、数字或符号组成"];
        return;
    }
    
    NSString *publickStr = [[NSUserDefaults standardUserDefaults] objectForKey:@"publickStr"];
    
    ResetPasswordParam *param = [[ResetPasswordParam alloc] init];
    param.phone = self.phone;
    param.generateCode = self.generateCode;
    param.password = [NSString encryptString:self.password.text andPublicKey:publickStr];
    param.passwordAgain = [NSString encryptString:self.passwordAgain.text andPublicKey:publickStr];
    
    [WJRequestTool post:kResetUrl param:param successBlock:^(WJBaseRequestResult *result)
     {
         [MBProgressHUD showTextMessage:result.content];
         [self.navigationController popToRootViewControllerAnimated:YES];
         
     } failure:^(NSError *error) {
         
     }];
}

#pragma mark -获取加密公钥 -get请求
- (void)loadThePublicKey
{
    [WJRequestTool get:kPublicKeyUrl param:nil resultClass:[SetPasswordDataResult class]successBlock:^(SetPasswordDataResult *result)
     {
         kUserDefaultSetObjectForKey(result.t.publicKey, @"publickStr");
         
     } failure:^(NSError *error) {
         
     }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"重置密码";
    
    self.password = [self.view addTextFieldWithPlaceholder:@"请输入新密码"
                                                  delegate:self
                                                    target:self
                                                    action:@selector(textChange)];
    self.password.frame = CGRectMake(10, 10, kScreenW - 20, 40);
    
    self.passwordAgain = [self.view addTextFieldWithPlaceholder:@"再次输入新密码"
                                                       delegate:self
                                                         target:self
                                                         action:@selector(textChange)];
    self.passwordAgain.frame = CGRectMake(10, CGRectGetMaxY(self.password.frame), kScreenW - 20, 40);
    
    self.doneBtn = [self.view addButtonFilletWithTitle:@"完成"
                                                target:self
                                                action:@selector(doneBtnDidClick)];
    self.doneBtn.frame = CGRectMake(10, CGRectGetMaxY(self.passwordAgain.frame) + 20, kScreenW - 20, 44);
    self.doneBtn.enabled = NO;
    
    [self.view addSplitLineWithFrame:CGRectMake(10, CGRectGetMaxY(self.password.frame), kScreenW - 10, kSplitLineHeight)];
    [self.view addSplitLineWithFrame:CGRectMake(10, CGRectGetMaxY(self.passwordAgain.frame), kScreenW - 10, kSplitLineHeight)];
    
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endEditingTap:)]];
}

- (void)textChange
{
    if (self.password.text.length > 0 && self.passwordAgain.text.length > 0) {
        self.doneBtn.enabled = YES;
    }
    else {
        self.doneBtn.enabled = NO;
    }
}

#pragma mark -密码6-30位判断
- (BOOL)passwordIsValid:(NSString *)text
{
    NSString *regex = @"^.{6,30}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:text];
}

#pragma mark - 点击空白 键盘消失
- (void)endEditingTap:(UITapGestureRecognizer *)hidenTextTap
{
    [self.view endEditing:YES];
}
@end
