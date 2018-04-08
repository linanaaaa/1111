//
//  AddressGoodsCell.m
//  吾家网
//
//  Created by iMac15 on 2017/6/15.
//  Copyright © 2017年 iMac15. All rights reserved.
//

#import "AddressGoodsCell.h"

@interface AddressGoodsCell()
@property (weak, nonatomic) UIImageView *image;
@property (weak, nonatomic) UILabel *address;
@end

@implementation AddressGoodsCell

+ (instancetype)addressGoodsCellWithTableView:(UITableView *)tableView
{
    static NSString *identifier = @"AddressGoodsCell";
    AddressGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[AddressGoodsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.image = [self addImageViewWithImage:@" "];
        self.image.backgroundColor = kRandomColor;
        
        self.address = [self addLabelWithText:@""];
        [self.address setNumberOfLines:2];
    }
    return self;
}

- (void)setFrameModel:(AddressGoodsFrame *)frameModel
{
    _frameModel = frameModel;
    
    self.image.frame = frameModel.imageFrame;
    self.address.frame = frameModel.addressFrame;
    
    self.address.text = [NSString stringWithFormat:@"%@%@",frameModel.dataModel.areaName, frameModel.dataModel.address];
}

@end
