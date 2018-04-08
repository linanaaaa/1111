//
//  OrderDetailFooterCell.m
//  吾家超市
//
//  Created by iMac15 on 2017/2/9.
//  Copyright © 2017年 iMac15. All rights reserved.
//

#import "OrderDetailFooterCell.h"

@interface OrderDetailFooterCell()
@property (strong, nonatomic) UILabel *amount;
@property (strong, nonatomic) UILabel *couponDiscount;
@property (strong, nonatomic) UILabel *point;
@property (strong, nonatomic) UILabel *freight;
@end

@implementation OrderDetailFooterCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        
        self.amount = [self addLabelWithText:@"" color:nil];
        
        self.couponDiscount = [self addLabelWithText:@"" color:nil];;
        
//        self.point = [self addLabelWithText:@"" color:nil];
        
        self.freight = [self addLabelWithText:@"" color:nil];
    }
    return self;
}

- (void)setFooterDetailModel:(OrderListModel *)footerDetailModel
{
    _footerDetailModel = footerDetailModel;
    
    if (!kObjectIsEmpty(_footerDetailModel)) {
        self.amount.text = [NSString stringWithFormat:@"实付款: ¥%.2f",_footerDetailModel.amount.floatValue];
        self.couponDiscount.text = [NSString stringWithFormat:@"已优惠: -¥%@",_footerDetailModel.couponDiscount];
        //    self.point.text = [NSString stringWithFormat:@"消费返利: ¥%@",_footerDetailModel.point];
        self.freight.text = [NSString stringWithFormat:@"运  费: ¥%@",_footerDetailModel.freight];
    }   
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.amount.frame = CGRectMake(10, 10, kScreenW - 20, 30);
    self.couponDiscount.frame = CGRectMake(10, CGRectGetMaxY(self.amount.frame), kScreenW - 20, 30);
//    self.point.frame = CGRectMake(10, CGRectGetMaxY(self.couponDiscount.frame), kScreenW - 20, 30);
    self.freight.frame = CGRectMake(10, CGRectGetMaxY(self.couponDiscount.frame), kScreenW - 20, 30);
}

@end
