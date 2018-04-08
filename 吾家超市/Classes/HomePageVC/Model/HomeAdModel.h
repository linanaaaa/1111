//
//  HomeAdModel.h
//  吾家超市
//
//  Created by iMac15 on 2016/12/14.
//  Copyright © 2016年 iMac15. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeAdModel : NSObject

@end

@interface AdModel : NSObject
@property (copy, nonatomic) NSString *id;
@property (copy, nonatomic) NSString *createDate;
@property (copy, nonatomic) NSString *modifyDate;
@property (copy, nonatomic) NSString *order;
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *type;
@property (copy, nonatomic) NSString *path;
@property (copy, nonatomic) NSString *beginDate;
@property (copy, nonatomic) NSString *endDate;
@property (copy, nonatomic) NSString *url;      //跳转url / 原生商品 id
@property (copy, nonatomic) NSString *urlType;  //判断 url跳转url / id跳转原生页面;
@end

@interface AdDataModel : NSObject
@property (copy, nonatomic) NSString *id;
@property (copy, nonatomic) NSString *createDate;
@property (copy, nonatomic) NSString *modifyDate;
@property (copy, nonatomic) NSString *name;

@property (strong, nonatomic) NSArray *ads;
@end


@interface AdModelResult : WJBaseRequestResult
@property (strong, nonatomic) AdDataModel *t;
@end


/**
 *  优质商品
 */

@interface HotGoodsProduct : NSObject
//@property (copy, nonatomic) NSString *title;
//@property (copy, nonatomic) NSString *source;
//@property (copy, nonatomic) NSString *large;
//@property (copy, nonatomic) NSString *medium;
//@property (copy, nonatomic) NSString *thumbnail;
//@property (copy, nonatomic) NSString *order;
//@property (copy, nonatomic) NSString *file;
//@property (copy, nonatomic) NSString *empty;

@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *order;
@property (copy, nonatomic) NSString *medium;
@end


@interface HotGoodsData : NSObject
@property (copy, nonatomic) NSString *id;
@property (copy, nonatomic) NSString *createDate;
@property (copy, nonatomic) NSString *modifyDate;
@property (copy, nonatomic) NSString *sn;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *fullName;
@property (copy, nonatomic) NSString *price;
@property (copy, nonatomic) NSString *specialPrice;
@property (copy, nonatomic) NSString *image;
@property (copy, nonatomic) NSString *rectangleImage;
@property (copy, nonatomic) NSString *unit;
@property (copy, nonatomic) NSString *isGift;
@property (copy, nonatomic) NSString *isUseCoupon;
@property (copy, nonatomic) NSString *memo;
@property (copy, nonatomic) NSString *keyword;
@property (copy, nonatomic) NSString *path;
@property (copy, nonatomic) NSString *thumbnail;
@property (strong, nonatomic) NSArray *productImages;
@end

@interface HotGoodsResult : WJBaseRequestResult
@property (strong, nonatomic) NSArray *t;
@end

