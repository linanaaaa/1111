//
//  OrderTrackFrame.h
//  吾家超市
//
//  Created by iMac15 on 2017/2/15.
//  Copyright © 2017年 iMac15. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OrderListModel.h"

@interface OrderTrackFrame : NSObject
+ (NSArray *)frameModelArrayWithDataArray:(NSArray *)dataArray;

@property (strong, nonatomic) OrderTrackModel *dataModel;
@property (assign, nonatomic) CGRect timeF;
@property (assign, nonatomic) CGRect textF;

@property (assign, nonatomic) CGFloat cellHeight;
@end
