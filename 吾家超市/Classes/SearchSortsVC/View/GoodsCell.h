//
//  GoodsCell.h
//  吾家超市
//
//  Created by iMac15 on 2016/11/8.
//  Copyright © 2016年 iMac15. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsModel.h"
#import "GoodsFrameModel.h"

@interface GoodsCell : UITableViewCell

@property (strong, nonatomic) GoodsFrameModel *frameModel;

+ (instancetype)goodsCellWithTableView:(UITableView *)tableView;

@end
