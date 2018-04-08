//
//  SortsListCell.h
//  吾家超市
//
//  Created by HuaCapf on 2017/1/21.
//  Copyright © 2017年 iMac15. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsModel.h"

typedef void(^AddCarList)(GoodsModel *model);

@interface SortsListCell : UICollectionViewCell
@property (strong, nonatomic) GoodsModel *sortsGoodsModel;
@property (copy,   nonatomic) AddCarList addCarList;
@property (assign, nonatomic) BOOL isGrid;
@end
