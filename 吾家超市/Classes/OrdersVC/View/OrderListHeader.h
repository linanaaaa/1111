//
//  OrderListHeader.h
//  吾家超市
//
//  Created by iMac15 on 2016/11/24.
//  Copyright © 2016年 iMac15. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderListModel.h"

@interface OrderListHeader : UITableViewHeaderFooterView

@property (strong, nonatomic) OrderListModel *dataModel;

+ (instancetype)orderHeadeViewWithTableView:(UITableView *)tableView reuseIdentifier:(NSString *)identifier;
@end
