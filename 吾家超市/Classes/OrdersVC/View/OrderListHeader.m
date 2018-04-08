//
//  OrderListHeader.m
//  吾家超市
//
//  Created by iMac15 on 2016/11/24.
//  Copyright © 2016年 iMac15. All rights reserved.
//

#import "OrderListHeader.h"

@interface OrderListHeaderView : UIView
@property (strong, nonatomic) UILabel *snLab;
@property (strong, nonatomic) UILabel *stateLab;
@end

@implementation OrderListHeaderView

- (instancetype)init
{
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        
        _snLab = [self addLabelWithText:@"订单号:"];
        
        _stateLab = [self addLabelWithText:@"" color:[UIColor redColor]];
        _stateLab.textAlignment = NSTextAlignmentRight;
    }
    return self;
}
@end

@interface OrderListHeader()
@property (strong, nonatomic) OrderListHeaderView * headerView;
@end

@implementation OrderListHeader

+ (instancetype)orderHeadeViewWithTableView:(UITableView *)tableView reuseIdentifier:(NSString *)identifier
{
    OrderListHeader *headerView = (OrderListHeader *)[tableView dequeueReusableCellWithIdentifier:identifier];
    
    if  (headerView == nil) {
        headerView = [[self alloc] initWithReuseIdentifier:identifier];
    }
    return headerView;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = kGlobalBackgroundColor;
        
        _headerView = [[OrderListHeaderView alloc] init];
        [self.contentView addSubview:_headerView];
    }
    return self;
}

- (void)setDataModel:(OrderListModel *)dataModel
{
    _dataModel = dataModel;
    
    self.headerView.snLab.text = [NSString stringWithFormat:@"订单号:%@",dataModel.sn];
    self.headerView.stateLab.text = dataModel.orderStatusShow;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.headerView.frame = CGRectMake(0, 10, kScreenW, 44);
    self.headerView.snLab.frame = CGRectMake(10, 0, kScreenW - 130, 44);
    self.headerView.stateLab.frame = CGRectMake(kScreenW - 120, 0, 110, 44);
    [self.headerView addTopSplitLine];
    [self.headerView addBottomSplitLine];
}
@end
