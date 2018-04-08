//
//  OrderListCell.h
//  吾家超市
//
//  Created by iMac15 on 2016/11/22.
//  Copyright © 2016年 iMac15. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderListFrame.h"

@interface OrderListCell : UITableViewCell

+ (instancetype)OrderListCellWithTableView:(UITableView *)tableView;

@property (strong, nonatomic) OrderItems *orderItemsModel;
@property (strong, nonatomic) OrderListFrame *frameModel;
@end
