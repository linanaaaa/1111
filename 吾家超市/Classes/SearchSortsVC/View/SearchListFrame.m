//
//  SearchListFrame.m
//  吾家超市
//
//  Created by iMac15 on 2016/11/11.
//  Copyright © 2016年 iMac15. All rights reserved.
//

#import "SearchListFrame.h"

@implementation SearchListFrame

+ (NSArray *)frameModelArrayWithDataArray:(NSArray *)dataArray
{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:dataArray.count];
    for (GoodsModel *dataModel in dataArray)
    {
        SearchListFrame *frameModel = [[SearchListFrame alloc] init];
        frameModel.dataModel = dataModel;
        [array addObject:frameModel];
    }
    return array;
}

- (void)setDataModel:(GoodsModel *)dataModel
{
    _dataModel = dataModel;
    
    CGFloat margin = 10;
    
    CGFloat imageX = margin;
    CGFloat imageY = margin;
    CGFloat imageW = 80;
    CGFloat imageH = 80;
    self.imageF = CGRectMake(imageX, imageY, imageW, imageH);
    
    CGFloat nameX = CGRectGetMaxX(self.imageF) + margin;
    CGFloat nameY = margin;
    CGFloat nameW = kScreenW - 30 - imageW;
    CGFloat nameH = 40;
    self.nameF = CGRectMake(nameX, nameY, nameW, nameH);
    
    CGFloat priceX = nameX;
    CGFloat priceY = CGRectGetMaxY(self.nameF) + margin;
    CGFloat priceW = nameW - 20;
    CGFloat priceH = 20;
    self.priceF = CGRectMake(priceX, priceY, priceW, priceH);
    
    CGFloat btnX = CGRectGetMaxX(self.priceF);
    CGFloat btnY = priceY;
    CGFloat btnW = 20;
    CGFloat btnH = 20;
    self.addCarBtnF = CGRectMake(btnX, btnY, btnW, btnH);
    
    self.cellHeight = CGRectGetMaxY(self.priceF);
}

@end
