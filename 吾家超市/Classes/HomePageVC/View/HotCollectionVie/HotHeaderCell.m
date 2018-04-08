//
//  HotHeaderCell.m
//  吾家超市
//
//  Created by iMac15 on 2016/12/12.
//  Copyright © 2016年 iMac15. All rights reserved.
//

#import "HotHeaderCell.h"

@interface HotHeaderCell()
@property (strong, nonatomic) UILabel *title;           //名称
@property (strong, nonatomic) UILabel *fullName;        //简介
@property (strong, nonatomic) UILabel *priceName;       //价格
@property (nonatomic, strong) UIImageView *iconView;    //图片左
@property (nonatomic, strong) UIImageView *iconView2;   //图片中
@property (nonatomic, strong) UIImageView *iconView3;   //图片右
@end

@implementation HotHeaderCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        self.title = [self addLabelWithText:@""];
        [self.title setNumberOfLines:2];
        self.title.lineBreakMode = NSLineBreakByWordWrapping;
        self.title.textColor = [UIColor blackColor];
        
        self.fullName = [self addLabelWithText:@"" color:[UIColor grayColor]];
        
        self.priceName = [self addLabelWithText:@"100"];
        self.priceName.textColor = kGlobalRedColor;
        
        self.iconView = [self addImageViewWithImage:@""];
        [self.iconView setContentMode:UIViewContentModeScaleToFill];
        self.iconView.backgroundColor = kGlobalBackgroundColor;
        
        self.iconView2 = [self addImageViewWithImage:@""];
        [self.iconView2 setContentMode:UIViewContentModeScaleToFill];
        self.iconView2.backgroundColor = kGlobalBackgroundColor;
        
        self.iconView3 = [self addImageViewWithImage:@""];
        [self.iconView3 setContentMode:UIViewContentModeScaleToFill];
        self.iconView3.backgroundColor = kGlobalBackgroundColor;
    }
    return self;
}

- (void)setFrameModel:(HotFrameModel *)frameModel
{
    _frameModel = frameModel;
    
    self.title.frame = frameModel.nameF;
    self.fullName.frame = frameModel.fullNameF;
    self.priceName.frame = frameModel.priceNameF;
    self.iconView.frame = frameModel.picImageF;
    self.iconView2.frame = frameModel.pic2ImageF;
    self.iconView3.frame = frameModel.pic3ImageF;
    
    self.title.text = frameModel.dataModel.name;
    self.fullName.text = frameModel.dataModel.keyword;
    self.priceName.text = [NSString stringWithFormat:@"¥ %@",frameModel.dataModel.price];
    
//    HotGoodsProduct *hotGoodsImage = [frameModel.dataModel.productImages objectAtIndex:0];    //从图片数组读取0位置图片
//    HotGoodsProduct *hotGoodsImage2 = [frameModel.dataModel.productImages objectAtIndex:1];   //从图片数组读取1位置图片
//    HotGoodsProduct *hotGoodsImage3 = [frameModel.dataModel.productImages objectAtIndex:2];   //从图片数组读取2位置图片
    
//    [self.iconView sd_setImageWithURL:[NSURL URLWithString:hotGoodsImage.medium] placeholderImage:[UIImage imageNamed:@"shangpin_bg"]];
//
//    [self.iconView2 sd_setImageWithURL:[NSURL URLWithString:hotGoodsImage2.medium] placeholderImage:[UIImage imageNamed:@"shangpin_bg"]];
//
//    [self.iconView3 sd_setImageWithURL:[NSURL URLWithString:hotGoodsImage3.medium] placeholderImage:[UIImage imageNamed:@"shangpin_bg"]];
}

@end
