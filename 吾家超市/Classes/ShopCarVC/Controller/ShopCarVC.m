//
//  ShopCarVC.m
//  吾家超市
//
//  Created by iMac15 on 2016/11/11.
//  Copyright © 2016年 iMac15. All rights reserved.
//

#import "ShopCarVC.h"
#import "ShopCarCell.h"
#import "ShopCarCellFrame.h"
#import "LoginVC.h"
#import "CreateOrederVC.h"
#import "ProductDetailsVC.h"
//收到发撒的方式腐败和圣诞节哈煽风点火健康
//萨达萨盛大的撒上大的

//asdasasdda
//23123123124
//123456789
@interface ShopCarVC ()<UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) NSMutableArray *dataArray;
@property (strong, nonatomic) UIImageView *noDataImage;
@property (strong, nonatomic) NSString *allPriceStr;       // 勾选商品价格
@property (strong, nonatomic) NSString *cartItemCount;     // 勾选商品数量
@property (strong, nonatomic) UIView *bottomView;          // toolbar
@property (strong, nonatomic) UILabel *allPriceLab;        // 商品全价
@property (strong, nonatomic) UIView *placeHolder;         // 无商品提示view
@end

@implementation ShopCarVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadData];
}

#pragma mark -获取购物车列表
- (void)loadData
{
    kWeakSelf
    [weakSelf.dataArray removeAllObjects];
    
    [WJRequestTool get:kCarlistUrl param:nil resultClass:[ShopCarResult class] successBlock:^(ShopCarResult *result)
     {
         if (!kObjectIsEmpty(result.t.cartItems) && [result.type isEqualToString:@"success"]) {
             weakSelf.bottomView.hidden = NO;
             weakSelf.placeHolder.hidden = YES;
             
             [weakSelf.dataArray addObjectsFromArray: [ShopCarCellFrame frameModelArrayWithDataArray:result.t.cartItems]];
             [weakSelf.tableView reloadData];
             
             weakSelf.allPriceStr = [NSString stringWithFormat:@"%@",result.t.effectivePrice];
             weakSelf.allPriceLab.text = [NSString stringWithFormat:@"合计: ¥%.2f",[weakSelf.allPriceStr floatValue]];
         }
         else{
             weakSelf.bottomView.hidden = YES;
             weakSelf.placeHolder.hidden = NO;
         }
         
         [[NSNotificationCenter defaultCenter] postNotificationName:@"UpdateShoppingCartAmountNotification" object:nil];
         
     } failure:^(NSError *error) {
         
     }];
}

#pragma mark -一键删除购物车
- (void)deleghtAllClick
{
    if (!kArrayIsEmpty(self.dataArray)) {
        kWeakSelf
        WJAlertView *alert = [[WJAlertView alloc] initWithTitle:@"确认删除购物车所有商品?" message:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert showWithButtonClickAction:^(NSInteger index)
         {
             if (index == 1)
             {
                 [WJRequestTool post:kCarAllDeleteUrl param:nil resultClass:[ShopCarResult class] successBlock:^(ShopCarResult *result)
                  {
                      [weakSelf.dataArray removeAllObjects];
                      [weakSelf.tableView reloadData];
                      
                      weakSelf.allPriceStr = @"";
                      weakSelf.allPriceLab.text = @"";
                      weakSelf.bottomView.hidden = YES;
                      weakSelf.placeHolder.hidden = NO;
                      
                      [[NSNotificationCenter defaultCenter] postNotificationName:@"UpdateShoppingCartAmountNotification" object:nil];
                  } failure:^(NSError *error) {
                      
                  }];
             }
         }];
    }
    else{
        [MBProgressHUD showTextMessage:@"购物车为空, 赶紧去购物吧!"];
    }
}

