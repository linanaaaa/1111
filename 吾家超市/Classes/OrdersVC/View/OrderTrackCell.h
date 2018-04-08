//
//  OrderTrackCell.h
//  吾家超市
//
//  Created by iMac15 on 2017/2/15.
//  Copyright © 2017年 iMac15. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderListModel.h"
#import "OrderTrackFrame.h"

@interface OrderTrackCell : UITableViewCell

+ (instancetype)OrderTrackCellWithTableView:(UITableView *)tableView;

@property (strong, nonatomic) OrderTrackFrame *frameModel;
@end
