//
//  PutInSalesVC.m
//  吾家超市
//
//  Created by iMac15 on 2017/2/15.
//  Copyright © 2017年 iMac15. All rights reserved.
//

#import "PutInSalesVC.h"
#import "PPNumberButton.h"

@interface PutInSalesVC ()<UITextFieldDelegate,UITextViewDelegate>
@property (strong, nonatomic) UIButton *returnBtn;
@property (strong, nonatomic) UIButton *changeBtn;
@property (strong, nonatomic) NSString *typeStr;
@property (strong, nonatomic) PPNumberButton *numberButton;
@property (strong, nonatomic) NSString *quantityStr;
@property (strong, nonatomic) UITextView *textView;
@property (strong, nonatomic) UITextField *addressField;
@property (strong, nonatomic) UITextField *logisticsSNField;
@property (strong, nonatomic) UITextField *logisticsNameField;
@property (strong, nonatomic) UIButton *sendBtn;
@end

@implementation PutInSalesVC

#pragma mark -提交申请
- (void)sendBtnClick
{
    /*
     orderItemId =订单项id
     memo=原因
     type=退换货类型（returns=退货，replacement=换货）
     quantity=退换货数量
     address=物流公司地址
     customerDeliveryCorp=物流公司
     customerTrackingNo =物流单号
     */
    //8987
    
    if (kStringIsEmpty(self.textView.text)) {
        [MBProgressHUD showTextMessage:@"请输入原因!"];
        return;
    }
    else if (kStringIsEmpty(self.addressField.text)){
        [MBProgressHUD showTextMessage:@"请输入地址!"];
        return;
    }
    else if (kStringIsEmpty(self.logisticsSNField.text)){
        [MBProgressHUD showTextMessage:@"请输入物流公司单号!"];
        return;
    }
    else if (kStringIsEmpty(self.logisticsNameField.text)){
        [MBProgressHUD showTextMessage:@"请输入物流公司名称!"];
        return;
    }
    
    NSDictionary *param = @{@"orderItemId":@"8885",
                            @"memo":self.textView.text,
                            @"type":self.typeStr,
                            @"quantity":self.quantityStr,
                            @"address":self.addressField.text,
                            @"customerDeliveryCorp":self.logisticsNameField.text,
                            @"customerTrackingNo":self.logisticsSNField.text
                            };
    
    [WJRequestTool post:kSalesSaveUrl param:param successBlock:^(WJBaseRequestResult *result)
    {
        NSLog(@"%@",result);
        if ([result.type isEqualToString:@"success"]) {
            [MBProgressHUD showTextMessage:@"提交成功,请耐心等待!"];
            [self.navigationController popViewControllerAnimated:YES];
        }
        
    } failure:^(NSError *error) {
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"申请退货";
    [self.view addTopSplitLine];
    self.view.backgroundColor = kGrayBackgroundColor;
    
    self.typeStr = @"returns";  //默认退货

    UILabel *typeLab = [self.container addLabelWithText:@"类型"];
    typeLab.frame = CGRectMake(10, 10, 100, 30);
    
    self.returnBtn = [self.container addButtonLineWithTitle:@"退货" target:self action:@selector(returnBtnClick)];
    self.returnBtn.frame = CGRectMake(10, CGRectGetMaxY(typeLab.frame), 100, 30);
    self.returnBtn.selected = YES;
    self.returnBtn.layer.borderColor = kGlobalRedColor.CGColor;
    [self.returnBtn setTitleColor:kGlobalRedColor forState:UIControlStateNormal];

    self.changeBtn = [self.container addButtonLineWithTitle:@"换货" target:self action:@selector(changeBtnClick)];
    self.changeBtn.frame = CGRectMake(CGRectGetMaxX(self.returnBtn.frame) + 20, CGRectGetMaxY(typeLab.frame), 100, 30);
    
    [self.container addSplitLineWithFrame:CGRectMake(10, CGRectGetMaxY(self.returnBtn.frame) + 10, kScreenW - 10, kSplitLineHeight)];
    
    UILabel *numberLab = [self.container addLabelWithText:@"商品数量"];
    numberLab.frame = CGRectMake(10, CGRectGetMaxY(self.returnBtn.frame) + 20, 80, 30);
    
    self.numberButton = [[PPNumberButton alloc] initWithFrame:CGRectMake(100, CGRectGetMaxY(numberLab.frame), 80, 20)];
    self.numberButton.shakeAnimation = YES;
    self.numberButton.editing = NO;
    self.numberButton.maxValue = [self.maxNumberStr integerValue];
    self.numberButton.increaseImage = [UIImage imageNamed:@"increase_taobao"];
    self.numberButton.decreaseImage = [UIImage imageNamed:@"decrease_taobao"];
    [self.container addSubview:self.numberButton];
    
    kWeakSelf
    self.numberButton.resultBlock = ^(NSInteger number, BOOL increaseStatus)
    {
        weakSelf.quantityStr = [NSString stringWithFormat:@"%ld",number];
    };
    
    [self.container addSplitLineWithFrame:CGRectMake(10, CGRectGetMaxY(self.numberButton.frame) + 10, kScreenW - 10, kSplitLineHeight)];

    UILabel *textLab = [self.container addLabelWithText:@"原因"];
    textLab.frame = CGRectMake(10, CGRectGetMaxY(self.numberButton.frame) + 20, 80, 30);
    
    self.textView = [self.container addTextViewWithDelegate:self fontSize:14];
    self.textView.frame = CGRectMake(10, CGRectGetMaxY(textLab.frame), kScreenW - 20, 120);
    
    self.addressField = [self.container addInputTextFieldWithTitle:@"收货地址  "
                                                  placeHolder:@"请输入详细收货地址"
                                                     delegate:self
                                                       target:self
                                                            action:@selector(textClick:)];
    self.addressField.frame = CGRectMake(10, CGRectGetMaxY(self.textView.frame) + 20, kScreenW - 20, 40);
    self.addressField.backgroundColor = [UIColor whiteColor];
    
    self.logisticsSNField = [self.container addInputTextFieldWithTitle:@"物流单号  "
                                                          placeHolder:@"请输入物流单号"
                                                             delegate:self
                                                               target:self
                                                               action:@selector(textClick:)];
    self.logisticsSNField.frame = CGRectMake(10, CGRectGetMaxY(self.addressField.frame) + 20, kScreenW - 20, 40);
    self.logisticsSNField.backgroundColor = [UIColor whiteColor];
    
    self.logisticsNameField = [self.container addInputTextFieldWithTitle:@"物流公司  "
                                                             placeHolder:@"请输入物流公司名称"
                                                                delegate:self
                                                                  target:self
                                                                  action:@selector(textClick:)];
    self.logisticsNameField.frame = CGRectMake(10, CGRectGetMaxY(self.logisticsSNField.frame) + 20, kScreenW - 20, 40);
    self.logisticsNameField.backgroundColor = [UIColor whiteColor];
    
    self.sendBtn = [self.container addButtonFilletWithTitle:@"提交申请"
                                                 target:self
                                                 action:@selector(sendBtnClick)];
    self.sendBtn.frame = CGRectMake(10, CGRectGetMaxY(self.logisticsNameField.frame) + 20, kScreenW - 20, 40);
}

- (void)textClick:(UITextField *)text
{

}

#pragma mark -退货选择
- (void)returnBtnClick
{
    self.changeBtn.selected = NO;
    self.changeBtn.layer.borderColor = kGlobalBackColor.CGColor;
    [self.changeBtn setTitleColor:kGlobalTextColor forState:UIControlStateNormal];
    
    self.returnBtn.selected = YES;
    self.returnBtn.layer.borderColor = kGlobalRedColor.CGColor;
    [self.returnBtn setTitleColor:kGlobalRedColor forState:UIControlStateNormal];
    
    self.typeStr = @"returns";
}

#pragma mark -换货选择
- (void)changeBtnClick
{
    self.changeBtn.selected = YES;
    self.changeBtn.layer.borderColor = kGlobalRedColor.CGColor;
    [self.changeBtn setTitleColor:kGlobalRedColor forState:UIControlStateNormal];
    
    self.returnBtn.selected = NO;
    self.returnBtn.layer.borderColor = kGlobalBackColor.CGColor;
    [self.returnBtn setTitleColor:kGlobalTextColor forState:UIControlStateNormal];
    
    self.typeStr = @"replacement";
}

@end
