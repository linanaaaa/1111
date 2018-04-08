//
//  FavoriteFrameModel.h
//  吾家超市
//
//  Created by iMac15 on 2016/12/9.
//  Copyright © 2016年 iMac15. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GoodsModel.h"

@interface FavoriteFrameModel : NSObject
@property (strong, nonatomic) GoodsFavoriteModel *dataModel;
@property (assign, nonatomic) CGRect picImageF;
@property (assign, nonatomic) CGRect nameF;
@property (assign, nonatomic) CGRect isFavorBtnF;
@property (assign, nonatomic) CGRect priceF;
@property (assign, nonatomic) CGFloat cellHeight;

+ (NSArray *)frameModelArrayWithDataArray:(NSArray *)dataArray;

@end
