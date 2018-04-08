//
//  SortsLevelFrame.m
//  吾家超市
//
//  Created by iMac15 on 2017/1/13.
//  Copyright © 2017年 iMac15. All rights reserved.
//

#import "SortsLevelFrame.h"

@implementation SortsLevelFrame

+ (NSArray *)frameModelArrayWithDataArray:(NSArray *)dataArray
{
    NSMutableArray *frameArray = [NSMutableArray arrayWithCapacity:dataArray.count];
    for (SortsLevelData *dataModel in dataArray) {
        SortsLevelFrame *frameModel = [[SortsLevelFrame alloc] init];

        if (![dataModel.isPullOff isEqualToString:@"1"]) {
            
            if (!kArrayIsEmpty(dataModel.children) && ![dataModel.name isEqualToString:@"测试分类"])
            {
                frameModel.dataModel = dataModel;
                [frameArray addObject:frameModel];
            }
        }
    }
    
    return frameArray;
}

- (void)setDataModel:(SortsLevelData *)dataModel
{
    _dataModel = dataModel;
    
    CGFloat margin = 10;
    
    self.topLineF = CGRectMake(0, 0, kScreenW, margin);
    
    CGFloat imageX = 0;
    CGFloat imageY = CGRectGetMaxY(self.topLineF) + 5;
    CGFloat imageW = 5;
    CGFloat imageH = 25;
    self.imageViewF = CGRectMake(imageX, imageY, imageW, imageH);

    CGFloat nameX = CGRectGetMaxX(self.imageViewF) + margin;
    CGFloat nameY = imageY;
    CGFloat nameW = kScreenW - 25;
    CGFloat nameH = 25;
    self.nameF = CGRectMake(nameX, nameY, nameW, nameH);
    
    self.centerLineF = CGRectMake(0, CGRectGetMaxY(self.imageViewF) + margin, kScreenW, kSplitLineHeight);
    
    CGFloat tagViewX = margin;
    CGFloat tagViewY = CGRectGetMaxY(self.centerLineF) + 5;
    CGFloat tagViewW = kScreenW - 30;
    CGFloat tagViewH = 50;
    self.tagViewF = CGRectMake(tagViewX, tagViewY, tagViewW, tagViewH);
    
    self.cellHeight = CGRectGetMaxY(self.tagViewF) + 10;
}

@end
