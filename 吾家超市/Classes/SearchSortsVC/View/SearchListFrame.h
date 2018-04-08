//
//  SearchListFrame.h
//  吾家超市
//
//  Created by iMac15 on 2016/11/11.
//  Copyright © 2016年 iMac15. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GoodsModel.h"

@interface SearchListFrame : NSObject

+ (NSArray *)frameModelArrayWithDataArray:(NSArray *)dataArray;

@property (strong, nonatomic) GoodsModel *dataModel;
@property (assign, nonatomic) CGRect imageF;
@property (assign, nonatomic) CGRect nameF;
@property (assign, nonatomic) CGRect priceF;
@property (assign, nonatomic) CGRect addCarBtnF;
@property (assign, nonatomic) CGFloat cellHeight;
@end
