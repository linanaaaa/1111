//
//  OrderAddressCell.m
//  吾家超市
//
//  Created by iMac15 on 2016/11/18.
//  Copyright © 2016年 iMac15. All rights reserved.
//

#import "OrderAddressCell.h"

@interface OrderAddressCell()
@property (strong, nonatomic) UILabel *name;
@property (strong, nonatomic) UILabel *phone;
@property (strong, nonatomic) UILabel *address;
@end

@implementation OrderAddressCell

+ (instancetype)OrderAddressCellWithTableView:(UITableView *)tableView
{
    NSString *indentifier = @"OrderAddressCell";
    OrderAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (cell == nil) {
        cell = [[OrderAddressCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];

        self.name = [self addLabelWithText:@""];
        
        self.phone = [self addLabelWithText:@""];
        
        self.address = [self addLabelWithText:@""];
        self.address.numberOfLines = 2;

        self.topLine = [UIView line];
        [self addSubview:self.topLine];
        
        [self addSubview:self.titleLab];
    }
    return self;
}

- (UILabel *)titleLab
{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.text = @"";
        _titleLab.textColor = [UIColor redColor];
        _titleLab.textAlignment = NSTextAlignmentCenter;
        _titleLab.frame = CGRectMake(0, 10, kScreenW, 30);
    }
    return _titleLab;
}

- (void)setFrameModel:(OrderAddressFrame *)frameModel
{
    _frameModel = frameModel;
    
    if (kStringIsEmpty(frameModel.dataModel.address)) {
        self.titleLab.text = @"添加收货地址";
        self.titleLab.hidden = NO;
    }
    else{
        self.titleLab.hidden = YES;
        
        self.topLine.frame = CGRectMake(0, 0, kScreenW, kSplitLineHeight);
        
        self.name.frame = frameModel.nameF;
        self.phone.frame = frameModel.phoneF;
        self.address.frame = frameModel.addressF;
        
        self.name.text = [NSString stringWithFormat:@"收货人: %@",frameModel.dataModel.consignee];
        self.phone.text = [NSString stringWithFormat:@"联系方式: %@",frameModel.dataModel.phone];
        self.address.text = [NSString stringWithFormat:@"收货地址: %@%@",frameModel.dataModel.areaName,frameModel.dataModel.address];
    }
}

@end
