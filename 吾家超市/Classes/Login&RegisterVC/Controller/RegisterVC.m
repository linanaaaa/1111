//
//  RegisterVC.m
//  吾家超市
//
//  Created by iMac15 on 2016/10/31.
//  Copyright © 2016年 iMac15. All rights reserved.
//

#import "RegisterVC.h"
#import "AgreementVC.h"
#import "SetPasswordVC.h"
#import "WJCountdownButton.h"

@interface RegisterVC ()<UITextFieldDelegate>
@property (nonatomic, strong) UITextField *phoneTf;
@property (nonatomic, strong) UITextField *codeTf;
@property (nonatomic, strong) WJCountdownButton *countdownBtn;
@property (nonatomic, strong) UILabel *hideLab;
@property (nonatomic, strong) UIButton *nextBtn;
@property (nonatomic, strong) UIButton *agreeBtn;
@end

@implementation RegisterVC

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
    self.codeTf.text = nil;
}

#pragma mark -注册 下一步
- (void)nextBtnDidClick
{
    [self.view endEditing:YES];
    
    if (!self.agreeBtn.selected) {
        [MBProgressHUD showTextMessage:@"请勾选 我已经阅读并同意吾家网协议"];
        return;
    }
    
    NSDictionary *param = @{
                            @"phone":self.phoneTf.text,
                            @"generateCode":self.codeTf.text,
                            };
    
    [WJRequestTool post:kValidateUrl param:param successBlock:^(WJBaseRequestResult *result)
     {
         SetPasswordVC *vc = [[SetPasswordVC alloc] init];
         vc.phoneStr = self.phoneTf.text;
         vc.codeStr = self.codeTf.text;
         [self.navigationController pushViewController:vc animated:YES];
         
     } failure:^(NSError *error) {
         
     }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册";
    
    self.phoneTf = [self.view addTextFieldWithPlaceholder:@"请输入您的手机号"
                                                 delegate:self
                                                   target:self
                                                   action:@selector(textChange:)];
    self.phoneTf.frame = CGRectMake(10, 10, kScreenW - 120, 40);
    
    self.countdownBtn = [WJCountdownButton countdownButtonWithSecond:60];
    self.countdownBtn.type = 0;
    self.countdownBtn.frame = CGRectMake(kScreenW - 110, 10, 100, 30);
    [self.view addSubview:self.countdownBtn];
    
    self.codeTf = [self.view addTextFieldWithPlaceholder:@"请输入验证码"
                                                delegate:self
                                                  target:self
                                                  action:@selector(textChange:)];
    self.codeTf.frame = CGRectMake(10, CGRectGetMaxY(self.phoneTf.frame), kScreenW - 20, 40);
    
    
    self.agreeBtn = [[UIButton alloc] init];
    self.agreeBtn.frame = CGRectMake(10, CGRectGetMaxY(self.codeTf.frame) + 10, 150, 20);
    [self.agreeBtn setTitle:@"我已经阅读并同意" forState:UIControlStateNormal];
    [self.agreeBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.agreeBtn setImage:[UIImage imageNamed:@"agree"] forState:UIControlStateNormal];
    [self.agreeBtn setImage:[UIImage imageNamed:@"agreeS"] forState:UIControlStateSelected];
    [self.agreeBtn addTarget:self action:@selector(agreeBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
    self.agreeBtn.selected = YES;
    self.agreeBtn.titleLabel.font = kFontSize(12.0);
    [self.view addSubview:self.agreeBtn];
    self.agreeBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    
    NSMutableAttributedString *agreeStr = [[NSMutableAttributedString alloc] initWithString:@"<<吾家网用户注册协议>>"];
    NSRange strRange = {0,[agreeStr length]};
    [agreeStr addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:strRange];
    
    UIButton *agreement = [[ UIButton alloc] init];
    agreement.frame = CGRectMake(CGRectGetMaxX(self.agreeBtn.frame), CGRectGetMaxY(self.codeTf.frame) + 10, kScreenW - 170, 20);
    [agreement setAttributedTitle:agreeStr forState:UIControlStateNormal];
    [agreement setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [agreement addTarget:self action:@selector(showAgreement) forControlEvents:UIControlEventTouchUpInside];
    agreement.titleLabel.font = kFontSize(12.0);
    agreement.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.view addSubview:agreement];
    
    self.nextBtn = [self.view addButtonFilletWithTitle:@"下一步"
                                                target:self
                                                action:@selector(nextBtnDidClick)];
    self.nextBtn.frame = CGRectMake(10, CGRectGetMaxY(self.agreeBtn.frame) + 20, kScreenW - 20, 44);
    self.nextBtn.enabled = NO;
    
    [self.view addSplitLineWithFrame:CGRectMake(10, CGRectGetMaxY(self.phoneTf.frame), kScreenW - 10, kSplitLineHeight)];
    
    [self.view addSplitLineWithFrame:CGRectMake(10, CGRectGetMaxY(self.codeTf.frame), kScreenW - 10, kSplitLineHeight)];
    
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endEditingTap:)]];
}

#pragma mark -勾选用户协议
- (void)agreeBtnDidClick:(UIButton *)button
{
    button.selected = !button.selected;
}

#pragma mark -吾家网用户协议
- (void)showAgreement
{
    [self.navigationController pushViewController:[AgreementVC new] animated:YES];
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
