//
//  FavoriteCell.m
//  吾家超市
//
//  Created by iMac15 on 2016/12/9.
//  Copyright © 2016年 iMac15. All rights reserved.
//

#import "FavoriteCell.h"

@interface FavoriteCell()
@property (nonatomic, strong) UIImageView *picImage;
@property (nonatomic, strong) UILabel *nameLab;
@property (nonatomic, strong) UIButton *isFavorBtn;
@property (nonatomic, strong) UILabel *priceLab;
@property (nonatomic, strong) UIView *line;
@end

@implementation FavoriteCell

+ (instancetype)favoriteCellWithTableView:(UITableView *)tableView{
    
    NSString *indentifier = @"FavoriteCell";
    
    FavoriteCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (cell == nil) {
        cell = [[FavoriteCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.picImage = [[UIImageView alloc] init];
        self.picImage.contentMode = UIViewContentModeScaleAspectFill;
        self.picImage.backgroundColor = kRandomColor;
        [self addSubview:self.picImage];
        
        self.nameLab = [self addLabelWithText:@""];
        self.nameLab.numberOfLines = 2;
        self.nameLab.lineBreakMode = NSLineBreakByWordWrapping;
        
        self.priceLab = [self addLabelWithText:@""];
        self.priceLab.textColor = kGlobalRedColor;
        
        self.isFavorBtn = [self addButtonLeftWithImage:@"cleaniconH" rightWithTitle:@"取消收藏" target:self action:@selector(isFavorBtnClick)];
        
        self.line = [UIView line];
        [self addSubview:self.line];
    }
    return self;
}

- (void)setFrameModel:(FavoriteFrameModel *)frameModel
{
    _frameModel = frameModel;
    
    self.picImage.frame = frameModel.picImageF;
    self.nameLab.frame = frameModel.nameF;
    self.priceLab.frame = frameModel.priceF;
    self.isFavorBtn.frame = frameModel.isFavorBtnF;
    
    self.line.frame = CGRectMake(0, CGRectGetMaxY(self.picImage.frame)+10, kScreenW, kSplitLineHeight);
    
    self.nameLab.text = frameModel.dataModel.productName;
    self.priceLab.text = [NSString stringWithFormat:@"¥ %@",frameModel.dataModel.productPrice];
    
    if ([frameModel.dataModel.productImage containsString:@"https:"]) {
        [self.picImage sd_setImageWithURL:[NSURL URLWithString:frameModel.dataModel.productImage] placeholderImage:[UIImage imageNamed:@"shangpin_bg"]];
    }
    else{
        [self.picImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kServiceN7Url,frameModel.dataModel.productImage]] placeholderImage:[UIImage imageNamed:@"shangpin_bg"]];
    }
}

- (void)isFavorBtnClick
{    
    if (self.cleanFav) {
        self.cleanFav(self.frameModel.dataModel);
    }
}

@end
