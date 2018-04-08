//
//  OrderListFooter.h
//  吾家超市
//
//  Created by iMac15 on 2016/11/24.
//  Copyright © 2016年 iMac15. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderListModel.h"

typedef void(^RemoveOrder)(OrderListModel *orderDataModel);
typedef void(^PayforOrder)(OrderListModel *orderDataModel);

@interface OrderListFooter : UITableViewHeaderFooterView

@property (strong, nonatomic) OrderListModel *dataModel;

@property (copy, nonatomic) RemoveOrder removeOrder;
@property (copy, nonatomic) PayforOrder payforOrder;

+ (instancetype)orderFooterViewWithTableView:(UITableView *)tableView reuseIdentifier:(NSString *)identifier;

@end
