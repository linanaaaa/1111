//
//  AddressListCell.h
//  吾家超市
//
//  Created by iMac15 on 2016/11/16.
//  Copyright © 2016年 iMac15. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressModel.h"
#import "AddressListCellFrameModel.h"

typedef void(^EditAddress)(AddressModel *address);
typedef void(^DeleteAddress)(AddressModel *address);
typedef void(^DefaultAddress)(AddressModel *address);

@interface AddressListCell : UITableViewCell

@property (strong, nonatomic) AddressListCellFrameModel *frameModel;
@property (copy, nonatomic)   EditAddress editAddress;
@property (copy, nonatomic)   DeleteAddress deleteAddress;
@property (copy, nonatomic)   DefaultAddress defaultAddress;

+ (instancetype)addressListCellWithTableView:(UITableView *)tableView;
@end
