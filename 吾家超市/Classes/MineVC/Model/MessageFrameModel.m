//
//  MessageFrameModel.m
//  吾家超市
//
//  Created by iMac15 on 2016/12/12.
//  Copyright © 2016年 iMac15. All rights reserved.
//

#import "MessageFrameModel.h"

@implementation MessageFrameModel

+ (NSArray *)frameModelArrayWithDataArray:(NSArray *)dataArray
{
    NSMutableArray *frameArray = [NSMutableArray arrayWithCapacity:dataArray.count];
    for (MessageModel *dataModel in dataArray) {
        MessageFrameModel *frameModel = [[MessageFrameModel alloc] init];
        frameModel.dataModel = dataModel;
        [frameArray addObject:frameModel];
    }
    return frameArray;
}

- (void)setDataModel:(MessageModel *)dataModel
{
    _dataModel = dataModel;
    
    CGFloat margin = 10;
    
    CGFloat picImageX = margin;
    CGFloat picImageY = margin;
    CGFloat picImageW = 40;
    CGFloat picImageH = 40;
    self.picImageF = CGRectMake(picImageX, picImageY, picImageW, picImageH);
    
    CGFloat detailX = CGRectGetMaxX(self.picImageF) + margin;;
    CGFloat detailY = margin;
    CGFloat detailW = kScreenW - detailX - margin;
    
    CGFloat detailH = picImageH;
    self.detailF = CGRectMake(detailX, detailY, detailW, detailH);
    
    self.cellHeight = CGRectGetMaxY(self.picImageF) + margin;
}

@end
