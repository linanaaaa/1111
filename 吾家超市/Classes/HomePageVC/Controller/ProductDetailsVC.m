//
//  ProductDetailsVC.m
//  吾家超市
//
//  Created by HuaCapf on 2017/1/23.
//  Copyright © 2017年 iMac15. All rights reserved.
//

#import "ProductDetailsVC.h"

@interface ProductDetailsVC ()<UIWebViewDelegate,WKUIDelegate,WKNavigationDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;     //底部滚动scrollView

@property (strong, nonatomic) ProductGoodsView *goodsView;  //商品信息view
@property (strong, nonatomic) NSString *quantityStr;        //商品数量
@property (strong, nonatomic) NSString *areaIdStr;          //商品默认地址 id
@property (strong, nonatomic) NSString *defaultSkuid;       //商品加入购物车 id
@property (nonatomic, strong) LHCustomModalTransition *transition;  //地址选择

@property (nonatomic, strong) UIWebView *webView;           //网页webView
@property (strong, nonatomic) NSString *strUrls;
@property (strong, nonatomic) UIButton *picGoosBtn;
@property (strong, nonatomic) UIButton *typeGoosBtn;

@property (strong, nonatomic) ProductBottomView *bottomView; //底部view
@end

@implementation ProductDetailsVC

#pragma mark -商品是否可售
- (void)loadAddressGoods
{
    kWeakSelf
    NSDictionary *param = @{@"id":self.defaultSkuid, @"areaId":self.areaIdStr};
    [WJRequestTool get:kGetAreaLimitUrl param:param resultClass:[AddressGoodsResult class] successBlock:^(AddressGoodsResult *result)
     {
         if (kObjectIsEmpty(result.t) || [result.t.isSale isEqualToString:@"0"]) {
             weakSelf.bottomView.buyGoodsBtn.enabled = NO;
             [MBProgressHUD showTextMessage:@"当前商品库存不足!" hideAfter:2.0f];
         }else{
             weakSelf.bottomView.buyGoodsBtn.enabled = YES;
         }
     } failure:^(NSError *error) {
         
     }];
}

#pragma mark -加载商品详情
- (void)loadTheDetailGoods
{
    kWeakSelf
    [MBProgressHUD showLoadingMessage:@"" toView:self.scrollView];

    NSDictionary *param = @{@"productId":self.productId};
    [WJRequestTool get:kDetailUrl param:param resultClass:[ProdectDetailResult class] successBlock:^(ProdectDetailResult *result)
     {
         if (![result.t.isFav isEqualToString:@"0"]) {
             weakSelf.bottomView.collectionBtn.selected = YES;
         }
         weakSelf.goodsView.dataGoodsModel = result.t.product;
         weakSelf.strUrls = result.t.product.introduction;
         
         weakSelf.defaultSkuid = result.t.product.defaultSkuId;
         
         [weakSelf.webView loadHTMLString:[self reSizeImageWithHTMLHadHead:weakSelf.strUrls] baseURL:nil];
         
         [MBProgressHUD hideHUDForView:self.scrollView];
         
         [weakSelf loadAddressGoods];   //验证商品是否可售
     } failure:^(NSError *error) {
         
     }];
}

#pragma mark -加入购物车
- (void)addShopCar
{
    kWeakSelf
    self.bottomView.addCarBtn.enabled = NO;
    [[PurchaseCarAnimationTool shareTool]startAnimationandView:self.goodsView.productHideImage andRect:self.goodsView.productHideImage.frame andFinisnRect:CGPointMake(50, ScreenHeight-49) andFinishBlock:^(BOOL finisn){
        [PurchaseCarAnimationTool shakeAnimation:self.bottomView.shopCarBtn];
        
        NSDictionary *param = @{@"skuId":weakSelf.defaultSkuid, @"quantity":weakSelf.quantityStr};
        [WJRequestTool post:kAddCarUrl param:param resultClass:[JessonIDResult class] successBlock:^(JessonIDResult *result)
         {
             [[NSNotificationCenter defaultCenter] postNotificationName:@"UpdateShoppingCartAmountNotification" object:nil];
             [MBProgressHUD showTextMessage:@"加入购物车成功!"];
             weakSelf.bottomView.addCarBtn.enabled = YES;
         } failure:^(NSError *error) {
             weakSelf.bottomView.addCarBtn.enabled = YES;
         }];
    }];
}

