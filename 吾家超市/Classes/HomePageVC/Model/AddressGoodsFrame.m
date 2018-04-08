//
//  AddressGoodsFrame.m
//  吾家网
//
//  Created by iMac15 on 2017/6/15.
//  Copyright © 2017年 iMac15. All rights reserved.
//

#import "AddressGoodsFrame.h"

@implementation AddressGoodsFrame

+ (NSArray *)frameModelArrayWithDataArray:(NSArray *)dataArray
{
    NSMutableArray *frameArray = [NSMutableArray arrayWithCapacity:dataArray.count];
    for (AddressModel *dataModel in dataArray) {
        AddressGoodsFrame *frameModel = [[AddressGoodsFrame alloc] init];
        frameModel.dataModel = dataModel;
        [frameArray addObject:frameModel];
    }
    return frameArray;
}

- (void)setDataModel:(AddressModel *)dataModel
{
    _dataModel = dataModel;
    
    CGFloat margin = 10;
    
    CGFloat imageX = margin;
    CGFloat imageY = 2*margin;
    CGFloat imageW = 10;
    CGFloat imageH = 10;
    self.imageFrame = CGRectMake(imageX, imageY, imageW, imageH);
    
    
    NSString *addressStr = [NSString stringWithFormat:@"%@%@",dataModel.areaName, dataModel.address];
    
    CGSize addressSize = kTextSize(addressStr, kTextFont, CGSizeMake(kScreenW - 2*margin, MAXFLOAT));
    
    CGFloat addressX = CGRectGetMaxX(self.imageFrame) + margin;
    CGFloat addressY = margin;
    CGFloat addressW = kScreenW - 4*margin;
    CGFloat addressH = addressSize.height;
    self.addressFrame = CGRectMake(addressX, addressY, addressW, addressH);
    
    self.height = CGRectGetMaxY(self.addressFrame) + 10;
}
@end

