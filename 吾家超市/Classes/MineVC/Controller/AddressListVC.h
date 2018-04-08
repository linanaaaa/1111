//
//  AddressListVC.h
//  吾家超市
//
//  Created by iMac15 on 2016/11/16.
//  Copyright © 2016年 iMac15. All rights reserved.
//

#import "BaseVC.h"
#import "AddressModel.h"
#import "AddressListCell.h"
#import "AddressListCellFrameModel.h"
#import "CreateNewAddressVC.h"

@interface AddressListVC : BaseVC
@property (copy, nonatomic) void (^changeAddress)(AddressModel *currentAddress);
@property (strong, nonatomic) NSString *addressType;
@end
