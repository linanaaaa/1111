//
//  FavoriteCell.h
//  吾家超市
//
//  Created by iMac15 on 2016/12/9.
//  Copyright © 2016年 iMac15. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsModel.h"
#import "FavoriteFrameModel.h"

typedef void(^CleanFav)(GoodsFavoriteModel *goodsModel);

@interface FavoriteCell : UITableViewCell

@property (copy,   nonatomic) CleanFav cleanFav;
@property (strong, nonatomic) FavoriteFrameModel *frameModel;

+ (instancetype)favoriteCellWithTableView:(UITableView *)tableView;

@end
