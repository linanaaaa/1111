//
//  OrderGoodsFrame.m
//  吾家超市
//
//  Created by iMac15 on 2016/11/21.
//  Copyright © 2016年 iMac15. All rights reserved.
//

#import "OrderGoodsFrame.h"

@implementation OrderGoodsFrame


+ (NSArray *)frameModelArrayWithDataArray:(NSArray *)dataArray
{
    NSMutableArray *frameArray = [NSMutableArray arrayWithCapacity:dataArray.count];
    for (OrderItemsModel *dataModel in dataArray) {
        OrderGoodsFrame *frameModel = [[OrderGoodsFrame alloc] init];
        frameModel.goodsModel = dataModel;
        [frameArray addObject:frameModel];
    }
    return frameArray;
}

- (void)setGoodsModel:(OrderItemsModel *)goodsModel
{
    _goodsModel = goodsModel;
    
    CGFloat margin = 10;
    
    CGFloat picW = 80;
    CGFloat picH = 80;

    CGFloat picX = margin;
    CGFloat picY = margin;
    self.imageViewF = CGRectMake(picX, picY, picW, picH);
    
    CGFloat nameX = CGRectGetMaxX(self.imageViewF) + margin;
    CGFloat nameY = margin;
    CGFloat nameW = kScreenW - nameX - margin;
    
    NSString *nameStr = goodsModel.name;
    CGSize typeSize = kTextSize(nameStr, kTextFont, CGSizeMake(nameW, 33.5));
    
    CGFloat nameH = typeSize.height;
    self.nameF = CGRectMake(nameX, nameY, nameW, nameH);
    
    NSString *priceStr = [NSString stringWithFormat:@"¥ %@",goodsModel.price];
    CGSize priceSize = kTextSize(priceStr, kTextFont, CGSizeMake(MAXFLOAT, MAXFLOAT));
    
    CGFloat priceX = nameX;
    CGFloat priceY = CGRectGetMaxY(self.nameF) + margin;
    CGFloat priceW = priceSize.width;
    CGFloat priceH = priceSize.height;
    self.priceF = CGRectMake(priceX, priceY, priceW, priceH);
    
    NSString *numberStr = [NSString stringWithFormat:@"x%@",goodsModel.quantity];
    CGSize numberSize = kTextSize(numberStr, kTextFont, CGSizeMake(MAXFLOAT, MAXFLOAT));

    CGFloat numberX = kScreenW - numberSize.width - 2*margin;
    CGFloat numberY = priceY;
    CGFloat numberW = numberSize.width;
    CGFloat numberH = numberSize.height;
    self.numberF = CGRectMake(numberX, numberY, numberW, numberH);
    
    self.cellHeight = CGRectGetMaxY(self.imageViewF) + margin;
}
@end
