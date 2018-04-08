//
//  ProductGoodsView.h
//  吾家网
//
//  Created by iMac15 on 2017/7/3.
//  Copyright © 2017年 iMac15. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsModel.h"
#import "XRCarouselView.h"
#import "MJPhoto.h"
#import "MJPhotoBrowser.h"
#import "PPNumberButton.h"

@interface ProductGoodsView : UIView
@property (copy, nonatomic) void (^addressProduct)();

@property (strong, nonatomic) GoodsModel *dataGoodsModel;
@property (strong, nonatomic) UIImageView *productHideImage;
@property (strong, nonatomic) UILabel *addressLab;
@property (strong, nonatomic) PPNumberButton *numberButton;
@end
