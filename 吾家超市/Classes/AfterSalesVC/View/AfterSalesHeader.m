//
//  AfterSalesHeader.m
//  吾家超市
//
//  Created by iMac15 on 2017/2/16.
//  Copyright © 2017年 iMac15. All rights reserved.
//

#import "AfterSalesHeader.h"

@interface AfterSalesHeader()
@property (strong, nonatomic) UIView *headerView;
@property (strong, nonatomic) UILabel *snLab;
@property (strong, nonatomic) UILabel *stateLab;
@end

@implementation AfterSalesHeader

+ (instancetype)afterSaleHeadeViewWithTableView:(UITableView *)tableView reuseIdentifier:(NSString *)identifier
{
    AfterSalesHeader *footerView = (AfterSalesHeader *)[tableView dequeueReusableCellWithIdentifier:identifier];
    
    if  (footerView == nil) {
        footerView = [[self alloc] initWithReuseIdentifier:identifier];
    }
    return footerView;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor whiteColor];

        _headerView = [[UIView alloc] init];
        [self.contentView addSubview:_headerView];
        
        _snLab = [_headerView addLabelWithText:@"订单号:"];
        
        _stateLab = [_headerView addLabelWithText:@"" color:[UIColor redColor]];
        _stateLab.textAlignment = NSTextAlignmentRight;
    }
    return self;
}

- (void)setDataModel:(OrderListModel *)dataModel
{
    _dataModel = dataModel;
    
    self.snLab.text = [NSString stringWithFormat:@"订单号:%@",dataModel.sn];
    self.stateLab.text = dataModel.orderStatusShow;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.headerView.frame = self.bounds;
    self.snLab.frame = CGRectMake(10, 0, kScreenW - 170, 44);
    self.stateLab.frame = CGRectMake(kScreenW - 160, 0, 150, 44);
    [self.headerView addTopSplitLine];
    [self.headerView addBottomSplitLine];
}
@end
