//
//  CouponVC.m
//  吾家超市
//
//  Created by iMac15 on 2016/12/20.
//  Copyright © 2016年 iMac15. All rights reserved.
//

#import "CouponVC.h"
#import "OrderModel.h"

@interface CouponVC ()<UITextFieldDelegate>
@property (strong, nonatomic) UILabel *label;
@property (strong, nonatomic) UILabel *ditailLab;
@property (strong, nonatomic) UITextField *textField;
@property (strong, nonatomic) UIButton *btn;
@end

@implementation CouponVC

#pragma mark -提交验证优惠码
- (void)btnClick
{
    [self.view endEditing:YES];
    
    kWeakSelf
    
    NSDictionary *param = @{@"code":self.textField.text};
    
    [WJRequestTool post:kCouponinfoUrl param:param resultClass:[CouponResult class] successBlock:^(CouponResult *result)
     {
         if ([result.type isEqualToString:@"success"])
         {
             NSString *message = [NSString stringWithFormat:@"使用当前优惠券立减 %@ 元",result.t.couponDiscount];
             
             WJAlertView *alertView = [[WJAlertView alloc] initWithTitle:@"提示" message:message cancelButtonTitle:@"立即使用" otherButtonTitles:@"取消", nil];
             
             [alertView showWithButtonClickAction:^(NSInteger index) {
                 if (index == 0) {
                     weakSelf.couponBlock(weakSelf.textField.text);
                     [weakSelf.navigationController popViewControllerAnimated:YES];
                 }
             }];
         }
         
     } failure:^(NSError *error) {
         
     }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"使用优惠码";
    self.view.backgroundColor = kGrayBackgroundColor;
    
    self.label = [self.view addLabelWithText:@"请输入优惠码:"];
    self.label.frame = CGRectMake(10, 10, 180, 30);
    
    self.textField = [self.view addTextFieldWithPlaceholder:@"" delegate:self target:self action:@selector(textChange)];
    self.textField.frame = CGRectMake(10, CGRectGetMaxY(self.label.frame), kScreenW - 20, 30);
    
    self.ditailLab = [self.view addLabelWithText:@"(*优惠码是由吾家网发放,解释权归吾家网所有*)" color:kGlobalTextColor];
    self.ditailLab.frame = CGRectMake(10, CGRectGetMaxY(self.textField.frame), kScreenW - 20, 25);
    
    self.btn = [self.view addButtonFilletWithTitle:@"立即使用" target:self action:@selector(btnClick)];
    self.btn.frame = CGRectMake(10, CGRectGetMaxY(self.ditailLab.frame) + 20, kScreenW - 20, 44);
    self.btn.enabled = NO;
}

#pragma mark -监听 输入状态
- (void)textChange
{
    if (self.textField.text.length >0)
    {
        self.btn.enabled = YES;
    }
    else{
        self.btn.enabled = NO;
    }
}

@end
