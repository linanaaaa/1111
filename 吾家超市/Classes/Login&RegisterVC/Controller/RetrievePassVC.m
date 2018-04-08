//
//  RetrievePassVC.m
//  吾家超市
//
//  Created by iMac15 on 2016/10/25.
//  Copyright © 2016年 iMac15. All rights reserved.
//

#import "RetrievePassVC.h"
#import "ResetPasswordVC.h"
#import "WJCountdownButton.h"

@interface RetrievePassVC ()<UITextFieldDelegate>
@property (nonatomic, strong) UITextField *phoneTf;
@property (nonatomic, strong) UITextField *codeTf;
@property (nonatomic, strong) UIButton *nextBtn;
@property (nonatomic, strong) WJCountdownButton *countdownBtn;
@end

@implementation RetrievePassVC

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.codeTf.text = nil;
}

#pragma mark  -下一步
- (void)nextBtnDidClick
{
    [self.view endEditing:YES];
    NSDictionary *param = @{
                            @"phone":self.phoneTf.text,
                            @"generateCode":self.codeTf.text,
                            };
    
    [WJRequestTool post:kValidateUrl param:param successBlock:^(WJBaseRequestResult *result)
     {
         ResetPasswordVC *vc = [[ResetPasswordVC alloc] init];
         vc.phone = self.phoneTf.text;
         vc.generateCode = self.codeTf.text;
         [self.navigationController pushViewController:vc animated:YES];
         
     } failure:^(NSError *error) {
         
     }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"找回密码";
    
    self.phoneTf = [self.view addTextFieldWithPlaceholder:@"请输入您的手机号"
                                                 delegate:self
                                                   target:self
                                                   action:@selector(textChange:)];
    self.phoneTf.frame = CGRectMake(10, 10, kScreenW - 120, 40);
    
    self.countdownBtn = [WJCountdownButton countdownButtonWithSecond:60];
    self.countdownBtn.frame = CGRectMake(kScreenW - 110, 10, 100, 30);
    self.countdownBtn.type = 1;
    [self.view addSubview:self.countdownBtn];
    
    if (!kStringIsEmpty(self.phoneStr)) {
        self.phoneTf.text = self.phoneStr;
        self.countdownBtn.phoneNumber = self.phoneStr;
        self.phoneTf.userInteractionEnabled = NO;
    }
    
    [self.view addSplitLineWithFrame:CGRectMake(10, CGRectGetMaxY(self.phoneTf.frame), kScreenW - 10, kSplitLineHeight)];
    
    self.codeTf = [self.view addTextFieldWithPlaceholder:@"请输入验证码"
                                                delegate:self
                                                  target:self
                                                  action:@selector(textChange:)];
    self.codeTf.frame = CGRectMake(10, CGRectGetMaxY(self.phoneTf.frame) + 2, kScreenW - 20, 40);
    
    [self.view addSplitLineWithFrame:CGRectMake(10, CGRectGetMaxY(self.codeTf.frame), kScreenW - 10, kSplitLineHeight)];
    
    
    self.nextBtn = [self.view addButtonFilletWithTitle:@"下一步"
                                                target:self
                                                action:@selector(nextBtnDidClick)];
    self.nextBtn.frame = CGRectMake(10, CGRectGetMaxY(self.codeTf.frame) + 20, kScreenW - 20, 44);
    self.nextBtn.enabled = NO;
    
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endEditingTap:)]];
}

- (void)checkRegisterBtnIsEnable
{
    if (self.phoneTf.text.length > 0 && self.codeTf.text.length > 0) {
        self.nextBtn.enabled = YES;
    }
    else {
        self.nextBtn.enabled = NO;
    }
}

- (void)textChange:(UITextField *)textField
{
    if (textField == self.phoneTf) {
        [textField textLenghtWithLimit:11];
        self.countdownBtn.phoneNumber = textField.text;
    }
    
    [self checkRegisterBtnIsEnable];
}

#pragma mark - 点击空白 键盘消失
- (void)endEditingTap:(UITapGestureRecognizer *)hidenTextTap
{
    [self.view endEditing:YES];
}

@end