#pragma mark -立即购买
- (void)buyGoods
{
    kWeakSelf
    [WJRequestTool get:kAutoCheckUrl param:nil successBlock:^(WJBaseRequestResult *result)
     {
         WJLog(@"立即下单");
         if ([result.type isEqualToString:@"success"] && [result.content isEqualToString:@"已登录"]) {
             if (kStringIsEmpty(weakSelf.areaIdStr)) {
                 [MBProgressHUD showTextMessage:@"请选择收货地址!"];
             }
             else{
                 NSDictionary *param = @{@"skuId":weakSelf.defaultSkuid, @"quantity":weakSelf.quantityStr};
                 [WJRequestTool post:kCarBuyNowCheckUrl param:param resultClass:[JessonIDResult class] successBlock:^(JessonIDResult *result)
                  {
                      if ([result.type isEqualToString:@"success"]) {
                          [weakSelf.navigationController pushViewController:[CreateOrederVC new] animated:YES];
                          [[NSNotificationCenter defaultCenter] postNotificationName:@"UpdateShoppingCartAmountNotification" object:nil];
                      }
                      else{
                          [MBProgressHUD showTextMessage:result.content hideAfter:3.0];
                      }
                  } failure:^(NSError *error) {
                      
                  }];
             }
         }
         else{
             [ZNGUser logout];
             [self.navigationController pushViewController:[LoginVC new] animated:YES];
         }
     } failure:^(NSError *error) {
         
     }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"商品详情";
    self.quantityStr = @"1";
    self.areaIdStr = @"52533";
    [self loadTheDetailGoods];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"UpdateShoppingCartAmountNotification" object:nil];
    
    [self.view addSubview:self.bottomView];
}

#pragma mark -底部滚动scrollView
- (UIScrollView *)scrollView
{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.frame = CGRectMake(0, 0, kScreenW, kScreenH - kNavigationBarHeight - 49);
        _scrollView.contentSize = CGSizeMake(0, 700);
        [self.view addSubview:_scrollView];
    }
    return _scrollView;
}

