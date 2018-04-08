//
//  ProductBottomView.m
//  吾家网
//
//  Created by iMac15 on 2017/6/30.
//  Copyright © 2017年 iMac15. All rights reserved.
//

#import "ProductBottomView.h"

@implementation ProductBottomView

- (instancetype)init
{
    if (self = [super init]){
        self.backgroundColor = [UIColor whiteColor];
        
        self.collectionBtn = [self addButtonSelectedSetImage:@"shoucang" selected:@"shoucangs" target:self action:@selector(collectiBtnClick:)];
        
        self.shopCarBtn = [[WJBadgeButton alloc] init];
        self.shopCarBtn.titleLabel.font = kFontSize(12.0);
        [self.shopCarBtn setTitleColor:kGlobalTextColor forState:UIControlStateNormal];
        [self.shopCarBtn setImage:[UIImage imageNamed:@"gouwuches"] forState:UIControlStateNormal];
        [self.shopCarBtn addTarget:self action:@selector(shopCarBtnClick) forControlEvents:UIControlEventTouchUpInside];
        self.shopCarBtn.style = BadgeButtonStyleTopImage;
        [self addSubview:self.shopCarBtn];
        
        self.addCarBtn = [self addButtonFilletWithTitle:@"加入购物车" target:self action:@selector(addCarBtnClick:)];
        self.addCarBtn.layer.cornerRadius = 0;
        [self.addCarBtn setBackgroundImage:[UIImage imageWithColor:kBtnHighlightedColor] forState:UIControlStateNormal];
        [self.addCarBtn setBackgroundImage:[UIImage imageWithColor:kColor(251, 189, 51)] forState:UIControlStateNormal];
        [self.addCarBtn setBackgroundImage:[UIImage imageWithColor:kColor(238, 220, 130)] forState:UIControlStateHighlighted];
        [self.addCarBtn setBackgroundImage:[UIImage imageWithColor:kColor(238, 220, 130)] forState:UIControlStateDisabled];
        self.addCarBtn.tag = 12;
        
        self.buyGoodsBtn = [self addButtonFilletWithTitle:@"立即购买" target:self action:@selector(addCarBtnClick:)];
        self.buyGoodsBtn.tag = 11;
        self.buyGoodsBtn.layer.cornerRadius = 0;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateAmountSuccess:) name:@"UpdateCommodityAmountNotification" object:nil];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.collectionBtn.frame = CGRectMake(0, 5, 44, 44);
    self.shopCarBtn.frame = CGRectMake(CGRectGetMaxX(self.collectionBtn.frame), 9, 44, 40);
    self.addCarBtn.frame = CGRectMake(CGRectGetMaxX(self.shopCarBtn.frame)+ 10, 0, (kScreenW - 98)*0.5, 49);
    self.buyGoodsBtn.frame = CGRectMake(CGRectGetMaxX(self.addCarBtn.frame), 0, (kScreenW - 98)*0.5, 49);
}

#pragma mark -商品id
- (void)setProductId:(NSString *)productId
{
    _productId = productId;
}

#pragma mark -加入购物车/立即购买
- (void)addCarBtnClick:(UIButton *)sender
{
    NSString *tags;
    if (sender.tag == 12) {
        tags = @"12";
    }
    else{
        tags = @"11";
    }
    
    if (self.addShopCar) {
        self.addShopCar(tags);
    }
}

#pragma mark -去购物车
- (void)shopCarBtnClick
{
    if (self.goToShopCar) {
        self.goToShopCar();
    }
}

#pragma mark -收藏/取消收藏
- (void)collectiBtnClick:(UIButton *)sender
{
    if ([ZNGUser userInfo].isOnline){
        sender.selected = !sender.selected;
        [self addFavorite];
    }
    else{
        if (self.goToLogin) {
            self.goToLogin();
        }
    }
}

#pragma mark -添加收藏/取消收藏
- (void)addFavorite
{
    kWeakSelf
    if (self.collectionBtn.selected == YES) {
        NSDictionary *param = @{@"id":_productId};  //添加收藏
        [WJRequestTool post:kAddFavoriteUrl param:param successBlock:^(WJBaseRequestResult *result)
         {
             weakSelf.collectionBtn.selected = YES;
             [MBProgressHUD showTextMessage:@"收藏成功!" hideAfter:1.0f];
         } failure:^(NSError *error) {
             
         }];
    }
    else{
        NSDictionary *param = @{@"id":_productId};  //取消收藏
        [WJRequestTool post:kDeleteFavoriteUrl param:param successBlock:^(WJBaseRequestResult *result)
         {
             weakSelf.collectionBtn.selected = NO;
             [MBProgressHUD showTextMessage:@"取消收藏成功!" hideAfter:1.0f];
         } failure:^(NSError *error) {
             
         }];
    }
}

#pragma mark -商品数量
- (void)updateAmountSuccess:(NSNotification *)notice
{
    NSDictionary *userInfo = notice.userInfo;
    self.shopCarBtn.badgeValue = userInfo[@"badgeValue"];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
