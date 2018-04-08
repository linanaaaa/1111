//
//  MessageFrameModel.h
//  吾家超市
//
//  Created by iMac15 on 2016/12/12.
//  Copyright © 2016年 iMac15. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MessageModel.h"

@interface MessageFrameModel : NSObject
@property (strong, nonatomic) MessageModel *dataModel;
@property (assign, nonatomic) CGRect picImageF;
@property (assign, nonatomic) CGRect detailF;
@property (assign, nonatomic) CGFloat cellHeight;

+ (NSArray *)frameModelArrayWithDataArray:(NSArray *)dataArray;

@end
