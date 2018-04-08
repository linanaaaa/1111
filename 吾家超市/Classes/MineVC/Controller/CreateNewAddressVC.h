//
//  CreateNewAddressVC.h
//  吾家网
//
//  Created by iMac15 on 2017/6/17.
//  Copyright © 2017年 iMac15. All rights reserved.
//

#import "BaseVC.h"
#import "AddressModel.h"
#import "CreateOrederVC.h"
#import "LHCustomModalTransition.h"
#import "ChooseAddressVC.h"

@interface CreateNewAddressVC : BaseVC

@property (copy, nonatomic) void (^creatAddress)(AddressModel *currentAddress);

@property (strong, nonatomic) AddressModel *editAddressModel;
@property (strong, nonatomic) NSString *createAddressType;
@end
