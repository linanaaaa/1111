//
//  PayOrderVC.m
//  吾家超市
//
//  Created by iMac15 on 2016/12/22.
//  Copyright © 2016年 iMac15. All rights reserved.
//

#import "PayOrderVC.h"
#import "PayOrderModel.h"
#import "SuccessPayForVC.h"
#import "OrderDetailsVC.h"

#import "WXApi.h"
#import "WXApiObject.h"
#import <AlipaySDK/AlipaySDK.h>

@interface PayOrderVC ()
@property (strong, nonatomic) UILabel *numberLab;
@property (strong, nonatomic) UILabel *priceLab;
@property (strong, nonatomic) UIImageView *baoImage;
@property (strong, nonatomic) UIImageView *weiImage;
@property (strong, nonatomic) UIButton *weiSelectBtn;
@property (strong, nonatomic) UIButton *baoSelectBtn;
@property (strong, nonatomic) UIButton *payForBtn;
@property (strong, nonatomic) UIButton *goBackForBtn;

@property (strong, nonatomic) UIButton *weiBtn;
@property (strong, nonatomic) UIButton *baoBtn;

@property (strong, nonatomic) NSString *paymentSn;
@end

@implementation PayOrderVC
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self payMentSN];
}

- (void)payMentSN
{
    kWeakSelf
    NSDictionary *param = @{@"orderSns":self.payNumberStr
                            };
    
    [WJRequestTool get:kPaymentUrl param:param resultClass:[PayOrderPaymentResult class] successBlock:^(PayOrderPaymentResult *result)
     {
         WJLog(@"获取付款单号");
         weakSelf.numberLab.text = [NSString stringWithFormat:@"订单号: %@",result.t.orderSns];
         weakSelf.paymentSn = result.t.orderSns;
     } failure:^(NSError *error) {
         
     }];
}

