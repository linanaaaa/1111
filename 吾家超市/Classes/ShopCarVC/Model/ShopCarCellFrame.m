//
//  ShopCarCellFrame.m
//  吾家超市
//
//  Created by iMac15 on 2016/11/15.
//  Copyright © 2016年 iMac15. All rights reserved.
//

#import "ShopCarCellFrame.h"

@implementation ShopCarCellFrame

+ (NSArray *)frameModelArrayWithDataArray:(NSArray *)dataArray
{
    NSMutableArray *frameArray = [NSMutableArray arrayWithCapacity:dataArray.count];
    for (ShopCarProduct *dataModel in dataArray) {
        ShopCarCellFrame *frameModel = [[ShopCarCellFrame alloc] init];
        frameModel.dataModel = dataModel;
        [frameArray addObject:frameModel];
    }
    return frameArray;
}

- (void)setDataModel:(ShopCarProduct *)dataModel
{
    _dataModel = dataModel;
    
    CGFloat margin = 10;
    
    CGFloat picW = 80;
    CGFloat picH = 80;
    
    CGFloat selectedBtnX = margin;
    CGFloat selectedBtnY = picH/2;
    CGFloat selectedBtnW = 20;
    CGFloat selectedBtnH = 20;
    self.selectedBtnF = CGRectMake(selectedBtnX, selectedBtnY, selectedBtnW, selectedBtnH);
    
    CGFloat picX = CGRectGetMaxX(self.selectedBtnF) + margin;
    CGFloat picY = margin;
    self.picF = CGRectMake(picX, picY, picW, picH);
    
    CGFloat nameX = CGRectGetMaxX(self.picF) + margin;
    CGFloat nameY = margin;
    CGFloat nameW = kScreenW - nameX - 40;
    
    NSString *nameStr = dataModel.product.name;
    CGSize typeSize = kTextSize(nameStr, kTextFont, CGSizeMake(nameW, 33.5));
    
    CGFloat nameH = typeSize.height;
    self.nameF = CGRectMake(nameX, nameY, nameW, nameH);
    
    CGFloat deleghtBtnX = kScreenW - 30;
    CGFloat deleghtBtnY = nameY;
    CGFloat deleghtBtnW = 20;
    CGFloat deleghtBtnH = 20;
    self.deleghtBtnF = CGRectMake(deleghtBtnX, deleghtBtnY, deleghtBtnW, deleghtBtnH);
    
    NSString *priceStr = [NSString stringWithFormat:@"¥ %@",dataModel.product.price];
    CGSize priceSize = kTextSize(priceStr, kTextFont, CGSizeMake(MAXFLOAT, MAXFLOAT));

    CGFloat priceX = kScreenW - priceSize.width - margin;
    CGFloat priceY = picH - 20;
    CGFloat priceW = priceSize.width;
    CGFloat priceH = priceSize.height;
    self.priceF = CGRectMake(priceX, priceY, priceW, priceH);
    
    CGFloat numberViewX = nameX;
    CGFloat numberViewY = picH - 20;
    CGFloat numberViewW = 80;
    CGFloat numberViewH = 20;
    self.numberViewF = CGRectMake(numberViewX, numberViewY, numberViewW, numberViewH);
    
    self.cellHeight = CGRectGetMaxY(self.picF) + 10;
}

@end
