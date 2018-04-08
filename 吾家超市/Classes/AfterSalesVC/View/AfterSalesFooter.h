//
//  AfterSalesFooter.h
//  吾家超市
//
//  Created by iMac15 on 2017/2/16.
//  Copyright © 2017年 iMac15. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderListModel.h"

typedef void(^EditAfterSales)(OrderListModel *orderDataModel);

@interface AfterSalesFooter : UITableViewHeaderFooterView

@property (strong, nonatomic) OrderListModel *dataModel;
@property (copy, nonatomic) EditAfterSales editAfterSales;

+ (instancetype)afterSaleFooterViewWithTableView:(UITableView *)tableView reuseIdentifier:(NSString *)identifier;
@end
