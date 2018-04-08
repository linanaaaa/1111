//
//  ProductGoodsView.m
//  吾家网
//
//  Created by iMac15 on 2017/7/3.
//  Copyright © 2017年 iMac15. All rights reserved.
//

#import "ProductGoodsView.h"

@interface ProductGoodsView ()<XRCarouselViewDelegate>
@property (strong, nonatomic) XRCarouselView *carouselView; //滚动视图
@property (strong, nonatomic) NSMutableArray *picImageArray;

@property (strong, nonatomic) UILabel *name;
@property (strong, nonatomic) UILabel *specialPrice;
@property (strong, nonatomic) UILabel *price;
@property (strong, nonatomic) UILabel *typeLab;
@property (strong, nonatomic) UILabel *expressFee;
@property (strong, nonatomic) UILabel *rebata;
@property (strong, nonatomic) UILabel *defaultExpress;
@property (strong, nonatomic) UILabel *statement;
@property (strong, nonatomic) UILabel *code;
@property (strong, nonatomic) UILabel *addRightLab;
@property (strong, nonatomic) UILabel *addLeftLab;
@property (strong, nonatomic) UIView *centerView;
@property (strong, nonatomic) UILabel *messageLab;
@end

@implementation ProductGoodsView

- (void)setDataGoodsModel:(GoodsModel *)dataGoodsModel
{
    _dataGoodsModel = dataGoodsModel;
    
    self.name.text = dataGoodsModel.name;
    self.price.text = [NSString stringWithFormat:@"¥ %@",dataGoodsModel.price];
    self.numberButton.hidden = NO;
    
    self.addressLab.text = @"默认送至: 北京海淀区三环到四环之间";
    self.addRightLab.text = @">";
    
    self.defaultExpress.text = @"快递:默认快递";
    self.statement.text = @"声明:此产品由吾家网提供服务";
    self.code.text = [NSString stringWithFormat:@"商品编号:%@",dataGoodsModel.sn];
    
    if (!kArrayIsEmpty(dataGoodsModel.productImages)) {
        for (GoodsProductImages *model in dataGoodsModel.productImages) {
            
            if ([model.source containsString:@"https:"]) {
                [self.picImageArray addObject:model.source];
            }
            else{
                [self.picImageArray addObject:[NSString stringWithFormat:@"%@%@",kServiceN1Url,model.source]];
            }
        }
    }
    else{
        [self.picImageArray addObject:[NSString stringWithFormat:@"%@%@",kServiceN1Url,dataGoodsModel.image]];
    }
    
    self.carouselView.imageArray = self.picImageArray;
    
    [self.productHideImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kServiceN7Url,dataGoodsModel.image]] placeholderImage:[UIImage imageNamed:@"details_bj"]];
    
}

- (instancetype)init
{
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:self.carouselView];
        
        self.name = [self addLabelWithText:@"" font:kFontSize(22.0)];
        self.name.numberOfLines = 2;
        self.name.textColor = [UIColor blackColor];
        
        self.price = [self addLabelWithText:@"" color:kGlobalRedColor];
        
        self.numberButton = [[PPNumberButton alloc] init];
        self.numberButton.shakeAnimation = YES;
        self.numberButton.editing = NO;
        self.numberButton.increaseImage = [UIImage imageNamed:@"increase_taobao"];
        self.numberButton.decreaseImage = [UIImage imageNamed:@"decrease_taobao"];
        [self addSubview:self.numberButton];
        
        self.addressLab = [self addLabelWithText:@""];
        self.addressLab.backgroundColor = [UIColor clearColor];
        self.addressLab.numberOfLines = 2;
        self.addressLab.userInteractionEnabled = YES;
        self.addressLab.textColor = [UIColor blackColor];
        [self.addressLab addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addressClick)]];
        
        self.addRightLab = [self addLabelWithText:@""];
        self.defaultExpress = [self addLabelWithText:@""];
        self.statement = [self addLabelWithText:@""];
        self.code = [self addLabelWithText:@""];
        
        self.centerView = [[UIView alloc] init];
        self.centerView.backgroundColor = kGrayBackgroundColor;
        [self addSubview:self.centerView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.carouselView.frame = CGRectMake(0, 0,kScreenW, 320);
    self.name.frame = CGRectMake(10, CGRectGetMaxY(self.carouselView.frame) + 10, kScreenW - 20, 40);
    self.price.frame = CGRectMake(20, CGRectGetMaxY(self.name.frame) + 10, (kScreenW - 20)/2, 30);
    self.numberButton.frame = CGRectMake(CGRectGetMaxX(self.price.frame), CGRectGetMaxY(self.name.frame) + 15, 80, 20);
    self.addressLab.frame = CGRectMake(10, CGRectGetMaxY(self.price.frame), kScreenW - 30, 40);
    self.addRightLab.frame = CGRectMake(kScreenW - 20, CGRectGetMaxY(self.price.frame) + 5, 10, 30);
    self.defaultExpress.frame = CGRectMake(10, CGRectGetMaxY(self.addressLab.frame), (kScreenW - 20)/3, 30);
    self.statement.frame = CGRectMake(10, CGRectGetMaxY(self.defaultExpress.frame), kScreenW - 20, 30);
    self.code.frame = CGRectMake(10, CGRectGetMaxY(self.statement.frame), kScreenW - 20, 30);
    self.centerView.frame = CGRectMake(0, CGRectGetMaxY(self.code.frame), kScreenW, 10);
}

#pragma mark -选择收货地址
- (void)addressClick
{
    if (self.addressProduct) {
        self.addressProduct();
    }
}

#pragma mark -商品大图滚动View
- (NSMutableArray *)picImageArray
{
    if (!_picImageArray) {
        _picImageArray = [NSMutableArray array];
    }
    return _picImageArray;
}

- (XRCarouselView *)carouselView
{
    if (!_carouselView) {
        _carouselView = [[XRCarouselView alloc] initWithFrame:CGRectMake(0, 0,kScreenW, 320)];
        _carouselView.placeholderImage = [UIImage imageNamed:@"details_bj"];
        _carouselView.delegate = self;
        [_carouselView setPageImage:[UIImage imageNamed:@"other"] andCurrentPageImage:[UIImage imageNamed:@"current"]];
        _carouselView.pagePosition = PositionBottomRight;
        [_carouselView setPageColor:[UIColor grayColor] andCurrentPageColor:[UIColor blackColor]];
        [_carouselView setDescribeTextColor:nil font:nil bgColor:nil];
        _carouselView.contentMode = UIViewContentModeScaleToFill;
        
        _productHideImage = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenW - 20)/2, 100, 20, 20)];
        _productHideImage.image = [UIImage imageNamed:@"details_bj"];
        _productHideImage.hidden = YES;
        [_carouselView addSubview:_productHideImage];
    }
    return _carouselView;
}

- (void)carouselView:(XRCarouselView *)carouselView clickImageAtIndex:(NSInteger)index
{
        NSMutableArray *photos = [NSMutableArray arrayWithCapacity:self.picImageArray.count];
        for (int i = 0; i< self.picImageArray.count; i++) {
            MJPhoto *photo = [[MJPhoto alloc] init];
            if ([self.picImageArray[i] isKindOfClass:[UIImage class]]) {
                photo.image = self.picImageArray[i];
            }
            else {
                NSString *url = [self.picImageArray[i] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                photo.url = [NSURL URLWithString:url];
            }
    
            [photos addObject:photo];
        }
        MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
        browser.currentPhotoIndex = index;
        browser.photos = photos;
        [browser show];
}

@end
