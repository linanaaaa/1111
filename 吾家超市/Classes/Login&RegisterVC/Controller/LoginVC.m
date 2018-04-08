//
//  LoginVC.m
//  吾家超市
//
//  Created by iMac15 on 2016/10/25.
//  Copyright © 2016年 iMac15. All rights reserved.
//

#import "LoginVC.h"
#import "RetrievePassVC.h"
#import "RegisterVC.h"
#import "NSString+RSA.h"
#import "GTMBase64.h"

@interface LoginVC ()<UITextFieldDelegate>
@property (nonatomic, strong) UIView *content;
@property (nonatomic, weak) UIButton *loginBtn;
@property (nonatomic, weak) WJInputTextField *usrname;
@property (nonatomic, weak) WJInputTextField *password;
@end

@implementation LoginVC

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
    
    self.usrname.text = nil;
    self.password.text = nil;
}

#pragma mark -获取加密公钥-登录
- (void)loadThePublicKey
{
    kWeakSelf
    
    [self.view endEditing:YES];
    
    [WJRequestTool get:kPublicKeyUrl param:nil resultClass:[SetPasswordDataResult class]successBlock:^(SetPasswordDataResult *result)
     {
         kUserDefaultSetObjectForKey(result.t.publicKey, @"publickStr");
         
         [MBProgressHUD showLoadingMessage:@""];
         
         LoginParam *param = [[LoginParam alloc] init];
         param.username = weakSelf.usrname.text;
         param.enPassword = [NSString encryptString:weakSelf.password.text andPublicKey:[[NSUserDefaults standardUserDefaults] objectForKey:@"publickStr"]];
         
         [WJRequestTool post:kLoginUrl param:param resultClass:[ZNGLoginResult class] successBlock:^(ZNGLoginResult *result)
          {
              [MBProgressHUD hideHUD];

              if ([result.type isEqualToString:@"success"] && !kObjectIsEmpty(result.t)) {
                  NSString *enPasswordStr = [NSString encodeBase64String:weakSelf.password.text];    //base64加密 密码
                  
                  ZNGUserData *user = [[ZNGUserData alloc] init];
                  user.username = self.usrname.text;
                  user.enPassword = enPasswordStr;
                  
                  user.email = result.t.email;
                  user.id = result.t.id;
                  user.balance = result.t.balance;
                  user.blanceCapital = result.t.blanceCapital;
                  user.amount = result.t.amount;
                  user.totalCapital = result.t.totalCapital;
                  user.createDate = result.t.createDate;
                  user.gender = result.t.gender;
                  user.modifyDate = result.t.modifyDate;
                  user.name = result.t.username;
                  user.point = result.t.point;
                  user.registerIp = result.t.registerIp;
                  user.mobile = result.t.mobile;
                  user.sumPoint = result.t.sumPoint;
                  
                  [ZNGUser loginWithT:user];
                  
                  [[NSNotificationCenter defaultCenter] postNotificationName:@"UpdateShoppingCartAmountNotification" object:nil];
                  
                  [weakSelf.navigationController popViewControllerAnimated:YES];
              }
              else{
                  [MBProgressHUD showTextMessage:result.content hideAfter:2.0];
              }
              
          } failure:^(NSError *error) {
              [MBProgressHUD hideHUD];
          }];
         
     } failure:^(NSError *error) {
         
     }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录";
    
    self.usrname = [self.view addInputTextFieldWithTitle:@"账号  "
                                             placeHolder:@"手机号/用户名"
                                                delegate:self
                                                  target:self
                                                  action:@selector(textChange)];
    self.usrname.frame = CGRectMake(10, 10, KWidthMargin, 40);
    
    [self.view addSplitLineWithFrame:CGRectMake(10, CGRectGetMaxY(self.usrname.frame), kScreenW - 10, kSplitLineHeight)];
    
    self.password = [self.view addInputTextFieldWithTitle:@"密码  "
                                              placeHolder:@"请输入密码"
                                                 delegate:self
                                                   target:self
                                                   action:@selector(textChange)];
    
    self.password.frame = CGRectMake(10, CGRectGetMaxY(self.usrname.frame), kScreenW - 50, 40);
    self.password.secureTextEntry = YES;

    [self.view addSplitLineWithFrame:CGRectMake(10, CGRectGetMaxY(self.password.frame), kScreenW - 10, kSplitLineHeight)];
    
    UIButton *showPassedBtn = [self.view addButtonSelectedSetImage:@"mimaHide"
                                                          selected:@"mimaShow"
                                                            target:self
                                                            action:@selector(showPassedClick:)];
    showPassedBtn.frame = CGRectMake(kScreenW - 30, CGRectGetMaxY(self.usrname.frame) + 15, 20, 12);
    
    self.loginBtn = [self.view addButtonFilletWithTitle:@"登录"
                                                 target:self
                                                 action:@selector(loadThePublicKey)];
    self.loginBtn.frame = CGRectMake(10, CGRectGetMaxY(self.password.frame) + 20, KWidthMargin, 44);
    self.loginBtn.enabled = NO;
    
    UIButton *registerBtn = [self.view addButtonWithTitle:@"快速注册"
                                                   target:self
                                                   action:@selector(registerBtnClick)];
    registerBtn.frame = CGRectMake(10, CGRectGetMaxY(self.loginBtn.frame) + 20, 70, 20);
    
    UIButton *retrievePassword = [self.view addButtonWithTitle:@"忘记密码"
                                                        target:self
                                                        action:@selector(retrievePasswordClick)];
    retrievePassword.frame = CGRectMake(kScreenW - 80, CGRectGetMaxY(self.loginBtn.frame) + 20, 70, 20);
    
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endEditingTap:)]];
}
#pragma mark - 点击空白 键盘消失
- (void)endEditingTap:(UITapGestureRecognizer *)hidenTextTap
{
    [self.view endEditing:YES];
}

#pragma mark -快速注册
- (void)registerBtnClick
{
    [self.navigationController pushViewController:[RegisterVC new] animated:YES];
}

#pragma mark -忘记密码
- (void)retrievePasswordClick
{
    [self.navigationController pushViewController:[RetrievePassVC new] animated:YES];
}

#pragma mark -监听 输入状态
- (void)textChange
{
    if (self.usrname.text.length >0 && self.password.text.length > 0)
    {
        self.loginBtn.enabled = YES;
    }
    else{
        self.loginBtn.enabled = NO;
    }
}

#pragma mark -显示隐藏密码
- (void)showPassedClick:(UIButton *)button
{
    [self.view endEditing:YES];

    button.selected = !button.selected;
    if (button.selected == YES) {
        self.password.secureTextEntry = NO;
    }else{
        self.password.secureTextEntry = YES;
    }
}

@end
