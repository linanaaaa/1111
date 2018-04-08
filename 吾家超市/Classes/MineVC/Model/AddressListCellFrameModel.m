//
//  AddressListCellFrameModel.m
//  吾家超市
//
//  Created by iMac15 on 2016/11/16.
//  Copyright © 2016年 iMac15. All rights reserved.
//

#import "AddressListCellFrameModel.h"

@implementation AddressListCellFrameModel

+ (NSArray *)frameModelArrayWithDataArray:(NSArray *)dataArray
{

    NSMutableArray *frameArray = [NSMutableArray arrayWithCapacity:dataArray.count];
    for (AddressModel *dataModel in dataArray) {
        AddressListCellFrameModel *frameModel = [[AddressListCellFrameModel alloc] init];
        frameModel.dataModel = dataModel;
        [frameArray addObject:frameModel];
    }
    
    [frameArray enumerateObjectsUsingBlock:^(AddressListCellFrameModel *frameModel, NSUInteger idx, BOOL * _Nonnull stop)
    {
        if (frameModel.dataModel.isDefault) {   //判断默认地址 排序到数组第一位
            [frameArray exchangeObjectAtIndex:0 withObjectAtIndex:idx];
        }
    }];
    
    return frameArray;
}

- (void)setDataModel:(AddressModel *)dataModel
{
    _dataModel = dataModel;
    
    CGFloat margin = 10;
    
    CGSize nameSize = kTextSize(dataModel.consignee, kTextFont, CGSizeMake(MAXFLOAT, MAXFLOAT));
    
    CGFloat nameX = margin;
    CGFloat nameY = margin;
    CGFloat nameW = nameSize.width;
    CGFloat nameH = nameSize.height;
    self.nameFrame = CGRectMake(nameX, nameY, nameW, nameH);
    
    CGSize phoneSize = kTextSize(dataModel.phone, kTextFont, CGSizeMake(MAXFLOAT, MAXFLOAT));
    
    CGFloat phoneX = kScreenW - phoneSize.width - margin;
    CGFloat phoneY = nameY;
    CGFloat phoneW = phoneSize.width;
    CGFloat phoneH = nameH;
    self.phoneFrame = CGRectMake(phoneX, phoneY, phoneW, phoneH);
    
    NSString *addressStr = [NSString stringWithFormat:@"%@%@",dataModel.areaName, dataModel.address];
    
    CGSize addressSize = kTextSize(addressStr, kTextFont, CGSizeMake(kScreenW - 2*margin, MAXFLOAT));
    
    CGFloat addressX = nameX;
    CGFloat addressY = CGRectGetMaxY(self.nameFrame) + margin;
    CGFloat addressW = kScreenW - 2*margin;
    CGFloat addressH = addressSize.height;
    self.addressFrame = CGRectMake(addressX, addressY, addressW, addressH);
    
    CGFloat lineX = 0;
    CGFloat lineY = CGRectGetMaxY(self.addressFrame) + 2*margin;
    CGFloat lineW = kScreenW;
    CGFloat lineH = kSplitLineHeight;
    self.centerLineFrame = CGRectMake(lineX, lineY, lineW, lineH);
    
    CGFloat defX = nameX;
    CGFloat defY = CGRectGetMaxY(self.addressFrame) + 3*margin;
    CGFloat defW = 85;
    CGFloat defH = 25;
    self.isDefaultBtnFrame = CGRectMake(defX, defY, defW, defH);
    
    CGFloat deleX = kScreenW - 60 - margin;
    CGFloat deleY = defY;
    CGFloat deleW = 60;
    CGFloat deleH = 25;
    self.delegetBtnFrame = CGRectMake(deleX, deleY, deleW, deleH);
    
    CGFloat editX = kScreenW - 140;
    CGFloat editY = defY;
    CGFloat editW = 60;
    CGFloat editH = 25;
    self.editBtnFrame = CGRectMake(editX, editY, editW, editH);
    
    self.height = CGRectGetMaxY(self.isDefaultBtnFrame) + 10;
}
@end
