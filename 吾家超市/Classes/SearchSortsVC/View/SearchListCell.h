//
//  SearchListCell.h
//  吾家超市
//
//  Created by iMac15 on 2016/11/11.
//  Copyright © 2016年 iMac15. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsModel.h"
#import "SearchListFrame.h"

typedef void(^AddCarList)(GoodsModel *model);

@interface SearchListCell : UICollectionViewCell
@property (strong, nonatomic) SearchListFrame *frameModel;
@property (copy,   nonatomic) AddCarList addCarList;
@end
