//
//  SortsListCell.m
//  吾家超市
//
//  Created by HuaCapf on 2017/1/21.
//  Copyright © 2017年 iMac15. All rights reserved.
//

#import "SortsListCell.h"

@interface SortsListCell()
@property (strong, nonatomic) UIImageView *imageView;   //图片
@property (strong, nonatomic) UILabel *name;            //名称
@property (strong, nonatomic) UILabel *specialPrice;    //优惠价
@property (strong, nonatomic) UILabel *price;           //原价
@property (strong, nonatomic) UIButton *addCarBtn;      //加入购物车
@end

@implementation SortsListCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_imageView];
        
        _name = [self addLabelWithText:@""];
        _name.numberOfLines = 2;
        _name.lineBreakMode = NSLineBreakByCharWrapping;
        _name.textColor = [UIColor blackColor];
        
        _price = [self addLabelWithText:@"" color:[UIColor redColor]];

        _addCarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addCarBtn setImage:[UIImage imageNamed:@"gouwu"] forState:UIControlStateNormal];
//        [_addCarBtn addTarget:self action:@selector(addCarClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_addCarBtn];
    }
    return self;
}

//- (void)addCarClick
//{
//    if (self.addCarList) {
//        self.addCarList(self.sortsGoodsModel);
//    }
//}

- (void)setIsGrid:(BOOL)isGrid
{
    _isGrid = isGrid;
    
    CGFloat cellWidth = (kScreenW - 3) * 0.5;
    
    if (isGrid) {
        _imageView.frame = CGRectMake(10, 10, 80, 80);
        _name.frame = CGRectMake(CGRectGetMaxX(_imageView.frame) + 10, 10, kScreenW - 130, 40);
        _price.frame = CGRectMake(CGRectGetMaxX(_imageView.frame) + 10, CGRectGetMaxY(_name.frame) + 10, kScreenW - 160, 30);
//        _addCarBtn.frame = CGRectMake(kScreenW - 50, CGRectGetMaxY(_name.frame) + 10, 30, 30);
    }
    else{
        _imageView.frame = CGRectMake(10, 10, cellWidth - 20, cellWidth);
        _name.frame = CGRectMake(10, CGRectGetMaxY(_imageView.frame), cellWidth - 20, 40);
        _price.frame = CGRectMake(10, CGRectGetMaxY(_name.frame), cellWidth - 40, 30);
//        _addCarBtn.frame = CGRectMake(cellWidth - 40, CGRectGetMaxY(_name.frame), 30, 30);
    }
}

- (void)setSortsGoodsModel:(GoodsModel *)sortsGoodsModel
{
    _sortsGoodsModel = sortsGoodsModel;
    
    self.name.text = sortsGoodsModel.name;
    self.price.text = [NSString stringWithFormat:@"¥ %@",sortsGoodsModel.price];
    
    if ([sortsGoodsModel.image containsString:@"https:"]) {
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:sortsGoodsModel.image] placeholderImage:[UIImage imageNamed:@"shangpin_bg"]];
    }
    else{
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kServiceN7Url,sortsGoodsModel.image]] placeholderImage:[UIImage imageNamed:@"shangpin_bg"]];
    }
}

@end
