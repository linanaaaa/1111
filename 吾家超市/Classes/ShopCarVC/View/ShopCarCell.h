//
//  ShopCarCell.h
//  吾家超市
//
//  Created by iMac15 on 2016/11/14.
//  Copyright © 2016年 iMac15. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsModel.h"
#import "ShopCarCellFrame.h"
#import "PPNumberButton.h"

@interface ShopCarCell : UITableViewCell

@property (strong, nonatomic) PPNumberButton *numberButton;
@property (strong, nonatomic) ShopCarCellFrame *frameModel;
@property (copy, nonatomic) void (^deleghtBtnClick)(ShopCarCellFrame *frameModel);
@property (copy, nonatomic) void (^selectBtnClick)(ShopCarCellFrame *frameModel);
+ (instancetype)ShopCarCellWithTableView:(UITableView *)tableView;
@end
