//
//  AddressGoodsCell.h
//  吾家网
//
//  Created by iMac15 on 2017/6/15.
//  Copyright © 2017年 iMac15. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressGoodsFrame.h"

@interface AddressGoodsCell : UITableViewCell

@property (strong, nonatomic) AddressGoodsFrame *frameModel;

+ (instancetype)addressGoodsCellWithTableView:(UITableView *)tableView;

@end
