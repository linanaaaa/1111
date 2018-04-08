//
//  HotFrameModel.h
//  吾家超市
//
//  Created by iMac15 on 2016/12/14.
//  Copyright © 2016年 iMac15. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HomeAdModel.h"

@interface HotFrameModel : NSObject

+ (NSArray *)frameModelArrayWithDataArray:(NSArray *)dataArray;

@property (strong, nonatomic) HotGoodsData *dataModel;
@property (assign, nonatomic) CGRect picImageF;
@property (assign, nonatomic) CGRect pic2ImageF;
@property (assign, nonatomic) CGRect pic3ImageF;
@property (assign, nonatomic) CGRect nameF;
@property (assign, nonatomic) CGRect fullNameF;
@property (assign, nonatomic) CGRect priceNameF;
@property (assign, nonatomic) CGFloat cellHeight;
@end
