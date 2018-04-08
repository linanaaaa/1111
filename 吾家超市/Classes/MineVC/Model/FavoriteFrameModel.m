//
//  FavoriteFrameModel.m
//  吾家超市
//
//  Created by iMac15 on 2016/12/9.
//  Copyright © 2016年 iMac15. All rights reserved.
//

#import "FavoriteFrameModel.h"

@implementation FavoriteFrameModel

+ (NSArray *)frameModelArrayWithDataArray:(NSArray *)dataArray
{
    NSMutableArray *frameArray = [NSMutableArray arrayWithCapacity:dataArray.count];
    for (GoodsFavoriteModel *dataModel in dataArray) {
        FavoriteFrameModel *frameModel = [[FavoriteFrameModel alloc] init];
        frameModel.dataModel = dataModel;
        [frameArray addObject:frameModel];
    }
    return frameArray;
}

- (void)setDataModel:(GoodsFavoriteModel *)dataModel
{
    _dataModel = dataModel;
    
    CGFloat margin = 10;
    
    CGFloat picImageX = margin;
    CGFloat picImageY = margin;
    CGFloat picImageW = 80;
    CGFloat picImageH = 80;
    self.picImageF = CGRectMake(picImageX, picImageY, picImageW, picImageH);
    
    CGFloat nameX = CGRectGetMaxX(self.picImageF) + margin;
    CGFloat nameY = picImageY;
    CGFloat nameW = kScreenW - nameX - margin;
    
    NSString *nameStr = dataModel.productName;
    CGSize typeSize = kTextSize(nameStr, kTextFont, CGSizeMake(nameW, MAXFLOAT));
    
    CGFloat nameH = typeSize.height;
    self.nameF = CGRectMake(nameX, nameY, nameW, nameH);
    
    CGFloat priceX = nameX;
    CGFloat priceY = 60;
    CGFloat priceW = 100;
    CGFloat priceH = 30;
    self.priceF = CGRectMake(priceX, priceY, priceW, priceH);
    
    CGFloat btnX = kScreenW - 100;
    CGFloat btnY = priceY;
    CGFloat btnW = 90;
    CGFloat btnH = 30;
    self.isFavorBtnF = CGRectMake(btnX, btnY, btnW, btnH);
    
    self.cellHeight = CGRectGetMaxY(self.picImageF) + margin;
}

@end
