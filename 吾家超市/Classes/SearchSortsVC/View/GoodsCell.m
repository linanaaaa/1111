//
//  GoodsCell.m
//  吾家超市
//
//  Created by iMac15 on 2016/11/8.
//  Copyright © 2016年 iMac15. All rights reserved.
//

#import "GoodsCell.h"

@interface GoodsCell()
@property (nonatomic, strong) UIImageView *picImage;
@property (nonatomic, strong) UILabel *nameLab;
@property (nonatomic, strong) UILabel *fullNameLab;
@property (nonatomic, strong) UILabel *priceLab;
@property (nonatomic, strong) UIView *line;
@end

@implementation GoodsCell

+ (instancetype)goodsCellWithTableView:(UITableView *)tableView
{
    NSString *indentifier = @"GoodsCell";
    
    GoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (cell == nil) {
        cell = [[GoodsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
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
        self.nameLab.textColor = [UIColor blackColor];
        
        self.fullNameLab = [self addLabelWithText:@""];
        self.fullNameLab.lineBreakMode = UIViewContentModeScaleAspectFill;
        
        self.priceLab = [self addLabelWithText:@""];
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
    self.line.frame = CGRectMake(0, CGRectGetMaxY(self.picImage.frame)+10, kScreenW, kSplitLineHeight);
    
//    NSString *imageUrl = [frameModel.dataModel.image stringByAddingPercentEncodingWithAllowedCharacters:NSUTF8StringEncoding];
//    [self.picImage sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"noImg"]];
    self.nameLab.text = frameModel.dataModel.name;
    self.fullNameLab.text = frameModel.dataModel.keyword;
    self.priceLab.text = [NSString stringWithFormat:@"¥ %@",frameModel.dataModel.price];
}

@end
