//
//  CatibalVC.m
//  吾家超市
//
//  Created by iMac15 on 2016/12/20.
//  Copyright © 2016年 iMac15. All rights reserved.
//

#import "CatibalVC.h"

@interface CatibalVC ()
@property (strong, nonatomic) UILabel *capitalLab;
@property (strong, nonatomic) UITextField *capitalTF;
@property (strong, nonatomic) UIButton *leftBtn;
@property (strong, nonatomic) UIButton *rightBtn;

@property (strong, nonatomic) ZNGLoginResult *dataModel;
@property (strong, nonatomic) NSString *capitalStr;         //消费资本
@end

@implementation CatibalVC

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
         weakSelf.capitalStr = result.t.blanceCapital;
         weakSelf.capitalLab.text = [NSString stringWithFormat:@"* 可用消费资本: %@元",weakSelf.capitalStr];
         
     } failure:^(NSError *error) {
         
     }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"消费资本";
    self.view.backgroundColor = kGlobalBackgroundColor;
    
    self.capitalLab = [self.view addLabelWithText:@""];
    self.capitalLab.frame = CGRectMake(10, 0, kScreenW - 20, 30);
    
    self.capitalTF = [self.view addTextFieldWithPlaceholder:@" 请输入消费资本" delegate:self target:self action:nil];
    self.capitalTF.text = self.catibalTFStr;
    self.capitalTF.frame = CGRectMake(10, CGRectGetMaxY(self.capitalLab.frame), kScreenW - 20, 30);
    
    self.leftBtn = [self.view addButtonFilletWithTitle:@"立即使用" target:self action:@selector(leftBtnClick)];
    self.leftBtn.frame = CGRectMake(10, CGRectGetMaxY(self.capitalTF.frame) + 20, (kScreenW - 30)/2, 30);
    
    self.rightBtn = [self.view addButtonFilletWithTitle:@"取消使用" target:self action:@selector(rightBtnClick)];
    [self.rightBtn setBackgroundImage:[UIImage imageWithColor:kBtnDisabledColor] forState:UIControlStateNormal];
    [self.rightBtn setBackgroundImage:[UIImage imageWithColor:kBtnDisabledColor] forState:UIControlStateHighlighted];
    self.rightBtn.frame = CGRectMake(kScreenW - 10 -(kScreenW - 30)/2, CGRectGetMaxY(self.capitalTF.frame) + 20, (kScreenW - 30)/2, 30);
}

#pragma mark -立即使用  消费资本
- (void)leftBtnClick
{
    [self.view endEditing:YES];
    
    if ([self.capitalTF.text integerValue] > [self.capitalStr integerValue]) {
        [MBProgressHUD showTextMessage:@"输入金额 不准大于 可用消费资本!"];
    }
    else if ([self.capitalTF.text integerValue] > [self.priceStr integerValue]) {
        [MBProgressHUD showTextMessage:@"使用消费资本,不准大于商品总价!"];
        return;
    }
    else{
        self.catibalBlock(self.capitalTF.text);
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark -取消使用
- (void)rightBtnClick
{
    if (!kStringIsEmpty(self.capitalTF.text))
    {
        self.capitalTF.text = 0;
        self.catibalBlock(self.capitalTF.text);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
