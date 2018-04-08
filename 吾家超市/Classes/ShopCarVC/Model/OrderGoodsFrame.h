//
//  OrderGoodsFrame.h
//  吾家超市
//
//  Created by iMac15 on 2016/11/21.
//  Copyright © 2016年 iMac15. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OrderModel.h"

@interface OrderGoodsFrame : NSObject

+ (NSArray *)frameModelArrayWithDataArray:(NSArray *)dataArray;

@property (strong, nonatomic) OrderItemsModel *goodsModel;

@property (assign, nonatomic) CGRect imageViewF;
@property (assign, nonatomic) CGRect nameF;
@property (assign, nonatomic) CGRect priceF;
@property (assign, nonatomic) CGRect numberF;

@property (assign, nonatomic) CGFloat cellHeight;

@property (strong, nonatomic) NSString *selectProductIdStr;
@end
