//
//  CouponCellFrame.m
//  吾家超市
//
//  Created by iMac15 on 2017/1/23.
//  Copyright © 2017年 iMac15. All rights reserved.
//

#import "CouponCellFrame.h"

@implementation CouponCellFrame

+ (NSArray *)frameModelArrayWithDataArray:(NSArray *)dataArray
{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:dataArray.count];
    for (CouponModel *dataModel in dataArray)
    {
        CouponCellFrame *frameModel = [[CouponCellFrame alloc] init];
        frameModel.dataModel = dataModel;
        [array addObject:frameModel];
    }
    return array;
}

- (void)setDataModel:(CouponModel *)dataModel
{
    _dataModel = dataModel;
    
    CGFloat margin = 10;
    
    CGFloat nameX = margin;
    CGFloat nameY = margin;
    CGFloat nameW = 120;
    CGFloat nameH = 120;
    self.nameF = CGRectMake(nameX, nameY, nameW, nameH);
    
    CGFloat picImageX = kScreenW - 60;
    CGFloat picImageY = 10;
    CGFloat picImageW = 80;
    CGFloat picImageH = 80;
    self.picImageF = CGRectMake(picImageX, picImageY, picImageW, picImageH);
    
    CGFloat bottomLineX = 0;
    CGFloat bottomLineY = CGRectGetMaxY(self.nameF) + margin;
    CGFloat bottomLineW = kScreenW;
    CGFloat bottomLineH = kSplitLineHeight;
    self.bottomLineF = CGRectMake(bottomLineX, bottomLineY, bottomLineW, bottomLineH);
    
    CGFloat introductionX = CGRectGetMaxX(self.nameF) + margin;
    CGFloat introductionY = margin;
    CGFloat introductionW = kScreenW - 160;
    CGFloat introductionH = 30;
    self.introductionF = CGRectMake(introductionX, introductionY, introductionW, introductionH);
    
    CGFloat minimumPriceX = introductionX;
    CGFloat minimumPriceY = CGRectGetMaxY(self.introductionF);
    CGFloat minimumPriceW = kScreenW - 160;
    CGFloat minimumPriceH = 30;
    self.minimumPriceF = CGRectMake(minimumPriceX, minimumPriceY, minimumPriceW, minimumPriceH);
    
    CGFloat minimumQuantityX = introductionX;
    CGFloat minimumQuantityY = CGRectGetMaxY(self.minimumPriceF);
    CGFloat minimumQuantityW = kScreenW - 160;
    CGFloat minimumQuantityH = 30;
    self.minimumQuantityF = CGRectMake(minimumQuantityX, minimumQuantityY, minimumQuantityW, minimumQuantityH);
    
    CGFloat dataX = introductionX;
    CGFloat dataY = CGRectGetMaxY(self.minimumQuantityF);
    CGFloat dataW = kScreenW - 160;
    CGFloat dataH = 30;
    self.dataF = CGRectMake(dataX, dataY, dataW, dataH);
    
    CGFloat userLabelX = margin;
    CGFloat userLabelY = CGRectGetMaxY(self.bottomLineF);
    CGFloat userLabelW = kScreenW - 20;
    CGFloat userLabelH = 40;
    self.userLabelF = CGRectMake(userLabelX, userLabelY, userLabelW, userLabelH);
    
    self.cellHeight = CGRectGetMaxY(self.userLabelF);
}

@end
