//
//  AfterSalesCell.m
//  吾家超市
//
//  Created by iMac15 on 2017/2/16.
//  Copyright © 2017年 iMac15. All rights reserved.
//

#import "AfterSalesCell.h"

@interface AfterSalesCell()
@property (strong, nonatomic) UILabel *orderId;
@property (strong, nonatomic) UILabel *staus;
@property (strong, nonatomic) UIView *line;
@property (strong, nonatomic) UIView *bottomLine;
@property (strong, nonatomic) UILabel *memo;
@property (strong, nonatomic) UILabel *goodsname;
@property (strong, nonatomic) UILabel *number;
@property (strong, nonatomic) NSString *goodsnameStr;
@property (strong, nonatomic) UIButton *editBtn;
@end

@implementation AfterSalesCell

+ (instancetype)AfterSalesCellWithTableView:(UITableView *)tableView
{
    NSString *indentifier = @"AfterSalesCell";
    AfterSalesCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (cell == nil) {
        cell = [[AfterSalesCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        
        self.orderId = [self addLabelWithText:@""];
        
        self.staus = [self addLabelWithText:@""];
        self.staus.textColor = kGlobalRedColor;
        self.staus.textAlignment = NSTextAlignmentRight;
        
        self.line = [UIView line];
        [self addSubview:self.line];
        
        self.bottomLine = [UIView line];
        [self addSubview:self.bottomLine];
        
        self.memo = [self addLabelWithText:@""];
        
        self.goodsname = [self addLabelWithText:@""];
        self.goodsname.numberOfLines = 2;
        
        self.number = [self addLabelWithText:@""];
        
        self.editBtn = [self addButtonLineWithTitle:@"编辑售后" target:self action:@selector(editBtnClick)];
        self.editBtn.hidden = YES;
    }
    return self;
}

- (void)editBtnClick
{
    if (self.saleEditBtn) {
        self.saleEditBtn(self.dataModel);
    }
}

- (void)setDataModel:(AfterSalesModel *)dataModel
{
    _dataModel = dataModel;
    
    NSString *stausStr;
    
    if ([dataModel.status isEqualToString:@"processing"]) {
        stausStr = @"处理中";
    }
    else if ([dataModel.status isEqualToString:@"processed"]){
        stausStr = @"处理完";
    }
    else if ([dataModel.status isEqualToString:@"reject"]){
        stausStr = @"驳回";
    }
    
    NSString *typeStr;
    
    if ([dataModel.type isEqualToString:@"replacement"]) {
        typeStr = @"换货";
    }
    else if ([dataModel.type isEqualToString:@"returns"]){
        typeStr = @"退货";
    }
    self.orderId.text = [NSString stringWithFormat:@"订单号: %@", dataModel.orderSn];
    self.staus.text = stausStr;
    self.memo.text = [NSString stringWithFormat:@"%@原因: %@", typeStr, dataModel.memo];
    self.goodsname.text = [NSString stringWithFormat:@"商品名称: %@", dataModel.productName];
    self.number.text = [NSString stringWithFormat:@"数量: x%@", dataModel.quantity];
    
    self.goodsnameStr = [NSString stringWithFormat:@"商品名称: %@", dataModel.productName];
    
    if (!kStringIsEmpty(dataModel.returnGoodsEditEnable)) {
        
        if ([dataModel.returnGoodsEditEnable isEqualToString:@"edit"]) {
            self.editBtn.hidden = NO;
        }
    }
    else{
        self.editBtn.hidden = YES;
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.orderId.frame = CGRectMake(10, 10, kScreenW - 150, 30);
    self.staus.frame = CGRectMake(kScreenW - 100, 10, 90, 30);
    self.line.frame = CGRectMake(10, CGRectGetMaxY(self.orderId.frame), kScreenW - 10, kSplitLineHeight);
    self.memo.frame = CGRectMake(10, CGRectGetMaxY(self.orderId.frame), kScreenW - 20, 30);
    
    CGSize goodsnameSize = kTextSize(self.goodsnameStr, kTextFont, CGSizeMake(kScreenW - 20, MAXFLOAT));
    self.goodsname.frame = CGRectMake(10, CGRectGetMaxY(self.memo.frame), kScreenW - 20, goodsnameSize.height);
    
    self.number.frame = CGRectMake(10, CGRectGetMaxY(self.goodsname.frame), kScreenW - 120, 30);
    self.editBtn.frame = CGRectMake(kScreenW - 80, CGRectGetMaxY(self.goodsname.frame) + 5, 70, 20);

    self.bottomLine.frame = CGRectMake(0, CGRectGetMaxY(self.number.frame), kScreenW, 10);
}

@end
