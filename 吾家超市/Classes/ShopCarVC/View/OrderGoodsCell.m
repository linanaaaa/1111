//
//  OrderGoodsCell.m
//  吾家超市
//
//  Created by iMac15 on 2016/11/21.
//  Copyright © 2016年 iMac15. All rights reserved.
//

#import "OrderGoodsCell.h"

@interface OrderGoodsCell()
@property (strong, nonatomic) UIImageView *piceImage;
@property (strong, nonatomic) UILabel *name;
@property (strong, nonatomic) UILabel *price;
@property (strong, nonatomic) UILabel *number;
@property (strong, nonatomic) UIView *topLine;
@property (strong, nonatomic) UIView *bottomLine;
@end

@implementation OrderGoodsCell

+ (instancetype)OrderGoodsCellWithTableView:(UITableView *)tableView
{
    NSString *indentifier = @"OrderGoodsCell";
    OrderGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (cell == nil) {
        cell = [[OrderGoodsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
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
        
        self.price = [self addLabelWithText:@""];
        
        self.number = [self addLabelWithText:@""];
        
    }
    return self;
}

- (void)setGoodsFrame:(OrderGoodsFrame *)goodsFrame
{
    _goodsFrame = goodsFrame;
    
    self.piceImage.frame = goodsFrame.imageViewF;
    self.name.frame = goodsFrame.nameF;
    self.price.frame = goodsFrame.priceF;
    self.number.frame = goodsFrame.numberF;
    
    self.name.text = goodsFrame.goodsModel.name;
    self.price.text = [NSString stringWithFormat:@"¥ %@",goodsFrame.goodsModel.price];
    self.number.text = [NSString stringWithFormat:@"x%@",goodsFrame.goodsModel.quantity];
    
    if ([goodsFrame.goodsModel.thumbnail containsString:@"https:"]) {
        [self.piceImage sd_setImageWithURL:[NSURL URLWithString:goodsFrame.goodsModel.thumbnail] placeholderImage:[UIImage imageNamed:@"shangpin_bg"]];
    }
    else{
        [self.piceImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kServiceN7Url,goodsFrame.goodsModel.thumbnail]] placeholderImage:[UIImage imageNamed:@"shangpin_bg"]];
    }
}

@end
