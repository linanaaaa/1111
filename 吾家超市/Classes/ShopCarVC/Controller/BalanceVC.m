//
//  BalanceVC.m
//  吾家超市
//
//  Created by iMac15 on 2016/12/20.
//  Copyright © 2016年 iMac15. All rights reserved.
//

#import "BalanceVC.h"

@interface BalanceVC ()
@property (strong, nonatomic) UILabel *balanLab;
@property (strong, nonatomic) UITextField *balanTF;
@property (strong, nonatomic) UIButton *leftBtn;
@property (strong, nonatomic) UIButton *rightBtn;

@property (strong, nonatomic) ZNGLoginResult *dataModel;
@property (strong, nonatomic) NSString *balanceStr;         //可用余额
@end

@implementation BalanceVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadUserMember];
}

#pragma mark -获取会员 余额/消费资本
- (void)loadUserMember
{
    kWeakSelf
    [WJRequestTool get:kUserMemberUrl param:nil resultClass:[ZNGLoginResult class] successBlock:^(ZNGLoginResult *result)
     {
         weakSelf.balanceStr = result.t.balance;
         weakSelf.balanLab.text = [NSString stringWithFormat:@"* 可用余额: ¥ %@元",weakSelf.balanceStr];
     } failure:^(NSError *error) {
         
     }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"余额";
    self.view.backgroundColor = kGlobalBackgroundColor;
    
    self.balanLab = [self.view addLabelWithText:@""];
    self.balanLab.frame = CGRectMake(10, 10, kScreenW - 20, 30);
    
    self.balanTF = [self.view addTextFieldWithPlaceholder:@" 请输入余额" delegate:self target:self action:nil];
    self.balanTF.text = self.balanceTFStr;
    self.balanTF.frame = CGRectMake(10, CGRectGetMaxY(self.balanLab.frame), kScreenW - 20, 30);
    
    self.leftBtn = [self.view addButtonFilletWithTitle:@"立即使用" target:self action:@selector(leftBtnClick)];
    self.leftBtn.frame = CGRectMake(10, CGRectGetMaxY(self.balanTF.frame) + 20, (kScreenW - 30)/2, 30);
    
    self.rightBtn = [self.view addButtonFilletWithTitle:@"取消使用" target:self action:@selector(rightBtnClick)];
    [self.rightBtn setBackgroundImage:[UIImage imageWithColor:kBtnDisabledColor] forState:UIControlStateNormal];
    [self.rightBtn setBackgroundImage:[UIImage imageWithColor:kBtnDisabledColor] forState:UIControlStateHighlighted];
    self.rightBtn.frame = CGRectMake(kScreenW - (kScreenW - 30)/2 - 10, CGRectGetMaxY(self.balanTF.frame) + 20, (kScreenW - 30)/2, 30);
}

#pragma mark -立即使用  余额
- (void)leftBtnClick
{
    [self.view endEditing:YES];
    
    if ([self.balanTF.text integerValue] > [self.balanceStr integerValue]) {
        [MBProgressHUD showTextMessage:@"输入金额 不准大于 可用余额!"];
    }
    else if ([self.balanTF.text integerValue] > [self.priceStr integerValue]) {
        [MBProgressHUD showTextMessage:@"使用余额,不准大于商品总价!"];
        return;
    }
    else{
        self.balanceBlock(self.balanTF.text);
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark -取消使用
- (void)rightBtnClick
{
    if (!kStringIsEmpty(self.balanTF.text)){
        self.balanTF.text = 0;
        self.balanceBlock(self.balanTF.text);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

@end
