//
//  AfterSalesCell.h
//  吾家超市
//
//  Created by iMac15 on 2017/2/16.
//  Copyright © 2017年 iMac15. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AfterSalesModel.h"

typedef void(^SaleEditBtn)(AfterSalesModel *afterSalesModel);

@interface AfterSalesCell : UITableViewCell

+ (instancetype)AfterSalesCellWithTableView:(UITableView *)tableView;

@property (strong, nonatomic) AfterSalesModel *dataModel;

@property (copy,   nonatomic) SaleEditBtn saleEditBtn;

@end
