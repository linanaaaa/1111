//
//  HotFrameModel.m
//  吾家超市
//
//  Created by iMac15 on 2016/12/14.
//  Copyright © 2016年 iMac15. All rights reserved.
//

#import "HotFrameModel.h"

@implementation HotFrameModel

+ (NSArray *)frameModelArrayWithDataArray:(NSArray *)dataArray
{
    NSMutableArray *frameArray = [NSMutableArray arrayWithCapacity:dataArray.count];
    for (HotGoodsData *dataModel in dataArray) {
        HotFrameModel *frameModel = [[HotFrameModel alloc] init];
        frameModel.dataModel = dataModel;
        [frameArray addObject:frameModel];
    }
    return frameArray;
}

- (void)setDataModel:(HotGoodsData *)dataModel
{
    _dataModel = dataModel;
    
    CGFloat margin = 10;
    
    CGFloat nameX = margin;
    CGFloat nameY = margin;
    CGFloat nameW = kScreenW - 2*margin;
    
    NSString *nameStr = dataModel.name;
    CGSize typeSize = kTextSize(nameStr, kTextFont, CGSizeMake(nameW, MAXFLOAT));
    
    CGFloat nameH = typeSize.height;
    self.nameF = CGRectMake(nameX, nameY, nameW, nameH);
    
    CGFloat fullNameX = nameX;
    CGFloat fullNameY = CGRectGetMaxY(self.nameF) + 5;
    CGFloat fullNameW = nameW;
    CGFloat fullNameH = 20;
    self.fullNameF = CGRectMake(fullNameX, fullNameY, fullNameW, fullNameH);
    
    
    CGFloat priceNameY;
    
    if (dataModel.keyword.length > 0) { //判断简介是否空,空-价格在名称下面,不为空-价格在简介下面;
        priceNameY = CGRectGetMaxY(self.fullNameF) + 5;
    }
    else{
        priceNameY = CGRectGetMaxY(self.nameF) + 5;
    }
    
    CGFloat priceNameX = nameX;
    CGFloat priceNameW = nameW;
    CGFloat priceNameH = 20;
    self.priceNameF = CGRectMake(priceNameX, priceNameY, priceNameW, priceNameH);
    
    CGFloat picImageX = margin;
    CGFloat picImageY = CGRectGetMaxY(self.priceNameF) + 5;
    CGFloat picImageW = (kScreenW - 40)/3;
    CGFloat picImageH = (kScreenW - 40)/3;
    
    self.picImageF = CGRectMake(picImageX, picImageY, picImageW, picImageH);
    
    self.pic2ImageF = CGRectMake(CGRectGetMaxX(self.picImageF) + margin, picImageY, picImageW, picImageH);
    
    self.pic3ImageF = CGRectMake(CGRectGetMaxX(self.pic2ImageF) + margin, picImageY, picImageW, picImageH);
    
    self.cellHeight = CGRectGetMaxY(self.picImageF);
}
@end
