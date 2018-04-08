//
//  OrderDetailHeadCell.m
//  吾家超市
//
//  Created by iMac15 on 2017/2/9.
//  Copyright © 2017年 iMac15. All rights reserved.
//

#import "OrderDetailHeadCell.h"

@interface OrderDetailHeadCell()
@property (strong, nonatomic) UILabel *type;
@property (strong, nonatomic) UILabel *time;
@property (strong, nonatomic) UILabel *sn;
@end

@implementation OrderDetailHeadCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        
        self.type = [self addLabelWithText:@"" color:kGlobalRedColor];
        
        self.time = [self addLabelWithText:@"" color:kGlobalTextColor];;
        
        self.sn = [self addLabelWithText:@"" color:kGlobalTextColor];
    }
    return self;
}

- (void)setHeaderDetailModel:(OrderListModel *)headerDetailModel
{
    _headerDetailModel = headerDetailModel;
    if (!kObjectIsEmpty(_headerDetailModel)) {
        self.type.text = _headerDetailModel.orderStatusShow;
        self.time.text = [NSString stringWithFormat:@"下单时间: %@",[_headerDetailModel.createDate getDateTimeString]];
        self.sn.text = [NSString stringWithFormat:@"订单编号: %@",_headerDetailModel.sn];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.type.frame = CGRectMake(10, 10, kScreenW - 20, 40);
    self.time.frame = CGRectMake(10, CGRectGetMaxY(self.type.frame), kScreenW - 20, 30);
    self.sn.frame = CGRectMake(10, CGRectGetMaxY(self.time.frame), kScreenW - 20, 30);
}
@end
