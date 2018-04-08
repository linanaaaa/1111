//
//  OrderAddressFrame.m
//  吾家超市
//
//  Created by iMac15 on 2016/11/18.
//  Copyright © 2016年 iMac15. All rights reserved.
//

#import "OrderAddressFrame.h"

@implementation OrderAddressFrame

- (void)setDataModel:(DefaultReceiverModel *)dataModel
{
    _dataModel = dataModel;
    
    CGFloat margin = 10;
    
    NSString *nameStr = [NSString stringWithFormat:@"收货人: %@",dataModel.consignee];
    CGSize nameSize = kTextSize(nameStr, kTextFont, CGSizeMake(120, MAXFLOAT));
    
    CGFloat nameX = margin;
    CGFloat nameY = margin;
    CGFloat nameW = 120;
    CGFloat nameH = nameSize.height;
    self.nameF = CGRectMake(nameX, nameY, nameW, nameH);
    
    CGFloat phoneX = CGRectGetMaxX(self.nameF) + margin;
    
    NSString *phoneStr = [NSString stringWithFormat:@"联系方式: %@",dataModel.phone];
    CGSize phoneSize = kTextSize(phoneStr, kTextFont, CGSizeMake(kScreenW - phoneX - margin, MAXFLOAT));
    
    CGFloat phoneY = nameY;
    CGFloat phoneW = phoneSize.width;
    CGFloat phoneH = phoneSize.height;
    self.phoneF = CGRectMake(phoneX, phoneY, phoneW, phoneH);
    
    NSString *addressStr = [NSString stringWithFormat:@"收货地址: %@%@",dataModel.areaName, dataModel.address];
    CGSize addressSize = kTextSize(addressStr, kTextFont, CGSizeMake(kScreenW - 4*margin, MAXFLOAT));
    
    CGFloat addressX = margin;
    CGFloat addressY = CGRectGetMaxY(self.nameF) + margin;
    CGFloat addressW = kScreenW - 4*margin;
    CGFloat addressH = addressSize.height;
    self.addressF = CGRectMake(addressX, addressY, addressW, addressH);
    
    self.cellHeight = CGRectGetMaxY(self.addressF) + margin;
}

@end
