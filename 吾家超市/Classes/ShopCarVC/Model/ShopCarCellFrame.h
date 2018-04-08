//
//  ShopCarCellFrame.h
//  吾家超市
//
//  Created by iMac15 on 2016/11/15.
//  Copyright © 2016年 iMac15. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GoodsModel.h"

@interface ShopCarCellFrame : NSObject

+ (NSArray *)frameModelArrayWithDataArray:(NSArray *)dataArray;

@property (strong, nonatomic) ShopCarProduct *dataModel;
@property (assign, nonatomic) CGRect nameF;
@property (assign, nonatomic) CGRect priceF;
@property (assign, nonatomic) CGRect picF;
@property (assign, nonatomic) CGRect selectedBtnF;
@property (assign, nonatomic) CGRect deleghtBtnF;
@property (assign, nonatomic) CGRect numberViewF;
@property (assign, nonatomic) CGFloat cellHeight;
@end
