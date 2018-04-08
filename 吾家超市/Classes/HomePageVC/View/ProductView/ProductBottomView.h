//
//  ProductBottomView.h
//  吾家网
//
//  Created by iMac15 on 2017/6/30.
//  Copyright © 2017年 iMac15. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WJBadgeButton.h"

@interface ProductBottomView : UIView
@property (copy, nonatomic) void (^goToLogin)();        //去登陆
@property (copy, nonatomic) void (^goToShopCar)();      //去购物车
@property (copy, nonatomic) void (^addShopCar)(NSString *tags); //加入购物车/立即购买

@property (copy, nonatomic) NSString *productId;        //商品id
@property (strong, nonatomic) UIButton *collectionBtn;  //收藏按钮
@property (strong, nonatomic) UIButton *buyGoodsBtn;    //立即购买
@property (strong, nonatomic) UIButton *addCarBtn;      //加入购物车
@property (strong, nonatomic) WJBadgeButton *shopCarBtn;//购物车
@end
