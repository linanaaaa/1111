//
//  OrderListFooter.m
//  吾家超市
//
//  Created by iMac15 on 2016/11/24.
//  Copyright © 2016年 iMac15. All rights reserved.
//

#import "OrderListFooter.h"

@interface OrderListFooter ()
@property (strong, nonatomic) UIView *footerView;
@property (strong, nonatomic) UILabel *footLab;
@property (strong, nonatomic) UIButton *removeBtn;
@property (strong, nonatomic) UIButton *payForBtn;
@end

@implementation OrderListFooter

+ (instancetype)orderFooterViewWithTableView:(UITableView *)tableView reuseIdentifier:(NSString *)identifier
{
    OrderListFooter *footerView = (OrderListFooter *)[tableView dequeueReusableCellWithIdentifier:identifier];
    
    if  (footerView == nil) {
        
        footerView = [[self alloc] initWithReuseIdentifier:identifier];
        }
    
    return footerView;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        _footerView = [[UIView alloc] init];
        [self.contentView addSubview:_footerView];
        
        _footLab = [_footerView addLabelWithText:@"" color:nil];
        _footLab.frame = CGRectMake(10, 0, kScreenW - 150, 44);
        
        _removeBtn = [_footerView addButtonLineWithTitle:@"取消订单" target:self action:@selector(removerClick)];
        _removeBtn.frame = CGRectMake(kScreenW - 70, 7, 60, 30);
        _removeBtn.hidden = YES;
        
        _payForBtn = [_footerView addButtonLineWithTitle:@"去付款" target:self action:@selector(payForClick)];
        _payForBtn.frame = CGRectMake(kScreenW - 130, 7, 60, 30);
        _payForBtn.hidden = YES;
    }
    return self;
}

- (void)setDataModel:(OrderListModel *)dataModel
{
    _dataModel = dataModel;
    
    /*
     *  去付款
    
     [#if !order.expired && (order.orderStatus == "unconfirmed" || order.orderStatus == "confirmed") && (order.paymentStatus == "unpaid" || order.paymentStatus == "partialPayment")]
     去支付
     
     [#if (!order.expired && order.shippingStatus == "unshipped"&&order.orderStatus!="cancelled" &&  order.paymentStatus!="refunded" && order.paymentStatus!="partialRefunds") || (order.shippingStatus == "unshipped"&&order.orderStatus!="cancelled" && order.paymentStatus =="partialPayment" )]
     取消订单
     
     */
    
//    /**
//     * 等待付款
//     */
//    pendingPayment,
//    
//    /**
//     * 等待审核
//     */
//    pendingReview,
//    
//    /**
//     * 等待发货
//     */
//    pendingShipment,
//    
//    /**
//     * 已发货
//     */
//    shipped,
//    
//    /**
//     * 已收货
//     */
//    received,
//    
//    /**
//     * 已完成
//     */
//    completed,
//    
//    /**
//     * 已失败
//     */
//    failed,
//    
//    /**
//     * 已取消
//     */
//    canceled,
//    
//    /**
//     * 已拒绝
//     */
//    denied
    
    if ([dataModel.status isEqualToString:@"pendingPayment"])
    {
        if (![dataModel.hasExpired isEqualToString:@"1"]) {
            self.payForBtn.hidden = NO;
        }
    }
    
    if ([dataModel.status isEqualToString:@"pendingPayment"]
         || [dataModel.status isEqualToString:@"pendingReview"]
         )
    {
        if (![dataModel.hasExpired isEqualToString:@"1"]) {
            self.removeBtn.hidden = NO;
        }
    }
    
    self.footLab.text = [NSString stringWithFormat:@"合计:¥%@",dataModel.amount];
}

#pragma mark -取消订单
- (void)removerClick
{
    WJLog(@"取消订单");
    if (self.removeOrder) {
        self.removeOrder(self.dataModel);
    }
}

#pragma mark -去付款
- (void)payForClick
{
    if (self.payforOrder) {
        self.payforOrder(self.dataModel);
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.footerView.frame = self.bounds;
    
    self.footLab.frame = CGRectMake(10, 0, kScreenW - 150, 44);
    self.removeBtn.frame = CGRectMake(kScreenW - 70, 7, 60, 30);
    self.payForBtn.frame = CGRectMake(kScreenW - 140, 7, 60, 30);
    
    [self addTopSplitLine];
    [self addBottomSplitLine];
}

@end
