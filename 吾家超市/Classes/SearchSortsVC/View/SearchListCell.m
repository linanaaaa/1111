//
//  SearchListCell.m
//  吾家超市
//
//  Created by iMac15 on 2016/11/11.
//  Copyright © 2016年 iMac15. All rights reserved.
//

#import "SearchListCell.h"

@interface SearchListCell()
@property (strong, nonatomic) UIImageView *imageView;   //图片
@property (strong, nonatomic) UILabel *name;            //名称
@property (strong, nonatomic) UILabel *specialPrice;    //优惠价
@property (strong, nonatomic) UILabel *price;           //原价
@property (strong, nonatomic) UIButton *addCarBtn;      //加入购物车
@end

@implementation SearchListCell

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
        [_addCarBtn addTarget:self action:@selector(addCarClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_addCarBtn];
        _addCarBtn.hidden = YES;    //隐藏 加入购物车按钮
    }
    return self;
}

- (void)addCarClick
{
    if (self.addCarList) {
        self.addCarList(self.frameModel.dataModel);
    }
}

- (void)setFrameModel:(SearchListFrame *)frameModel
{
    _frameModel = frameModel;
    
    self.name.frame = frameModel.nameF;
    self.imageView.frame = frameModel.imageF;
    self.price.frame = frameModel.priceF;
    self.addCarBtn.frame = frameModel.addCarBtnF;
    
    self.name.text = frameModel.dataModel.name;
    self.price.text = [NSString stringWithFormat:@"¥ %@",frameModel.dataModel.price];
    
    
    if ([frameModel.dataModel.image containsString:@"https:"]) {
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:frameModel.dataModel.image] placeholderImage:[UIImage imageNamed:@"shangpin_bg"]];
    }
    else{
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kServiceN7Url,frameModel.dataModel.image]] placeholderImage:[UIImage imageNamed:@"shangpin_bg"]];
    }
}

@end
