//
//  ShopCarCell.m
//  吾家超市
//
//  Created by iMac15 on 2016/11/14.
//  Copyright © 2016年 iMac15. All rights reserved.
//

#import "ShopCarCell.h"

@interface ShopCarCell()
@property (strong, nonatomic) UILabel *name;
@property (strong, nonatomic) UILabel *price;
@property (strong, nonatomic) UIImageView *pic;
@property (strong, nonatomic) UIButton *deleghtBtn;
@property (strong, nonatomic) UIButton *selectedBtn;
@end

@implementation ShopCarCell

+ (instancetype)ShopCarCellWithTableView:(UITableView *)tableView
{
    NSString *indentifier = @"ShopCarCell";
    ShopCarCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (cell == nil) {
        cell = [[ShopCarCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        
        self.selectedBtn = [self addButtonSelectedSetImage:@"agree" selected:@"agreeS" target:self action:@selector(selectClick:)];
        
        self.pic = [self addImageViewWithImage:@""];
        self.pic.backgroundColor = kGrayBackgroundColor;
        
        self.name = [self addLabelWithText:@""];
        [self.name setNumberOfLines:2];
        [self.name setTextColor:[UIColor blackColor]];
        
        self.price = [self addLabelWithText:@"" color:kGlobalRedColor];
        
        self.deleghtBtn = [self addButtonSetImage:@"clean" highlighted:@"clean" target:self action:@selector(delghtBtnClick)];
        
        self.numberButton = [[PPNumberButton alloc] init];
        self.numberButton.shakeAnimation = YES;
        self.numberButton.editing = NO;
        self.numberButton.increaseImage = [UIImage imageNamed:@"increase_taobao"];
        self.numberButton.decreaseImage = [UIImage imageNamed:@"decrease_taobao"];
        [self addSubview:self.numberButton];
    }
    return self;
}

- (void)setFrameModel:(ShopCarCellFrame *)frameModel
{
    _frameModel = frameModel;
    
    self.pic.frame = frameModel.picF;
    self.name.frame = frameModel.nameF;
    self.price.frame = frameModel.priceF;
    self.deleghtBtn.frame = frameModel.deleghtBtnF;
    self.numberButton.frame = frameModel.numberViewF;
    self.selectedBtn.frame = frameModel.selectedBtnF;
    
    if ([frameModel.dataModel.cartItemState isEqualToString:@"checked"]) {
        self.selectedBtn.selected = YES;
    }
    else{
        self.selectedBtn.selected = NO;
    }
    
    self.numberButton.currentNumber = [frameModel.dataModel.quantity integerValue];
    self.name.text = frameModel.dataModel.product.name;
    self.price.text = [NSString stringWithFormat:@"¥ %@",frameModel.dataModel.product.price];
    
    if ([frameModel.dataModel.product.image containsString:@"https:"]) {
        [self.pic sd_setImageWithURL:[NSURL URLWithString:frameModel.dataModel.product.image] placeholderImage:[UIImage imageNamed:@"shangpin_bg"]];
    }
    else{
        [self.pic sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kServiceN7Url,frameModel.dataModel.product.image]] placeholderImage:[UIImage imageNamed:@"shangpin_bg"]];
    }
}

#pragma makr -勾选商品
- (void)selectClick:(UIButton *)sender
{
    sender.selected = !sender.selected;
    
    if (self.selectBtnClick) {
        self.selectBtnClick(self.frameModel);
    }
    
}

#pragma mark -删除单个商品
- (void)delghtBtnClick
{
    if (self.deleghtBtnClick) {
        self.deleghtBtnClick(self.frameModel);
    }
}
@end
