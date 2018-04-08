//
//  AddressModel.m
//  吾家超市
//
//  Created by iMac15 on 2016/11/16.
//  Copyright © 2016年 iMac15. All rights reserved.
//

#import "AddressModel.h"

@implementation addressAreaModel

@end

@implementation AddressModel

@end

@implementation AddressListResult

+ (NSDictionary *)objectClassInArray
{
    return @{
             @"t":@"AddressModel"
             };
}
@end

@implementation CreateAddressResult

@end



@implementation AddressChooseModel

@end

@implementation AddressChooseResult

+ (NSDictionary *)objectClassInArray
{
    return @{
             @"t":@"AddressChooseModel"
             };
}
@end