#pragma mark -立即下单  -判断是否登录
- (void)nextBtnClick
{
    kWeakSelf
    [WJRequestTool get:kAutoCheckUrl param:nil successBlock:^(WJBaseRequestResult *result)
     {
         WJLog(@"立即下单");
         if ([result.type isEqualToString:@"success"] && [result.content isEqualToString:@"已登录"]) {
             if (!kStringIsEmpty(weakSelf.cartItemCount) && ![weakSelf.cartItemCount isEqualToString:@"0"]) {
                 weakSelf.cartItemCount = @"";
                 [weakSelf.navigationController pushViewController:[CreateOrederVC new] animated:YES];
             }
             else{
                 [MBProgressHUD showTextMessage:@"请勾选想要购买的商品!"];
             }
         }
         else{
             [weakSelf.navigationController pushViewController:[LoginVC new] animated:YES];
             [MBProgressHUD showTextMessage:@"您还未登录,请登录您的账号!" hideAfter:2.0];
         }
     } failure:^(NSError *error) {
         
     }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"购物车";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"一键清空" style:UIBarButtonItemStylePlain target:self action:@selector(deleghtAllClick)];
    
    [self.view addSplitLineWithFrame:CGRectMake(0, 0, kScreenW, kSplitLineHeight)];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor redColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorColor = kGlobalLineColor;
    
    
    
    if (self.navigationController.viewControllers.count > 1) {
        self.tableView.frame = CGRectMake(0, 0, kScreenW, kScreenH - kNavigationBarHeight - 44);
    }
    else{
        self.tableView.frame = CGRectMake(0, 0, kScreenW, kScreenH - kNavigationBarHeight - 49 - 44);
        
         NSLog(@"self.tableView:%f,%f,%f,%f",self.tableView.frame.origin.x,self.tableView.frame.origin.y,self.tableView.frame.size.width,self.tableView.frame.size.height);
    }
    
    [self.view addSubview:self.placeHolder];
}

#pragma mark - UITabelViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShopCarCell *cell = [ShopCarCell cellWithTableView:tableView reuseIdentifier:@"ShopCarCell"];
    cell.frameModel = self.dataArray[indexPath.row];
    
    ShopCarCellFrame *cellFrameModel = self.dataArray[indexPath.row];
    kWeakSelf
    //加减 商品数量
    cell.numberButton.resultBlock = ^(NSInteger number, BOOL increaseStatus)
    {
        NSString *str = [NSString stringWithFormat:@"%ld",number];
        NSDictionary *param = @{
                                @"skuId":cellFrameModel.dataModel.product.defaultSkuId,
                                @"quantity":str,
                                };
        [WJRequestTool post:kCarEditUrl param:param resultClass:[ShopCarNumberResult class] successBlock:^(ShopCarNumberResult *result)
         {
             weakSelf.allPriceStr = [NSString stringWithFormat:@"%@",result.t.effectivePrice];
             weakSelf.allPriceLab.text = [NSString stringWithFormat:@"合计: ¥%.2f",[weakSelf.allPriceStr floatValue]];
             
             [[NSNotificationCenter defaultCenter] postNotificationName:@"UpdateShoppingCartAmountNotification" object:nil];
             
         } failure:^(NSError *error) {
             
         }];
    };
    
    //勾选购物车商品
    cell.selectBtnClick = ^(ShopCarCellFrame *frameModel)
    {
        NSDictionary *param = @{@"id":frameModel.dataModel.id};
        [WJRequestTool post:kCarCheckUrl param:param resultClass:[ShopCarResult class] successBlock:^(ShopCarResult *result)
         {
             weakSelf.allPriceLab.text = [NSString stringWithFormat:@"合计: ¥%.2f",[result.t.effectivePrice floatValue]];
             weakSelf.cartItemCount = result.t.cartItemCount;
         } failure:^(NSError *error) {
             
         }];
    };
    
    //删除 商品数量
    cell.deleghtBtnClick = ^(ShopCarCellFrame *frameModel)
    {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[weakSelf.dataArray indexOfObject:frameModel] inSection:0];
        
        WJAlertView *alert = [[WJAlertView alloc] initWithTitle:@"确认删除商品?" message:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        
        [alert showWithButtonClickAction:^(NSInteger index) {
            
            if (index == 1) {
                
                NSDictionary *param = @{@"skuId":frameModel.dataModel.product.defaultSkuId};
                [WJRequestTool post:kCarDeleteUrl param:param resultClass:[ShopCarResult class] successBlock:^(ShopCarResult *result)
                 {
                     [weakSelf.dataArray removeObjectAtIndex:indexPath.row];
                     [weakSelf.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                     
                     [[NSNotificationCenter defaultCenter] postNotificationName:@"UpdateShoppingCartAmountNotification" object:nil];
                     
                     if (!kArrayIsEmpty(weakSelf.dataArray)) {   //删除商品 返回 总价,优惠价
                         weakSelf.allPriceStr = [NSString stringWithFormat:@"%@",result.t.effectivePrice];
                         weakSelf.allPriceLab.text = [NSString stringWithFormat:@"合计: ¥%.2f",[weakSelf.allPriceStr floatValue]];
                         weakSelf.bottomView.hidden = NO;
                         weakSelf.placeHolder.hidden = YES;
                     }
                     else{
                         weakSelf.allPriceStr = @"";
                         weakSelf.allPriceLab.text = @"";
                         weakSelf.bottomView.hidden = YES;
                         weakSelf.placeHolder.hidden = NO;
                     }
                     
                 } failure:^(NSError *error) {
                     
                 }];
            }
        }];
    };
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    ShopCarCellFrame *frameModel = self.dataArray[indexPath.row];
//
//    ProductDetailsVC *vc = [ProductDetailsVC new];
//    vc.productId = frameModel.dataModel.product.id;
//    [self.navigationController pushViewController:vc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShopCarCellFrame *frameModel = self.dataArray[indexPath.row];
    return frameModel.cellHeight;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

- (NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (UIImageView *)noDataImage
{
    if (_noDataImage == nil) {
        _noDataImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"kong-0"]];
        _noDataImage.contentMode = UIViewContentModeCenter;
        _noDataImage.hidden = YES;
        [self.view addSubview:_noDataImage];
    }
    return _noDataImage;
}

