//
//  OrderListCell.m
//  吾家超市
//
//  Created by iMac15 on 2016/11/22.
//  Copyright © 2016年 iMac15. All rights reserved.
//

#import "OrderListCell.h"

@interface OrderListCell()
@property (strong, nonatomic) UIImageView *piceImage;
@property (strong, nonatomic) UILabel *name;
@property (strong, nonatomic) UILabel *price;
@property (strong, nonatomic) UILabel *number;
@property (strong, nonatomic) UIView *topLine;
@property (strong, nonatomic) UIView *bottomLine;
@property (assign, nonatomic) CGFloat nameH;
@end

@implementation OrderListCell

+ (instancetype)OrderListCellWithTableView:(UITableView *)tableView
{
    NSString *indentifier = @"OrderListCell";
    OrderListCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (cell == nil) {
        cell = [[OrderListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
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
        
        self.number = [self addLabelWithText:@""];
        [self.number setTextAlignment:NSTextAlignmentRight];
    }
    return self;
}

- (void)setOrderItemsModel:(OrderItems *)orderItemsModel
{
    _orderItemsModel = orderItemsModel;
    
    self.name.text = orderItemsModel.name;
    self.price.text = [NSString stringWithFormat:@"¥ %@",orderItemsModel.price];
    self.number.text = [NSString stringWithFormat:@"x%@",orderItemsModel.quantity];
    
    
    if ([orderItemsModel.image containsString:@"https:"]) {
        [self.piceImage sd_setImageWithURL:[NSURL URLWithString:orderItemsModel.thumbnail] placeholderImage:[UIImage imageNamed:@"shangpin_bg"]];
    }
    else{
        [self.piceImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kServiceN7Url,orderItemsModel.thumbnail]] placeholderImage:[UIImage imageNamed:@"shangpin_bg"]];
    }
        
    CGFloat nameW = kScreenW - 90;
    
    CGFloat nameHight;
    
    nameHight = kTextHeight(orderItemsModel.name, kTextFont, nameW);
    
    if (nameHight > 45) {
        self.nameH = 40;
    }
    else{
        self.nameH = kTextHeight(orderItemsModel.name, kTextFont, nameW);
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.piceImage.frame = CGRectMake(10, 10, 60, 60);
    self.name.frame = CGRectMake(CGRectGetMaxX(self.piceImage.frame) + 10, 10, kScreenW - 110, self.nameH);
    self.price.frame = CGRectMake(CGRectGetMaxX(self.piceImage.frame) + 10, CGRectGetMaxY(self.name.frame) + 5, kScreenW - 110, 20);
    self.number.frame = CGRectMake(kScreenW - 110, CGRectGetMaxY(self.name.frame) + 5, 100, 20);
}

@end
