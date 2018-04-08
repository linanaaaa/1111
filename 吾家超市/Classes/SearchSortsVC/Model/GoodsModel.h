//
//  GoodsModel.h
//  吾家超市
//
//  Created by iMac15 on 2016/11/9.
//  Copyright © 2016年 iMac15. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 {
 "id": 1239,
 "createDate": 1413436596000,
 "modifyDate": 1477726200000,
 "sn": "201410165712",
 "name": "股指期货名家在线辅导",
 "fullName": "股指期货名家在线辅导",
 "price": 16000,
 "specialPrice": 0,
 "image": "/upload/image/201410/1c2ca7da-aa5a-4f24-9945-91a10151a680-thumbnail.jpg",
 "rectangleImage": "/upload/image/201410/816ffa55-0441-4cfb-85ad-defc603f6255.jpg",
 "unit": null,
 "isGift": false,
 "isUseCoupon": false,
 "memo": "由股商投资股指期货投资专家针对近期市场运行情况视频在线教授投资技法，解答学员的各种投资疑难，使学员能够进一步领悟战法精髓，并对投资实战形成直接指导，在实战中使自己的投资水平稳步上升。",
 "keyword": "股票期货培训指导",
 "path": "/product/content/201410/1239.html",
 "thumbnail": "/upload/image/201410/1c2ca7da-aa5a-4f24-9945-91a10151a680-thumbnail.jpg"
 },
 */

@interface GoodsProductImages : NSObject
@property (copy, nonatomic) NSString *medium;
@property (copy, nonatomic) NSString *order;
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *source;
@end

/**
 * 商品规格地图
 */
@interface GoodsProductMap : NSObject
@property (copy, nonatomic) NSString *productId;
@property (strong, nonatomic) NSArray *specificationValues;
@end

@interface GoodsProductMapSpecif : NSObject
@property (copy, nonatomic) NSString *createDate;
@property (copy, nonatomic) NSString *id;
@property (copy, nonatomic) NSString *modifyDate;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *order;
@end

/**
 *  商品规格关联
 */

@interface GoodsProductSpecifications : NSObject
@property (copy, nonatomic) NSString *createDate;
@property (copy, nonatomic) NSString *id;
@property (copy, nonatomic) NSString *modifyDate;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *order;
@property (strong, nonatomic) NSArray *specificationValues;
@end

/**
 *  商品模型
 */

@interface GoodsModel : NSObject
@property (copy, nonatomic) NSString *defaultSkuId;
@property (copy, nonatomic) NSString *id;
@property (copy, nonatomic) NSString *point;
@property (copy, nonatomic) NSString *createDate;
@property (copy, nonatomic) NSString *modifyDate;
@property (copy, nonatomic) NSString *sn;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *fullName;
@property (copy, nonatomic) NSString *price;
@property (copy, nonatomic) NSString *specialPrice;
@property (copy, nonatomic) NSString *unit;
@property (copy, nonatomic) NSString *isGift;
@property (copy, nonatomic) NSString *isUseCoupon;
@property (copy, nonatomic) NSString *memo;
@property (copy, nonatomic) NSString *keyword;
@property (copy, nonatomic) NSString *path;
@property (copy, nonatomic) NSString *thumbnail;
@property (copy, nonatomic) NSString *image;

@property (copy, nonatomic) NSString *introduction;
@property (copy, nonatomic) NSString *introduction1;
@property (copy, nonatomic) NSString *introduction2;
@property (copy, nonatomic) NSString *introduction3;
@property (copy, nonatomic) NSString *introduction4;

@property (strong, nonatomic) NSArray *productImages;
@property (strong, nonatomic) NSArray *productMap;
@property (strong, nonatomic) NSArray *specifications;
@property (strong, nonatomic) NSArray *specificationValues;
@end

@interface GoodsModelGoryProducts : NSObject
@property (copy, nonatomic) NSString *categoryId;
@property (copy, nonatomic) NSString *pageSize;
@property (copy, nonatomic) NSString *pageNumber;
@property (strong, nonatomic) NSArray *products;
@end

@interface GoodsModelGory : NSObject
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *img;
@property (copy, nonatomic) NSString *categoryId;
@property (copy, nonatomic) NSString *type;
@end

@interface GoodsDataResult : NSObject
@property (copy, nonatomic) NSString *index_page;
@property (strong, nonatomic) NSArray *category1;
@property (strong, nonatomic) NSArray *category2;
@property (strong, nonatomic) GoodsModelGoryProducts *category3;
@end

@interface GoodsModelNewResult : WJBaseRequestResult
@property (strong, nonatomic) GoodsDataResult *t;
@end

@interface GoodsModelResult : WJBaseRequestResult
@property (strong, nonatomic) NSArray *t;
@end

/**
 *  我的收藏
 */