- (NSString *)allPriceStr
{
    if (!_allPriceStr) {
        _allPriceStr = [NSString string];
    }
    return _allPriceStr;
}

- (NSString *)cartItemCount
{
    if (!_cartItemCount) {
        _cartItemCount = [NSString string];
    }
    return _cartItemCount;
}

#pragma mark -底部ToolBar
- (UIView *)bottomView
{
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
        _bottomView.backgroundColor = [UIColor whiteColor];
        _bottomView.hidden = YES;
        [self.view addSubview:_bottomView];
        
        if (self.navigationController.viewControllers.count > 1) {
            _bottomView.frame = CGRectMake(0, kScreenH - kNavigationBarHeight -44, kScreenW, 44);
        }
        else{
            _bottomView.frame = CGRectMake(0, kScreenH - kNavigationBarHeight -49 - 44, kScreenW, 44);
        }
        
        [_bottomView addTopSplitLine];
        
        _allPriceLab = [_bottomView addLabelWithText:@"" color:[UIColor redColor]];
        _allPriceLab.frame = CGRectMake(10, 0, kScreenW - 110, 44);
        
        UIButton *nextBtn = [_bottomView addButtonFilletWithTitle:@"立即下单" target:self action:@selector(nextBtnClick)];
        nextBtn.frame = CGRectMake(kScreenW - 90, 0, 90, 44);
        nextBtn.layer.cornerRadius = 0;
    }
    return _bottomView;
}

#pragma mark -无商品显示view
- (UIView *)placeHolder
{
    if (!_placeHolder) {
        _placeHolder = [[UIView alloc] initWithFrame:self.view.bounds];
        _placeHolder.backgroundColor = kGrayBackgroundColor;
        _placeHolder.hidden = NO;
        
        UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenW - 100)/2, (kScreenH - 300)/2, 100, 100)];
        image.image = [UIImage imageNamed:@"wudingdan"];
        [_placeHolder addSubview:image];
        NSLog(@"image:%f,%f,%f,%f",image.frame.origin.x,image.frame.origin.y,image.frame.size.width,image.frame.size.height);
        
        UILabel *label = [_placeHolder addLabelWithText:@"购物车为空!" color:[UIColor grayColor]];
        label.frame = CGRectMake(0, CGRectGetMaxY(image.frame) + 10, kScreenW, 20);
        label.textAlignment = NSTextAlignmentCenter;
        NSLog(@"label:%f,%f,%f,%f",label.frame.origin.x,label.frame.origin.y,label.frame.size.width,label.frame.size.height);
        
        UIButton *btn = [_placeHolder addButtonLineWithTitle:@"去首页逛逛" target:self action:@selector(goShoping)];
        btn.frame = CGRectMake((kScreenW - 120)/2, CGRectGetMaxY(label.frame) + 10, 120, 30);
        btn.layer.borderColor = kGlobalRedColor.CGColor;
        [btn setTitleColor:kGlobalRedColor forState:UIControlStateNormal];
        NSLog(@"btn:%f,%f,%f,%f",btn.frame.origin.x,btn.frame.origin.y,btn.frame.size.width,btn.frame.size.height);
    }
    return _placeHolder;
}

#pragma mark -去首页
- (void)goShoping
{
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    TabBarController *tabBarController = [[TabBarController alloc] init];
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:tabBarController];
    window.rootViewController = nav;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
