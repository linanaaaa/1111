//
//  OrderDetailsGoodsCell.m
//  吾家超市
//
//  Created by iMac15 on 2017/2/15.
//  Copyright © 2017年 iMac15. All rights reserved.
//

#import "OrderDetailsGoodsCell.h"

@interface OrderDetailsGoodsCell()
@property (strong, nonatomic) UIImageView *piceImage;
@property (strong, nonatomic) UILabel *name;
@property (strong, nonatomic) UILabel *price;
@property (strong, nonatomic) UIButton *trackBtn;
@property (strong, nonatomic) UIButton *salesBtn;
@property (strong, nonatomic) UIView *topLine;
@property (strong, nonatomic) UIView *bottomLine;
@property (assign, nonatomic) CGFloat nameH;
@property (strong, nonatomic) NSString *returnGoodsEnable;
@property (strong, nonatomic) NSString *typeStr;
@end

@implementation OrderDetailsGoodsCell

+ (instancetype)OrderDetailsGoodsCellWithTableView:(UITableView *)tableView
{
    NSString *indentifier = @"OrderDetailsGoodsCell";
    OrderDetailsGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (cell == nil) {
        cell = [[OrderDetailsGoodsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        
        self.piceImage = [self addImageViewWithImage:@""];
        self.piceImage.backgroundColor = kGrayBackgroundColor;
        
        self.name = [self addLabelWithText:@""];
        self.name.numberOfLines = 2;
        
        self.price = [self addLabelWithText:@"" color:nil];
        
//        self.trackBtn = [self addButtonLineWithTitle:@"查看物流" target:self action:@selector(trackBtnClick)];
//        self.trackBtn.hidden = YES;
        
        self.salesBtn = [self addButtonLineWithTitle:@"退换货" target:self action:@selector(saleBtnClick)];
        self.salesBtn.hidden = YES;
    }
    return self;
}

#pragma mark -退换货
- (void)saleBtnClick
{
    if (self.orderSaleBtn) {
        self.orderSaleBtn(self.orderItemModel,self.typeStr);
    }
}

#pragma mark -查看物流
- (void)trackBtnClick
{
    if (self.orderTrackBtn) {
        self.orderTrackBtn(self.orderItemModel);
    }
}

- (void)setOrderItemModel:(OrderItems *)orderItemModel
{
    _orderItemModel = orderItemModel;
    
    self.name.text = orderItemModel.name;
    self.price.text = [NSString stringWithFormat:@"价格:¥%@  数量:%@",orderItemModel.price,orderItemModel.quantity];
    [self.piceImage sd_setImageWithURL:[NSURL URLWithString:orderItemModel.thumbnail] placeholderImage:[UIImage imageNamed:@"shangpin_bg"]];
    
    if ([orderItemModel.thumbnail containsString:@"https:"]) {
        [self.piceImage sd_setImageWithURL:[NSURL URLWithString:orderItemModel.thumbnail] placeholderImage:[UIImage imageNamed:@"shangpin_bg"]];
    }
    else{
        [self.piceImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kServiceN7Url,orderItemModel.thumbnail]] placeholderImage:[UIImage imageNamed:@"shangpin_bg"]];
    }
    
    CGFloat nameW = kScreenW - 90;
    self.nameH = kTextHeight(orderItemModel.name, kTextFont, nameW);
    
    self.returnGoodsEnable = orderItemModel.returnGoodsEnable;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
//    if (kStringIsEmpty(self.shippingStatus)) {
//        self.trackBtn.hidden = YES;
//    }
//    else{
//        self.trackBtn.hidden = NO;
//    }
    
    if ([self.returnGoodsEnable isEqualToString:@"save"]) {
        self.salesBtn.hidden = NO;
        [self.salesBtn setTitle:@"退换货" forState:UIControlStateNormal];
        self.typeStr = @"退换货";
    }
    else if ([self.returnGoodsEnable isEqualToString:@"view"]) {
        self.salesBtn.hidden = NO;
        [self.salesBtn setTitle:@"查看售后" forState:UIControlStateNormal];
        self.typeStr = @"查看售后";
    }
    else{
        self.salesBtn.hidden = YES;
        self.typeStr = @"";
    }
    
    self.piceImage.frame = CGRectMake(10, 10, 60, 60);
    self.name.frame = CGRectMake(CGRectGetMaxX(self.piceImage.frame) + 10, 10, kScreenW - 110, self.nameH);
    self.price.frame = CGRectMake(CGRectGetMaxX(self.piceImage.frame) + 10, 50, kScreenW - 230, 20);
    self.salesBtn.frame = CGRectMake(kScreenW - 70, 50, 60, 20);

//    self.trackBtn.frame = CGRectMake(kScreenW - 75, 50, 65, 20);
//    
//    if (self.trackBtn.hidden == YES) {
//        self.salesBtn.frame = CGRectMake(kScreenW - 70, 50, 60, 20);
//    }
//    else{
//        self.salesBtn.frame = CGRectMake(kScreenW - 145, 50, 60, 20);
//    }    
}

@end
