//
//  GoodsFrameModel.m
//  吾家超市
//
//  Created by iMac15 on 2016/11/9.
//  Copyright © 2016年 iMac15. All rights reserved.
//

#import "GoodsFrameModel.h"

@implementation GoodsFrameModel

+ (NSArray *)frameModelArrayWithDataArray:(NSArray *)dataArray
{
    NSMutableArray *frameArray = [NSMutableArray arrayWithCapacity:dataArray.count];
    for (GoodsModel *dataModel in dataArray) {
        GoodsFrameModel *frameModel = [[GoodsFrameModel alloc] init];
        frameModel.dataModel = dataModel;
        [frameArray addObject:frameModel];
    }
    return frameArray;
}

- (void)setDataModel:(GoodsModel *)dataModel
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
    
    NSString *nameStr = dataModel.name;
    CGSize typeSize = kTextSize(nameStr, kTextFont, CGSizeMake(nameW, 33.5));
   
    CGFloat nameH = typeSize.height;
    self.nameF = CGRectMake(nameX, nameY, nameW, nameH);
    
    CGFloat fullNameX = nameX;
    CGFloat fullNameY = CGRectGetMaxY(self.nameF)+5;
    CGFloat fullNameW = nameW;
    CGFloat fullNameH = 20;
    self.fullNameF = CGRectMake(fullNameX, fullNameY, fullNameW, fullNameH);
    
    CGFloat priceY;
    
    if (dataModel.keyword.length >0) {
        priceY = CGRectGetMaxY(self.fullNameF);
    }
    else{
        priceY = CGRectGetMaxY(self.nameF) + 5;
    }    
    
    CGFloat priceX = nameX;
    CGFloat priceW = nameW;
    CGFloat priceH = fullNameH;
    self.priceF = CGRectMake(priceX, priceY, priceW, priceH);
    
    self.cellHeight = CGRectGetMaxY(self.picImageF);
}

@end
