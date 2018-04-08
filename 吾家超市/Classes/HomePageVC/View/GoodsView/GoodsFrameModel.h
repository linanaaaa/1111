//
//  GoodsFrameModel.h
//  吾家超市
//
//  Created by iMac15 on 2016/11/9.
//  Copyright © 2016年 iMac15. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GoodsModel.h"

@interface GoodsFrameModel : NSObject

+ (NSArray *)frameModelArrayWithDataArray:(NSArray *)dataArray;

@property (strong, nonatomic) GoodsModel *dataModel;
@property (assign, nonatomic) CGRect picImageF;
@property (assign, nonatomic) CGRect nameF;
@property (assign, nonatomic) CGRect fullNameF;
@property (assign, nonatomic) CGRect priceF;
@property (assign, nonatomic) CGFloat cellHeight;
@end
