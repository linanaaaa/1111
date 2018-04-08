//
//  OrderAddressCell.h
//  吾家超市
//
//  Created by iMac15 on 2016/11/18.
//  Copyright © 2016年 iMac15. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderModel.h"
#import "OrderAddressFrame.h"

@interface OrderAddressCell : UITableViewCell

+ (instancetype)OrderAddressCellWithTableView:(UITableView *)tableView;

@property (strong, nonatomic) OrderAddressFrame *frameModel;
@property (strong, nonatomic) UIView *topLine;
@property (strong, nonatomic) UILabel *titleLab;
@end
