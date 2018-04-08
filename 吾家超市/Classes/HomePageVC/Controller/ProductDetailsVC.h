//
//  ProductDetailsVC.h
//  吾家超市
//
//  Created by HuaCapf on 2017/1/23.
//  Copyright © 2017年 iMac15. All rights reserved.
//

#import "BaseVC.h"
#import "ShopCarVC.h"
#import "CreateOrederVC.h"
#import "LoginVC.h"
#import "PurchaseCarAnimationTool.h"
#import "LHCustomModalTransition.h"
#import "AddressGoodsVC.h"
#import "TypeGoodsVC.h"
#import "ChooseAddressVC.h"
#import "ProductBottomView.h"
#import "ProductGoodsView.h"

@interface ProductDetailsVC : BaseVC
@property (copy, nonatomic) NSString *productId;        //商品id
@end
