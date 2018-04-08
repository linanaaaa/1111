//
//  HomeAdModel.m
//  吾家超市
//
//  Created by iMac15 on 2016/12/14.
//  Copyright © 2016年 iMac15. All rights reserved.
//

#import "HomeAdModel.h"

@implementation HomeAdModel

@end

@implementation AdModel

@end

@implementation AdDataModel

+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"ads":@"AdModel"
             };
}
@end

@implementation AdModelResult

@end


/**
 *  优质商品
 */

@implementation HotGoodsProduct

@end

@implementation HotGoodsData

+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"productImages":@"HotGoodsProduct"
             };
}

- (NSString *)price
{
    return [NSString stringWithFormat:@"%.2f", _price.floatValue];
}

@end

@implementation HotGoodsResult

+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"t":@"HotGoodsData"
             };
}
@end
