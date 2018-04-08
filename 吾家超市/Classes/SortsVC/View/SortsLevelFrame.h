//
//  SortsLevelFrame.h
//  吾家超市
//
//  Created by iMac15 on 2017/1/13.
//  Copyright © 2017年 iMac15. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GoodsModel.h"

@interface SortsLevelFrame : NSObject

+ (NSArray *)frameModelArrayWithDataArray:(NSArray *)dataArray;

@property (strong, nonatomic) SortsLevelData *dataModel;
@property (strong, nonatomic) NSArray *tagsArray;

@property (assign, nonatomic) CGRect topLineF;
@property (assign, nonatomic) CGRect centerLineF;
@property (assign, nonatomic) CGRect imageViewF;
@property (assign, nonatomic) CGRect nameF;
@property (assign, nonatomic) CGRect tagViewF;

@property (assign, nonatomic) CGFloat cellHeight;
@end
