//
//  AddressListCell.m
//  吾家超市
//
//  Created by iMac15 on 2016/11/16.
//  Copyright © 2016年 iMac15. All rights reserved.
//

#import "AddressListCell.h"

@interface AddressListCell ()

@property (weak, nonatomic) UILabel *name;
@property (weak, nonatomic) UILabel *phone;
@property (weak, nonatomic) UILabel *address;
@property (weak, nonatomic) UIButton *isdefaultBtn;
@property (weak, nonatomic) UIButton *editBtn;
@property (weak, nonatomic) UIButton *deleteBtn;
@property (strong, nonatomic) UIView *centerLine;
@end

@implementation AddressListCell

+ (instancetype)addressListCellWithTableView:(UITableView *)tableView
{
    static NSString *identifier = @"AddressListCell";
    AddressListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[AddressListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.name = [self addLabelWithText:@""];
        
        self.phone = [self addLabelWithText:@""];
        [self.phone setTextAlignment:NSTextAlignmentRight];
        
        self.address = [self addLabelWithText:@""];
        [self.address setNumberOfLines:2];
        
        self.centerLine = [UIView line];
    
        [self addSubview:self.centerLine];
      
        self.isdefaultBtn = [self addButtonLeftWithImage:@"agree" rightWithTitle:@"默认地址" target:self action:@selector(isdefaultBtnDidClick)];
        self.isdefaultBtn.hidden = YES;

        self.editBtn = [self addButtonLeftWithImage:@"editBtn" rightWithTitle:@"编辑" target:self action:@selector(editBtnClick)];

        self.deleteBtn = [self addButtonLeftWithImage:@"clean" rightWithTitle:@"删除" target:self action:@selector(deleteBtnClick)];
    }
    return self;
}

- (void)setFrameModel:(AddressListCellFrameModel *)frameModel
{
    _frameModel = frameModel;
    
    self.name.frame = frameModel.nameFrame;
    self.phone.frame = frameModel.phoneFrame;
    self.address.frame = frameModel.addressFrame;
    self.centerLine.frame = frameModel.centerLineFrame;
    
    self.isdefaultBtn.frame = frameModel.isDefaultBtnFrame;
    self.deleteBtn.frame = frameModel.delegetBtnFrame;
    self.editBtn.frame = frameModel.editBtnFrame;
    
    self.name.text = frameModel.dataModel.consignee;
    self.address.text = [NSString stringWithFormat:@"%@%@",frameModel.dataModel.areaName, frameModel.dataModel.address];
    
    // 手机号中间 4位 ****
    NSString *mobilePhone = frameModel.dataModel.phone;
    
    if (frameModel.dataModel.phone.length > 13) {
        NSMutableString *phoneStr = [[NSMutableString alloc]initWithString:mobilePhone];
        [phoneStr replaceCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
        self.phone.text = phoneStr;
    }
    else{
        self.phone.text = mobilePhone;
    }
    
    if (frameModel.dataModel.isDefault) {    // 是否 默认地址
        self.name.textColor = kGlobalRedColor;
        self.phone.textColor = kGlobalRedColor;
        self.address.textColor = kGlobalRedColor;
        [self.isdefaultBtn setImage:[UIImage imageNamed:@"agreeS"] forState:UIControlStateNormal];
        [self.isdefaultBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        self.isdefaultBtn.hidden = NO;
        
    }else{
        self.name.textColor = kGlobalTextColor;
        self.phone.textColor = kGlobalTextColor;
        self.address.textColor = kGlobalTextColor;
        
        self.isdefaultBtn.hidden = YES;
    }
}

#pragma mark -设为默认
- (void)isdefaultBtnDidClick
{
    if (self.defaultAddress) {
        self.defaultAddress(self.frameModel.dataModel);
    }
}

#pragma mark -删除地址
- (void)deleteBtnClick
{
    if (self.deleteAddress) {
        self.deleteAddress(self.frameModel.dataModel);
    }
}

#pragma mark -编辑地址
- (void)editBtnClick
{
    if (self.editAddress) {
        self.editAddress(self.frameModel.dataModel);
    }
}

@end
