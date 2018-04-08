//
//  AfterSalesHeader.h
//  吾家超市
//
//  Created by iMac15 on 2017/2/16.
//  Copyright © 2017年 iMac15. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderListModel.h"

@interface AfterSalesHeader : UITableViewHeaderFooterView

@property (strong, nonatomic) OrderListModel *dataModel;

+ (instancetype)afterSaleHeadeViewWithTableView:(UITableView *)tableView reuseIdentifier:(NSString *)identifier;

@end
