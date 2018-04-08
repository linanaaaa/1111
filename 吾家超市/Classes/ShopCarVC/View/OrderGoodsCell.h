//
//  OrderGoodsCell.h
//  吾家超市
//
//  Created by iMac15 on 2016/11/21.
//  Copyright © 2016年 iMac15. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderGoodsFrame.h"

@interface OrderGoodsCell : UITableViewCell

+ (instancetype)OrderGoodsCellWithTableView:(UITableView *)tableView;

@property (strong, nonatomic) OrderGoodsFrame *goodsFrame;
@end
