//
//  OrderListFrame.m
//  吾家超市
//
//  Created by iMac15 on 2016/11/22.
//  Copyright © 2016年 iMac15. All rights reserved.
//

#import "OrderListFrame.h"

@implementation OrderListFrame

+ (NSArray *)frameModelArrayWithDataArray:(NSArray *)dataArray
{
    NSMutableArray *frameArray = [NSMutableArray arrayWithCapacity:dataArray.count];
    for (OrderItems *dataModel in dataArray) {
        OrderListFrame *frameModel = [[OrderListFrame alloc] init];
        frameModel.dataModel = dataModel;
        [frameArray addObject:frameModel];
    }
    return frameArray;
}

- (void)setDataModel:(OrderItems *)dataModel
{
    _dataModel = dataModel;
    
    CGFloat margin = 10;
    
    CGFloat picW = 80;
    CGFloat picH = 80;
    
    CGFloat picX = margin;
    CGFloat picY = margin;
    self.imageViewF = CGRectMake(picX, picY, picW, picH);
    
    CGFloat nameX = CGRectGetMaxX(self.imageViewF) + margin;
    CGFloat nameY = 2*margin;
    CGFloat nameW = kScreenW - nameX - margin;
    CGFloat nameH = kTextHeight(dataModel.name, kTextFont, nameW);
    self.nameF = CGRectMake(nameX, nameY, nameW, nameH);
    
    NSString *priceStr = [NSString stringWithFormat:@"¥ %@",dataModel.price];
    CGSize priceSize = kTextSize(priceStr, kTextFont, CGSizeMake(MAXFLOAT, MAXFLOAT));
    
    CGFloat priceX = nameX;
    CGFloat priceY;
    priceY = CGRectGetMaxY(self.nameF) + margin;
    
    if (nameH > 40) {
        priceY = CGRectGetMaxY(self.nameF);
    }
    
    CGFloat priceW = priceSize.width;
    CGFloat priceH = priceSize.height;
    self.priceF = CGRectMake(priceX, priceY, priceW, priceH);
    
//    NSString *numberStr = [NSString stringWithFormat:@"x%@",dataModel.quantity];
    NSString *numberStr = @"x1";
    CGSize numberSize = kTextSize(numberStr, kTextFont, CGSizeMake(MAXFLOAT, MAXFLOAT));
    
    CGFloat numberX = kScreenW - numberSize.width - 2*margin;
    CGFloat numberY = CGRectGetMaxY(self.imageViewF) - numberSize.height;
    CGFloat numberW = numberSize.width;
    CGFloat numberH = numberSize.height;
    self.numberF = CGRectMake(numberX, numberY, numberW, numberH);
    
    self.cellHeight = CGRectGetMaxY(self.imageViewF) + margin;
}

@end
