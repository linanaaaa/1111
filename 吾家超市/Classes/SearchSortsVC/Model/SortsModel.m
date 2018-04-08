//
//  SortsModel.m
//  吾家超市
//
//  Created by iMac15 on 2016/12/5.
//  Copyright © 2016年 iMac15. All rights reserved.
//

#import "SortsModel.h"

@implementation SortsModel

+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"children":@"SortsModel"
             };
}
@end

@implementation SortsChildren

+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"children":@"SortsModel"
             };
}
@end


@implementation SortsData

+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"children":@"SortsChildren"
             };
}
@end


@implementation SortsModelResult

+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"t":@"SortsData"
             };
}

@end


@implementation SearchListTypeParam

@end
