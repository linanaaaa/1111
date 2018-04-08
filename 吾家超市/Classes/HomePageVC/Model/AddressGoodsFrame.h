//
//  AddressGoodsFrame.h
//  吾家网
//
//  Created by iMac15 on 2017/6/15.
//  Copyright © 2017年 iMac15. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AddressModel.h"

@interface AddressGoodsFrame : NSObject
@property (strong, nonatomic) AddressModel *dataModel;

+ (NSArray *)frameModelArrayWithDataArray:(NSArray *)dataArray;

@property (assign, nonatomic) CGRect imageFrame;
@property (assign, nonatomic) CGRect addressFrame;

@property (assign, nonatomic) CGFloat height;

@end
