//
//  CouponListCell.h
//  吾家超市
//
//  Created by iMac15 on 2017/1/23.
//  Copyright © 2017年 iMac15. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CouponCellFrame.h"

@interface CouponListCell : UITableViewCell
+ (instancetype)couponListCellWithTalbeView:(UITableView *)tableView;
@property (strong, nonatomic) CouponCellFrame *frameModel;
@end