#pragma makr -商品View
- (ProductGoodsView *)goodsView
{
    if (!_goodsView) {
        _goodsView = [[ProductGoodsView alloc] init];
        _goodsView.backgroundColor = [UIColor whiteColor];
        _goodsView.frame = CGRectMake(0, 0, kScreenW, 580);
        [self.scrollView addSubview:_goodsView];
        
        self.picGoosBtn = [_goodsView addButtonWithTitle:@"商品介绍" target:self action:@selector(goodsBtnClik)];
        self.picGoosBtn.frame = CGRectMake((kScreenW - 210)/2, _goodsView.frame.size.height - 30, 100, 30);
        self.picGoosBtn.selected = YES;
        self.picGoosBtn.enabled = NO;
        [self.picGoosBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        
        UILabel *centerLab = [_goodsView addLabelWithText:@"|" color:[UIColor redColor]];
        centerLab.frame = CGRectMake(CGRectGetMaxX(self.picGoosBtn.frame), _goodsView.frame.size.height - 30, 5, 25);
        
        self.typeGoosBtn = [_goodsView addButtonWithTitle:@"规格参数" target:self action:@selector(goodsBtnClik)];
        self.typeGoosBtn.frame = CGRectMake(CGRectGetMaxX(self.picGoosBtn.frame) + 10, _goodsView.frame.size.height - 30, 100, 30);
        [self.typeGoosBtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        
        kWeakSelf
        _goodsView.numberButton.resultBlock = ^(NSInteger number, BOOL increaseStatus){
            weakSelf.quantityStr = [NSString stringWithFormat:@"%ld",number];
        };
        
        _goodsView.addressProduct = ^(){
            [weakSelf popAddressView];
        };
    }
    return _goodsView;
}

#pragma mark -商品介绍/规格参数
- (void)goodsBtnClik
{
    if (self.picGoosBtn.selected) {
        self.picGoosBtn.selected = NO;
        self.picGoosBtn.enabled = YES;
        [self.picGoosBtn setTitleColor:kGlobalTextColor forState:UIControlStateNormal];

        self.typeGoosBtn.selected = YES;
        self.typeGoosBtn.enabled = NO;
        [self.typeGoosBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        
        self.strUrls = self.goodsView.dataGoodsModel.introduction1;
    }
    else{
        self.picGoosBtn.selected = YES;
        self.picGoosBtn.enabled = NO;
        [self.picGoosBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        
        self.typeGoosBtn.selected = NO;
        self.typeGoosBtn.enabled = YES;
        [self.typeGoosBtn setTitleColor:kGlobalTextColor forState:UIControlStateNormal];
        self.strUrls = self.goodsView.dataGoodsModel.introduction;
    }
    [self.webView loadHTMLString:[self reSizeImageWithHTMLHadHead:self.strUrls] baseURL:nil];
}

#pragma mark -选择收货地址
- (void)popAddressView
{
    [self.view endEditing:YES];
    
    ChooseAddressVC *modalVC = [ChooseAddressVC new];
    self.transition = [[LHCustomModalTransition alloc]initWithModalViewController:modalVC];
    self.transition.dragable = YES;
    modalVC.transitioningDelegate = self.transition;
    modalVC.modalPresentationStyle = UIModalPresentationCustom;
    [self presentViewController:modalVC animated:YES completion:nil];
    
    kWeakSelf
    modalVC.chooseEditAdd = ^(NSString *address, NSString *code){
        weakSelf.goodsView.addressLab.text = [NSString stringWithFormat:@"送至: %@",address];
        weakSelf.areaIdStr = code;
        [weakSelf loadAddressGoods];
    };
}

#pragma mark -ToolBar-底部view
- (ProductBottomView *)bottomView
{
    if (!_bottomView) {
        _bottomView = [[ProductBottomView alloc] init];
        _bottomView.backgroundColor = [UIColor whiteColor];
        _bottomView.frame = CGRectMake(0, kScreenH - kNavigationBarHeight - 49, kScreenW, 49);
        _bottomView.productId = self.productId;
        
        kWeakSelf
        _bottomView.goToLogin = ^(){
            [weakSelf.navigationController pushViewController:[LoginVC new] animated:YES];
        };
        
        _bottomView.goToShopCar = ^(){
            [weakSelf.navigationController pushViewController:[ShopCarVC new] animated:YES];
        };
        
        _bottomView.addShopCar = ^(NSString *tags){
            if ([tags isEqualToString:@"12"]) {
                [weakSelf addShopCar];
            }
            else{
                [weakSelf buyGoods];
            }
        };
    }
    return _bottomView;
}

#pragma mark -图文详情-webView
- (UIWebView *)webView
{
    if (!_webView) {
        
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.goodsView.frame), self.scrollView.bounds.size.width, self.scrollView.bounds.size.height)];
        _webView.delegate = self;
        _webView.userInteractionEnabled = NO;
        _webView.scrollView.bounces = NO;
        _webView.backgroundColor = [UIColor whiteColor];
        [self.scrollView addSubview:_webView];
    }
    return _webView;
}

#pragma mark -webViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [MBProgressHUD showLoadingMessage:@"" toView:self.webView];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSString *script = [NSString stringWithFormat:
                        @"var script = document.createElement('script');"
                        "script.type = 'text/javascript';"
                        "script.text = \"function ResizeImages() { "
                        "var img;"
                        "var maxwidth=%f;"
                        "for(i=0;i <document.images.length;i++){"
                        "img = document.images[i];"
                        "if(img.width > maxwidth){"
                        "img.width = maxwidth;"
                        "}"
                        "}"
                        "}\";"
                        "document.getElementsByTagName('head')[0].appendChild(script);", kScreenW - 20];
    [webView stringByEvaluatingJavaScriptFromString: script];
    [webView stringByEvaluatingJavaScriptFromString:@"ResizeImages();"];
    
    CGFloat height = [[self.webView stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight"] floatValue];
    self.webView.frame = CGRectMake(0, CGRectGetMaxY(self.goodsView.frame), self.scrollView.bounds.size.width, height);
    self.scrollView.contentSize = CGSizeMake(0, height+CGRectGetMaxY(self.goodsView.frame));
    [MBProgressHUD hideHUDForView:self.webView];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [MBProgressHUD hideHUDForView:self.webView];
}

#pragma mark -html head添加屏幕宽度适配
- (NSString *)reSizeImageWithHTMLHadHead:(NSString *)html
{
    if(IS_IPHONE_6_7_8){
        return [self.strUrls stringByReplacingOccurrencesOfString:@"<head>" withString:@"<head><style>img{width:355px !important;}</style>"];   //355
    }
    else if(IS_IPHONE_6P_7P_8P){
        return [self.strUrls stringByReplacingOccurrencesOfString:@"<head>" withString:@"<head><style>img{width:400px !important;}</style>"];   //400
    }else{
        return [self.strUrls stringByReplacingOccurrencesOfString:@"<head>" withString:@"<head><style>img{width:305px !important;}</style>"];   //305
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