@interface GoodsFavoriteModel : NSObject
@property (copy, nonatomic) NSString *createDate;
@property (copy, nonatomic) NSString *createdDate;
@property (copy, nonatomic) NSString *id;
@property (copy, nonatomic) NSString *lastModifiedDate;
@property (copy, nonatomic) NSString *modifyDate;
@property (copy, nonatomic) NSString *product;
@property (copy, nonatomic) NSString *productId;
@property (copy, nonatomic) NSString *productImage;
@property (copy, nonatomic) NSString *productName;
@property (copy, nonatomic) NSString *productPrice;
@property (copy, nonatomic) NSString *productSku;
@property (copy, nonatomic) NSString *version;
@end

@interface GoodsFavoriteListResult : WJBaseRequestResult
@property (strong, nonatomic) NSArray *t;
@end

/**
 *
 *  分类
 *
 */

@interface SortsLevelModel : NSObject
@property (copy, nonatomic) NSString *createDate;
@property (copy, nonatomic) NSString *id;
@property (copy, nonatomic) NSString *isPullOff;
@property (copy, nonatomic) NSString *modifyDate;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *order;
@property (copy, nonatomic) NSString *treePath;

@property (strong, nonatomic) NSArray *children;
@end

@interface SortsLevelData : NSObject
@property (copy, nonatomic) NSString *createDate;
@property (copy, nonatomic) NSString *id;
@property (copy, nonatomic) NSString *isPullOff;
@property (copy, nonatomic) NSString *modifyDate;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *order;
@property (copy, nonatomic) NSString *treePath;

@property (strong, nonatomic) NSArray *children;
@end

@interface SortsLevelResult : WJBaseRequestResult
@property (strong, nonatomic) SortsLevelData *t;
@end

/**
 *  分类筛选 上传参数模型
 */
@interface SortListParam : NSObject
@property (copy, nonatomic) NSString *id;           //分类id
@property (copy, nonatomic) NSString *startPrice;   //起始价格
@property (copy, nonatomic) NSString *endPrice;     //结束价格
@property (copy, nonatomic) NSString *orderType;    //排序字段
@property (copy, nonatomic) NSString *brandId;      //品牌id
@property (copy, nonatomic) NSString *tagIds;       //标签id
@property (copy, nonatomic) NSString *pageNumber;   //当前页
@property (copy, nonatomic) NSString *pageSize;     //当前页-10个商品
@end

/**
 *  商品详情模型
 */

@interface ProdectGoodsModel : NSObject
@property (copy, nonatomic) NSString *isFav;
@property (strong, nonatomic) GoodsModel *product;
@end


@interface ProdectDetailResult : WJBaseRequestResult
@property (strong, nonatomic) ProdectGoodsModel *t;
@end

/**
 *  商品是否可售模型
 */
@interface AddressGoodsModel : NSObject
@property (copy, nonatomic) NSString *isSale;
@end

@interface AddressGoodsResult : WJBaseRequestResult
@property (strong, nonatomic) AddressGoodsModel *t;
@end



/**
 *  购物车模型
 */

@interface ShopCarProduct : NSObject
@property (strong, nonatomic) GoodsModel *product;
@property (copy,   nonatomic) NSString *createDate;
@property (copy,   nonatomic) NSString *id;
@property (copy,   nonatomic) NSString *modifyDate;
@property (copy,   nonatomic) NSString *quantity;
@property (copy,   nonatomic) NSString *cartItemState;
@end


@interface ShopCarData : NSObject
@property (strong, nonatomic) NSArray *cartItems;
@property (copy,   nonatomic) NSString *createDate;
@property (copy,   nonatomic) NSString *id;
@property (copy,   nonatomic) NSString *modifyDate;
@property (copy,   nonatomic) NSString *effectivePrice;
@property (copy,   nonatomic) NSString *discount;
@property (copy,   nonatomic) NSString *cartItemCount;
@property (copy,   nonatomic) NSString *price;
@property (copy,   nonatomic) NSString *quantity;
@end

@interface ShopCarResult : WJBaseRequestResult
@property (strong, nonatomic) ShopCarData *t;
@end


/**
 *  购物车 数量加减
 */

@interface ShopCarNumber : NSObject
@property (copy,   nonatomic) NSString *quantity;           //数量
@property (copy,   nonatomic) NSString *subtotal;
@property (copy,   nonatomic) NSString *effectivePrice;     //商品总价
@end

@interface ShopCarNumberResult : WJBaseRequestResult
@property (strong, nonatomic) ShopCarNumber *t;
@end


/**
 *  购物车 商品数量
 */

@interface ShopCartNum : NSObject
@property (copy,   nonatomic) NSString *num;
@end

@interface ShopCartNumResult : WJBaseRequestResult
@property (strong, nonatomic) ShopCartNum *t;
@end


