//
//  SetPasswordVC.m
//  吾家超市
//
//  Created by iMac15 on 2016/10/31.
//  Copyright © 2016年 iMac15. All rights reserved.
//

#import "SetPasswordVC.h"
#import "LoginModel.h"
#import "NSString+RSA.h"
#import "RSA.h"

@interface SetPasswordVC ()<UITextFieldDelegate>
@property (nonatomic, strong) UITextField *phoneTf;
@property (nonatomic, strong) UITextField *passwordTf;
@property (nonatomic, strong) UIButton *doneBtn;
@end

@implementation SetPasswordVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadThePublicKey];
}

#pragma mark -完成
- (void)doneBtnDidClick
{
    NSString *publickStr = [[NSUserDefaults standardUserDefaults] objectForKey:@"publickStr"];
    
    RegisterParam *param = [[RegisterParam alloc] init];
    param.username = self.phoneTf.text;
    param.mobile = self.phoneStr;
    param.generateCode = self.codeStr;
    param.enPassword = [NSString encryptString:self.passwordTf.text andPublicKey:publickStr];
    
    [WJRequestTool post:kRegisterUrl param:param resultClass:[JessonIDResult class ] successBlock:^(JessonIDResult *result)
     {
         NSString *enPasswordStr = [NSString encodeBase64String:self.passwordTf.text];
         
         kUserDefaultSetObjectForKey(self.phoneTf.text, @"mobile");
         kUserDefaultSetObjectForKey(self.phoneTf.text, @"username");
         kUserDefaultSetObjectForKey(enPasswordStr, @"enPassword");
         
         [self.navigationController popToRootViewControllerAnimated:YES];
         
     } failure:^(NSError *error) {
         
     }];
}

#pragma mark -获取加密公钥 -get请求
- (void)loadThePublicKey
{
    [WJRequestTool get:kPublicKeyUrl param:nil resultClass:[SetPasswordDataResult class]successBlock:^(SetPasswordDataResult *result)
     {
         kUserDefaultSetObjectForKey(result.t.publicKey, @"publickStr")
         
     } failure:^(NSError *error) {
         
     }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置密码";
    
    UILabel *label = [self.view addLabelWithText:@"请设置用户名密码,以便登录使用"];
    label.frame = CGRectMake(0, 20, kScreenW, 40);
    label.textAlignment = NSTextAlignmentCenter;
    
    self.phoneTf = [self.view addTextFieldWithPlaceholder:@"用户名"
                                                 delegate:self
                                                   target:self
                                                   action:@selector(textChange)];
    self.phoneTf.frame = CGRectMake(10, CGRectGetMaxY(label.frame) + 20, kScreenW - 20, 40);
    
    self.passwordTf = [self.view addTextFieldWithPlaceholder:@"请输入密码"
                                                    delegate:self
                                                      target:self
                                                      action:@selector(textChange)];
    self.passwordTf.frame = CGRectMake(10, CGRectGetMaxY(self.phoneTf.frame), kScreenW - 20, 40);
    
    self.doneBtn = [self.view addButtonFilletWithTitle:@"完成"
                                                target:self
                                                action:@selector(doneBtnDidClick)];
    self.doneBtn.frame = CGRectMake(10, CGRectGetMaxY(self.passwordTf.frame) + 20, kScreenW - 20, 44);
    self.doneBtn.enabled = NO;
    
    [self.view addSplitLineWithFrame:CGRectMake(10, CGRectGetMaxY(self.phoneTf.frame), kScreenW - 10, kSplitLineHeight)];
    
    [self.view addSplitLineWithFrame:CGRectMake(10, CGRectGetMaxY(self.passwordTf.frame), kScreenW - 10, kSplitLineHeight)];
    
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endEditingTap:)]];
}

- (void)textChange
{
    if (self.phoneTf.text.length > 0 && self.passwordTf.text.length > 0) {
        self.doneBtn.enabled = YES;
    }
    else {
        self.doneBtn.enabled = NO;
    }
}

#pragma mark - 点击空白 键盘消失
- (void)endEditingTap:(UITapGestureRecognizer *)hidenTextTap
{
    [self.view endEditing:YES];
}
@end
