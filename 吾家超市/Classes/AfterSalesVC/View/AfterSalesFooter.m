//
//  AfterSalesFooter.m
//  吾家超市
//
//  Created by iMac15 on 2017/2/16.
//  Copyright © 2017年 iMac15. All rights reserved.
//

#import "AfterSalesFooter.h"

@interface AfterSalesFooter()
@property (strong, nonatomic) UIView *footerView;
@property (strong, nonatomic) UILabel *footLab;
@property (strong, nonatomic) UIButton *removeBtn;
@end

@implementation AfterSalesFooter

+ (instancetype)afterSaleFooterViewWithTableView:(UITableView *)tableView reuseIdentifier:(NSString *)identifier
{
    AfterSalesFooter *footerView = (AfterSalesFooter *)[tableView dequeueReusableCellWithIdentifier:identifier];
    
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
        
        _footLab = [_footerView addLabelWithText:@"合计" color:nil];
        _footLab.frame = CGRectMake(10, 0, kScreenW - 150, 44);
        
        _removeBtn = [_footerView addButtonLineWithTitle:@"取消订单" target:self action:@selector(removerClick)];
        _removeBtn.frame = CGRectMake(kScreenW - 70, 7, 60, 30);
        _removeBtn.hidden = YES;
    }
    return self;
}

- (void)setDataModel:(OrderListModel *)dataModel
{
    _dataModel = dataModel;
    
    self.footLab.text = [NSString stringWithFormat:@"数量:1,合计:¥%@",dataModel.price];
}

#pragma mark -编辑售后订单
- (void)removerClick
{
    WJLog(@"编辑售后订单");
    if (self.editAfterSales) {
        self.editAfterSales(self.dataModel);
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.footerView.frame = self.bounds;
    
    self.footLab.frame = CGRectMake(10, 0, kScreenW - 150, 44);
    self.removeBtn.frame = CGRectMake(kScreenW - 70, 7, 60, 30);
    
    [self addTopSplitLine];
    [self addBottomSplitLine];
}
@end
