//
//  CouponCellFrame.h
//  吾家超市
//
//  Created by iMac15 on 2017/1/23.
//  Copyright © 2017年 iMac15. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CouponModel.h"

@interface CouponCellFrame : NSObject
+ (NSArray *)frameModelArrayWithDataArray:(NSArray *)dataArray;

@property (strong, nonatomic) CouponModel *dataModel;
@property (assign, nonatomic) CGRect nameF;
@property (assign, nonatomic) CGRect introductionF;
@property (assign, nonatomic) CGRect dataF;
@property (assign, nonatomic) CGRect userLabelF;
@property (assign, nonatomic) CGRect minimumPriceF;
@property (assign, nonatomic) CGRect minimumQuantityF;
@property (assign, nonatomic) CGRect bottomLineF;
@property (assign, nonatomic) CGRect picImageF;

@property (assign, nonatomic) CGFloat cellHeight;
@end
