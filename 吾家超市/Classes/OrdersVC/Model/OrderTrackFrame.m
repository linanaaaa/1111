//
//  OrderTrackFrame.m
//  吾家超市
//
//  Created by iMac15 on 2017/2/15.
//  Copyright © 2017年 iMac15. All rights reserved.
//

#import "OrderTrackFrame.h"

@implementation OrderTrackFrame

+ (NSArray *)frameModelArrayWithDataArray:(NSArray *)dataArray
{
    NSMutableArray *frameArray = [NSMutableArray arrayWithCapacity:dataArray.count];
    for (OrderTrackModel *dataModel in dataArray) {
        OrderTrackFrame *frameModel = [[OrderTrackFrame alloc] init];
        frameModel.dataModel = dataModel;
        [frameArray addObject:frameModel];
    }
    return frameArray;
}

- (void)setDataModel:(OrderTrackModel *)dataModel
{
    _dataModel = dataModel;
    
    CGFloat margin = 10;
    
    CGFloat timeX = margin;
    CGFloat timeY = margin;
    CGFloat timeW = kScreenW - 20;
    CGFloat timeH = 30;
    
    self.timeF = CGRectMake(timeX, timeY, timeW, timeH);
    
    CGSize textSize = kTextSize(dataModel.opInfo, kTextFont, CGSizeMake(kScreenW - 2*margin, MAXFLOAT));
    
    CGFloat textX = margin;
    CGFloat textY = CGRectGetMaxY(self.timeF);
    CGFloat textW = kScreenW - 20;
    CGFloat textH = textSize.height;
    self.textF = CGRectMake(textX, textY, textW, textH);
    
    self.cellHeight = CGRectGetMaxY(self.textF) + margin;
}

@end
