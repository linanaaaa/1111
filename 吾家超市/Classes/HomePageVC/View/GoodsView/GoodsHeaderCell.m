//
//  GoodsHeaderCell.m
//  吾家超市
//
//  Created by iMac15 on 2016/12/13.
//  Copyright © 2016年 iMac15. All rights reserved.
//

#import "GoodsHeaderCell.h"

@interface GoodsHeaderCell()
@property (nonatomic, strong) UIImageView *picImage;
@property (nonatomic, strong) UILabel *nameLab;
@property (nonatomic, strong) UILabel *fullNameLab;
@property (nonatomic, strong) UILabel *priceLab;
@property (strong, nonatomic) UIView *line;
@end

@implementation GoodsHeaderCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        self.picImage = [[UIImageView alloc] init];
        self.picImage.contentMode = UIViewContentModeScaleAspectFill;
        self.picImage.backgroundColor = kGlobalBackgroundColor;
        [self addSubview:self.picImage];
        
        self.nameLab = [self addLabelWithText:@""];
        self.nameLab.numberOfLines = 2;
        self.nameLab.lineBreakMode = NSLineBreakByWordWrapping;
        self.nameLab.textColor = [UIColor blackColor];
        
        self.fullNameLab = [self addLabelWithText:@""];
        self.fullNameLab.lineBreakMode = NSLineBreakByClipping;
        
        self.priceLab = [self addLabelWithText:@"100"];
        self.priceLab.textColor = kGlobalRedColor;

        self.line = [UIView line];
        [self addSubview:self.line];
    }
    return self;
}

- (void)setFrameModel:(GoodsFrameModel *)frameModel
{
    _frameModel = frameModel;
    
    self.picImage.frame = frameModel.picImageF;
    self.nameLab.frame = frameModel.nameF;
    self.fullNameLab.frame = frameModel.fullNameF;
    self.priceLab.frame = frameModel.priceF;
    self.line.frame = CGRectMake(10, CGRectGetMaxY(self.picImage.frame) + 9, kScreenW - 10, kSplitLineHeight);
    
    self.nameLab.text = frameModel.dataModel.name;
    self.fullNameLab.text = frameModel.dataModel.keyword;
    self.priceLab.text = [NSString stringWithFormat:@"¥ %@", frameModel.dataModel.price];
    
    if ([frameModel.dataModel.image containsString:@"https:"]) {
        [self.picImage sd_setImageWithURL:[NSURL URLWithString:frameModel.dataModel.image] placeholderImage:[UIImage imageNamed:@"shangpin_bg"]];
    }
    else{
        [self.picImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kServiceN7Url,frameModel.dataModel.image]] placeholderImage:[UIImage imageNamed:@"shangpin_bg"]];
    }
}

@end
