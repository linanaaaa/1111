//
//  SortsListVC.h
//  吾家超市
//
//  Created by iMac15 on 2016/12/27.
//  Copyright © 2016年 iMac15. All rights reserved.
//

#import "BaseVC.h"
#import "GoodsModel.h"

@interface SortsListVC : BaseVC
@property (strong, nonatomic) NSString *sortStr;    //名称
@property (strong, nonatomic) NSString *sortId;     //三级分类id
@property (strong, nonatomic) NSString *sortSid;    //二级分类id

@property (assign, nonatomic) BOOL isTypeGrid;      //列表样式

@property (strong, nonatomic) NSArray *sortTagArray;   //二级分类列表
@property (strong, nonatomic) SortsLevelData *sortsHomeModel;
@end
