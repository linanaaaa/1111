//
//  OrderDetailsGoodsCell.h
//  吾家超市
//
//  Created by iMac15 on 2017/2/15.
//  Copyright © 2017年 iMac15. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderListModel.h"

typedef void(^OrderTrackBtn)(OrderItems *orderItemModel);
typedef void(^OrderSaleBtn)(OrderItems *orderItemModel, NSString *type);

@interface OrderDetailsGoodsCell : UITableViewCell

+ (instancetype)OrderDetailsGoodsCellWithTableView:(UITableView *)tableView;

@property (copy,   nonatomic) OrderTrackBtn orderTrackBtn;
@property (copy,   nonatomic) OrderSaleBtn orderSaleBtn;

@property (strong, nonatomic) OrderItems *orderItemModel;

@property (strong, nonatomic) NSString *shippingStatus;
@end
