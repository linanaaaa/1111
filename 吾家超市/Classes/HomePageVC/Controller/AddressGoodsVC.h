//
//  AddressGoodsVC.h
//  吾家网
//
//  Created by iMac15 on 2017/6/15.
//  Copyright © 2017年 iMac15. All rights reserved.
//

#import "BaseVC.h"
#import "AddressModel.h"
#import "AddressGoodsFrame.h"
#import "AddressGoodsCell.h"

typedef void (^ChooseAddress)(NSString *address, NSString *code);

@interface AddressGoodsVC : BaseVC
@property (copy, nonatomic) ChooseAddress chooseAddress;

@end