- (void)payforClick
{
    NSDictionary *param;
    NSString *url;
    
    if (self.baoSelectBtn.selected == YES) {
        param = @{@"orderSn":self.paymentSn,                  // 支付宝支付
                  @"paymentPluginId":@"alipayAppPlugin",
                  };
        url = kBaoSubmitUrl;

        [WJRequestTool post:url param:param resultClass:[AlipayOrderResult class] successBlock:^(AlipayOrderResult *result)
         {
             WJLog(@"%@",result);
             
             [[AlipaySDK defaultService] payOrder:result.t.orderStr fromScheme:@"aliPayWjw" callback:^(NSDictionary *resultDic)
             {
                 WJLog(@"请求成功:result = %@",resultDic);

             }];

         } failure:^(NSError *error) {
             
         }];
    }
    else{
        param = @{@"orderSn":self.paymentSn,                 // 微信支付
                  @"paymentPluginId":@"wxpayANDPlugin"       //wxpayIOSPlugin -- ios
                                                             //wxpayANDPlugin --安卓
                  };
        url = kWeiSubmitUrl;

        [WJRequestTool post:url param:param resultClass:[PayOrderResult class] successBlock:^(PayOrderResult *result)
         {
             WJLog(@"%@",result);
             
             PayReq *req = [[PayReq alloc] init];    //需要创建这个支付对象
             req.openID = result.t.appid;            //应用id
             req.partnerId = result.t.partnerid;     //商家商户号
             req.prepayId = result.t.prepayid;       //预支付订单这个是后台跟微信服务器交互后，微信服务器传给你们服务器的，你们服务器再传给你
             req.package = @"Sign=WXPay";            //这个比较特殊，是固定的，只能是即req.package = Sign=WXPay
             req.nonceStr = result.t.noncestr;       //随机编码，为了防止重复的，在后台生成
             req.sign = result.t.sign; //这个签名也是后台做的
             
             NSString * stamp = result.t.timestamp;  //这个是时间戳，也是在后台生成的，为了验证支付的
             req.timeStamp = stamp.intValue;
             
             if (![WXApi isWXAppInstalled]) {
                 [MBProgressHUD showTextMessage:@"未监测到微信,请先前往AppStore下载!" hideAfter:3.0];
             }else{
                 //发送请求到微信，等待微信返回onResp
                 [WXApi sendReq:req];
             }
             
         } failure:^(NSError *error) {
             
         }];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单支付";
    self.view.backgroundColor = kGlobalBackgroundColor;
    
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(btnClick) name:@"WX_PaySuccess" object:nil];
    
    self.numberLab = [self.view addLabelWithText:@"" color:[UIColor blackColor]];
//    self.numberLab.text = [NSString stringWithFormat:@"订单号: %@",self.payNumberStr];
    self.numberLab.frame = CGRectMake(10, 10, kScreenW - 20, 30);
    
    self.priceLab = [self.view addLabelWithText:@"" color:[UIColor blackColor]];
    self.priceLab.text = [NSString stringWithFormat:@"需支付: %.2f元",[self.payPriceStr floatValue]];
    self.priceLab.frame = CGRectMake(10, CGRectGetMaxY(self.numberLab.frame), kScreenW - 20, 30);
    
    UILabel *lab = [self.view addLabelWithText:@"(订单需要在24小时内支付完成!否则自动取消)"];
    lab.frame = CGRectMake(10, CGRectGetMaxY(self.priceLab.frame), kScreenW - 20, 30);
    
    UIView *baoView = [[UIView alloc] init];
    baoView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:baoView];
    baoView.frame = CGRectMake(10, CGRectGetMaxY(lab.frame) + 20, kScreenW - 20, 44);
    
    UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo-zhifubao"]];
    image.frame = CGRectMake(10, 7, 30, 30);
    [baoView addSubview:image];
    
    UILabel *lab2 = [baoView addLabelWithText:@"支付宝"];
    lab2.frame = CGRectMake(CGRectGetMaxX(image.frame) + 10, 7, 70, 30);
    
    self.baoImage =  [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"agreeS"]];
    self.baoImage.frame = CGRectMake(baoView.frame.size.width - 30, 14, 15, 15);
    self.baoImage.backgroundColor = [UIColor clearColor];
    [baoView addSubview:self.baoImage];
    
    self.baoSelectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.baoSelectBtn.frame = CGRectMake(0, 0, kScreenW - 20, 44);
    self.baoSelectBtn.selected = YES;
    self.baoSelectBtn.userInteractionEnabled = NO;
    [self.baoSelectBtn addTarget:self action:@selector(selectClick:) forControlEvents:UIControlEventTouchUpInside];
    [baoView addSubview:self.baoSelectBtn];
    
    UIView *weiView = [[UIView alloc] init];
    weiView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:weiView];
    weiView.frame = CGRectMake(10, CGRectGetMaxY(baoView.frame) + 20, kScreenW - 20, 44);
    
    UIImageView *image2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo-weixin"]];
    image2.frame = CGRectMake(10, 7, 30, 30);
    [weiView addSubview:image2];
    
    UILabel *lab3 = [weiView addLabelWithText:@"微信支付"];
    lab3.frame = CGRectMake(CGRectGetMaxX(image.frame) + 10, 7, 70, 30);
    
    self.weiImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"agree"]];
    self.weiImage.frame = CGRectMake(weiView.frame.size.width - 30, 14, 15, 15);
    self.weiImage.backgroundColor = [UIColor clearColor];
    [weiView addSubview:self.weiImage];
    
    self.weiSelectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.weiSelectBtn.frame = CGRectMake(0, 0, kScreenW - 20, 44);
    self.weiSelectBtn.selected = NO;
    [self.weiSelectBtn addTarget:self action:@selector(selectClick:) forControlEvents:UIControlEventTouchUpInside];
    [weiView addSubview:self.weiSelectBtn];
    
    self.payForBtn = [self.view addButtonFilletWithTitle:@"去付款" target:self action:@selector(payforClick)];
    self.payForBtn.frame = CGRectMake(10, CGRectGetMaxY(weiView.frame) + 20, (kScreenW - 30)/2, 44);
    
    self.goBackForBtn = [self.view addButtonFilletWithTitle:@"查看订单" target:self action:@selector(goBackClick)];
    self.goBackForBtn.frame = CGRectMake(CGRectGetMaxX(self.payForBtn.frame) + 10, CGRectGetMaxY(weiView.frame) + 20, (kScreenW - 30)/2, 44);
}

- (void)selectClick:(UIButton *)button
{
    if (self.weiSelectBtn.selected == NO) {
        
        self.weiSelectBtn.selected = YES;
        self.weiSelectBtn.userInteractionEnabled = NO;
        [self.weiImage setImage:[UIImage imageNamed:@"agreeS"]];
        
        self.baoSelectBtn.selected = NO;
        self.baoSelectBtn.userInteractionEnabled = YES;
        [self.baoImage setImage:[UIImage imageNamed:@"agree"]];

    }
    else{
        self.baoSelectBtn.selected = YES;
        self.baoSelectBtn.userInteractionEnabled = NO;
        [self.baoImage setImage:[UIImage imageNamed:@"agreeS"]];
        
        self.weiSelectBtn.selected = NO;
        self.weiSelectBtn.userInteractionEnabled = YES;
        [self.weiImage setImage:[UIImage imageNamed:@"agree"]];
    }
}

- (void)goBackClick
{
    OrderDetailsVC *vc = [OrderDetailsVC new];
    vc.orderSN = self.payNumberStr;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)popVC
{
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    TabBarController *tabBarController = [[TabBarController alloc] init];
    tabBarController.selectedIndex = 2;
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:tabBarController];
    window.rootViewController = nav;
}

#pragma mark 支付成功回调
- (void)btnClick
{
    SuccessPayForVC *vc = [[SuccessPayForVC alloc] init];
    vc.successPayIDStr = self.payNumberStr;
    vc.priceStr = self.payPriceStr;
    vc.addressStr = self.addressStr;

    if (self.baoSelectBtn.selected == YES) {
        vc.paymentMethodNameStr = @"支付宝";
    }
    else{
        vc.paymentMethodNameStr = @"微信支付";
    }
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
