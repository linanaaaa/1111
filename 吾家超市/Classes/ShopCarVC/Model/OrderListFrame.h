//
//  OrderListFrame.h
//  吾家超市
//
//  Created by iMac15 on 2016/11/22.
//  Copyright © 2016年 iMac15. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OrderListModel.h"

@interface OrderListFrame : NSObject

+ (NSArray *)frameModelArrayWithDataArray:(NSArray *)dataArray;

@property (strong, nonatomic) OrderItems *dataModel;

@property (assign, nonatomic) CGRect imageViewF;
@property (assign, nonatomic) CGRect nameF;
@property (assign, nonatomic) CGRect priceF;
@property (assign, nonatomic) CGRect numberF;

@property (assign, nonatomic) CGFloat cellHeight;
@end
