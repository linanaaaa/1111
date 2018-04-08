//
//  SaleDetailVC.m
//  吾家超市
//
//  Created by iMac15 on 2017/2/16.
//  Copyright © 2017年 iMac15. All rights reserved.
//

#import "SaleDetailVC.h"
#import "AfterSalesModel.h"

@interface SaleDetailVC ()
@property (strong, nonatomic) UILabel *orderId;
@property (strong, nonatomic) UILabel *staus;
@property (strong, nonatomic) UILabel *memo;
@property (strong, nonatomic) UILabel *goodsname;
@property (strong, nonatomic) UILabel *number;
@property (strong, nonatomic) UILabel *addressName;
@property (strong, nonatomic) UILabel *address;
@end

@implementation SaleDetailVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadData];
}

#pragma mark -加载退换货详情
- (void)loadData
{
    NSDictionary *param = @{@"id":self.salesDetailId};
    
    kWeakSelf
    
    [WJRequestTool get:kSalesDetailsUrl param:param resultClass:[AfterSalesResult class] successBlock:^(AfterSalesResult *result)
     {         
         NSString *stausStr;
         
         if ([result.t.status isEqualToString:@"processing"]) {
             stausStr = @"处理中";
         }
         else if ([result.t.status isEqualToString:@"processed"]){
             stausStr = @"处理完";
         }
         else if ([result.t.status isEqualToString:@"reject"]){
             stausStr = @"驳回";
         }
         
         NSString *typeStr;
         
         if ([result.t.type isEqualToString:@"replacement"]) {
             typeStr = @"换货";
         }
         else if ([result.t.type isEqualToString:@"returns"]){
             typeStr = @"退货";
         }
         weakSelf.orderId.text = [NSString stringWithFormat:@"订单号: %@", result.t.orderSn];
         weakSelf.staus.text = stausStr;
         weakSelf.memo.text = [NSString stringWithFormat:@"%@原因: %@", typeStr, result.t.memo];
         weakSelf.goodsname.text = [NSString stringWithFormat:@"商品名称: %@", result.t.productName];
         weakSelf.number.text = [NSString stringWithFormat:@"数量: x%@", result.t.quantity];
         weakSelf.addressName.text = [NSString stringWithFormat:@"收货人姓名: %@", result.t.consignee];
         weakSelf.address.text = [NSString stringWithFormat:@"收货人地址: %@", result.t.address];
         
         NSString *goodsnameStr = [NSString stringWithFormat:@"商品名称: %@", result.t.productName];
         CGSize goodsnameSize = kTextSize(goodsnameStr, kTextFont, CGSizeMake(kScreenW - 20, MAXFLOAT));
         weakSelf.goodsname.frame = CGRectMake(10, CGRectGetMaxY(self.memo.frame), kScreenW - 20, goodsnameSize.height);
         
         NSString *addressStr = [NSString stringWithFormat:@"收货人地址: %@", result.t.address];
         CGSize addressSize = kTextSize(addressStr, kTextFont, CGSizeMake(kScreenW - 20, MAXFLOAT));
         weakSelf.address.frame = CGRectMake(10, CGRectGetMaxY(self.addressName.frame), kScreenW - 20, addressSize.height);
         
     } failure:^(NSError *error) {
         
     }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"售后详情";
    [self.view addTopSplitLine];
    
    self.orderId = [self.container addLabelWithText:@""];
    self.orderId.frame = CGRectMake(10, 10, kScreenW - 150, 30);
    
    self.staus = [self.container addLabelWithText:@""];
    self.staus.frame = CGRectMake(kScreenW - 100, 10, 90, 30);
    self.staus.textColor = kGlobalRedColor;
    self.staus.textAlignment = NSTextAlignmentRight;
    
    self.memo = [self.container addLabelWithText:@""];
    self.memo.frame = CGRectMake(10, CGRectGetMaxY(self.orderId.frame), kScreenW - 20, 30);
    
    self.goodsname = [self.container addLabelWithText:@""];
    self.goodsname.frame = CGRectMake(10, CGRectGetMaxY(self.memo.frame), kScreenW - 20, 30);
    self.goodsname.numberOfLines = 2;
    
    self.number = [self.container addLabelWithText:@""];
    self.number.frame = CGRectMake(10, CGRectGetMaxY(self.goodsname.frame), kScreenW - 20, 30);
    
    self.addressName = [self.container addLabelWithText:@""];
    self.addressName.frame = CGRectMake(10, CGRectGetMaxY(self.number.frame), kScreenW - 20, 30);
    
    self.address = [self.container addLabelWithText:@""];
    self.address.frame = CGRectMake(10, CGRectGetMaxY(self.addressName.frame), kScreenW - 20, 30);
    self.address.numberOfLines = 2;
}

@end

