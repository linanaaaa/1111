//
//  OrderOptionsCell.h
//  吾家超市
//
//  Created by iMac15 on 2016/10/26.
//  Copyright © 2016年 iMac15. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, OrderOptionType){
    OrderOptionTypeWaitingForPayment = 2,   // 待付款
    OrderOptionTypeWaitingForDelivery,  // 待发货
    OrderOptionTypeWaitingForReceiving, // 待收货
    OrderOptionTypeAfterSales,          // 退换货
    OrderOptionTypeAllOrder             // 全部订单
};

typedef void(^OrderOptionCellClick)(OrderOptionType type);

@interface OrderOptionsCell : UITableViewCell

@property(nonatomic, copy)OrderOptionCellClick click;

@property(nonatomic, assign, readonly)OrderOptionType type;

@property (strong, nonatomic) NSArray * badgeValues;

//@property(nonatomic, strong)OrderCountModel *orderCount;

@property (strong, nonatomic) NSArray * btnTitles;

+ (instancetype)optionCellWithTableView:(UITableView *)tableView;

@end

