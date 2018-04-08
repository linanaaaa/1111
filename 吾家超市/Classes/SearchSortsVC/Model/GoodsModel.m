//
//  GoodsModel.m
//  吾家超市
//
//  Created by iMac15 on 2016/11/9.
//  Copyright © 2016年 iMac15. All rights reserved.
//

#import "GoodsModel.h"

@implementation GoodsProductImages

@end

@implementation GoodsModel

+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"productImages":@"GoodsProductImages",
             @"productMap":@"GoodsProductMap",
             @"specifications":@"GoodsProductSpecifications",
             @"specificationValues":@"GoodsProductMapSpecif"
             };
}

- (NSString *)price
{
    return [NSString stringWithFormat:@"%.2f", _price.floatValue];
}
@end

@implementation GoodsModelGoryProducts

+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"products":@"GoodsModel",
             };
}
@end

@implementation GoodsModelGory

@end

@implementation GoodsDataResult

+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"category1":@"GoodsModelGory",
             @"category2":@"GoodsModelGory",
             };
}
@end

@implementation GoodsModelNewResult

@end

@implementation GoodsModelResult

+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"t":@"GoodsModel"
             };
}
@end

/**
 *  我的收藏
 */
@implementation GoodsFavoriteModel

@end

@implementation GoodsFavoriteListResult

+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"t":@"GoodsFavoriteModel"
             };
}
@end

/**
 *  商品规格地图
 */

@implementation GoodsProductMap

+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"specificationValues" : @"GoodsProductMapSpecif"
             };
}

@end

@implementation GoodsProductMapSpecif

@end

@implementation GoodsProductSpecifications

+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"specificationValues" : @"GoodsProductMapSpecif"
             };
}

@end


/**
 *
 *  分类
 *
 */

@implementation SortsLevelModel

+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"children" : @"SortsLevelModel"
             };
}
@end

@implementation SortsLevelData

+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"children" : @"SortsLevelModel"
             };
}
@end

@implementation SortsLevelResult

@end



//商品详情

@implementation ProdectGoodsModel

@end

@implementation ProdectDetailResult

@end

//商品是否可售

@implementation AddressGoodsModel

@end

@implementation AddressGoodsResult

@end


//购物车

@implementation ShopCarProduct

+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"product" : @"GoodsModel"
             };
}
@end

@implementation ShopCarData

+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"cartItems":@"ShopCarProduct"
             };
}
@end

@implementation ShopCarResult

@end

//购物车商品 加减数量

@implementation ShopCarNumber

@end

@implementation ShopCarNumberResult

@end

//购物车商品 数量

@implementation ShopCartNum

@end

@implementation ShopCartNumResult

@end

@implementation SortListParam

@end
