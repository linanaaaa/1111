//
//  SuccessPayForVC.m
//  吾家超市
//
//  Created by iMac15 on 2016/11/21.
//  Copyright © 2016年 iMac15. All rights reserved.
//

#import "SuccessPayForVC.h"
#import "OrderDetailsVC.h"

@interface SuccessPayForVC ()
@property (strong, nonatomic) UILabel *titleLab;
@property (strong, nonatomic) UIView *backView;
@property (strong, nonatomic) UILabel *priceLab;
@property (strong, nonatomic) UILabel *payLab;
@property (strong, nonatomic) UILabel *addressLab;
@property (strong, nonatomic) UIButton *orderBtn;
@property (strong, nonatomic) UIButton *backHomeBtn;
@end

@implementation SuccessPayForVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单完成";
    self.view.backgroundColor = kGrayBackgroundColor;
    
    self.titleLab = [[UILabel alloc] init];
    self.titleLab.frame = CGRectMake(0, 0, kScreenW, 100);
    self.titleLab.text = @"交易成功";
    self.titleLab.textColor = [UIColor blackColor];
    self.titleLab.font = [UIFont systemFontOfSize:24];
    [self.titleLab setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:self.titleLab];
    
    self.backView = [[UIView alloc] init];
    self.backView.frame = CGRectMake(0, CGRectGetMaxY(self.titleLab.frame), kScreenW, 130);
    self.backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.backView];
    
    self.priceLab = [self.backView addLabelWithText:@"" color:[UIColor blackColor]];
    self.priceLab.frame = CGRectMake(10, 0, kScreenW - 20, 30);
    self.priceLab.text = [NSString stringWithFormat:@"付款金额: %.2f元",[self.priceStr floatValue]];
    
    self.payLab = [self.backView addLabelWithText:@"" color:[UIColor blackColor]];
    self.payLab.frame = CGRectMake(10, CGRectGetMaxY(self.priceLab.frame), kScreenW - 20, 30);
    self.payLab.text = [NSString stringWithFormat:@"支付方式: %@",self.paymentMethodNameStr];
    
    self.addressLab = [self.backView addLabelWithText:@"" color:[UIColor blackColor]];
    self.addressLab.frame = CGRectMake(10, CGRectGetMaxY(self.payLab.frame), kScreenW - 20, 60);
    self.addressLab.numberOfLines = 2;
    self.addressLab.text = [NSString stringWithFormat:@"货物寄送至: %@",self.addressStr];
    
    self.backHomeBtn = [self.view addButtonLineWithTitle:@"返回首页" target:self action:@selector(popVC)];
    self.backHomeBtn.frame = CGRectMake(kScreenW - 90, CGRectGetMaxY(self.backView.frame) + 10, 80, 30);
    
    self.orderBtn = [self.view addButtonLineWithTitle:@"查看订单" target:self action:@selector(orderClick)];
    self.orderBtn.frame = CGRectMake(kScreenW - 180, CGRectGetMaxY(self.backView.frame) + 10, 80, 30);
    
    NSString *str = @"*安全提示\n 吾家网不会以订单异常,系统升级或其他任何理由,要求您点击任何链接进行操作,也不会索要账号,银行卡号以及密码等信息.";
    
    CGFloat height = kTextHeight(str, kTextFont, kScreenW - 20);
    
    UITextView *textView = [[UITextView alloc] init];
    textView.frame = CGRectMake(10, CGRectGetMaxY(self.backHomeBtn.frame) + 10, kScreenW - 20, height);
    textView.textColor = [UIColor grayColor];
    textView.backgroundColor = [UIColor clearColor];
    textView.text = @"*安全提示\n 吾家网不会以订单异常,系统升级或其他任何理由,要求您点击任何链接进行操作,也不会索要账号,银行卡号以及密码等信息.";
    [self.view addSubview:textView];
}

#pragma mark -返回首页
- (void)popVC
{
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    TabBarController *tabBarController = [[TabBarController alloc] init];
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:tabBarController];
    window.rootViewController = nav;
}

#pragma mark -查看订单详情
- (void)orderClick
{
    OrderDetailsVC *vc = [[OrderDetailsVC alloc] init];
    vc.orderSN = self.successPayIDStr;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
