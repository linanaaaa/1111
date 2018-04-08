//
//  SortsHomeVC.m
//  吾家网
//
//  Created by iMac15 on 2017/6/19.
//  Copyright © 2017年 iMac15. All rights reserved.
//

#import "SortsHomeVC.h"
#import "HomeAdModel.h"
#import "SDCycleScrollView.h"
#import "HomeHeaderViewCell.h"
#import "TwoAdCell.h"
#import "ProductDetailsVC.h"
#import "WebUrlVC.h"
#import "SortsListCell.h"
#import "SortsListVC.h"
#import "GoodsModel.h"

@interface SortsHomeVC ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,SDCycleScrollViewDelegate,UIWebViewDelegate,UIScrollViewDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (strong, nonatomic) NSMutableArray *iconHeaderArray;
@property (strong, nonatomic) NSMutableArray *textHeaderArray;

@property (strong, nonatomic) NSMutableArray *iconHeaderArray1;
@property (strong, nonatomic) NSMutableArray *textHeaderArray1;

@property (strong, nonatomic) NSMutableArray *iconHeaderArray2;
@property (strong, nonatomic) NSMutableArray *textHeaderArray2;

@property (strong, nonatomic) NSMutableArray *dataArray;

@property (strong, nonatomic) SDCycleScrollView *cycleScrollView;
@property (strong, nonatomic) NSMutableArray *adOneArray;

@property (strong, nonatomic) SortsListVC *listVC;
@property (strong, nonatomic) NSString *idLevelStr;
@property (assign, nonatomic) CGFloat adHeaderHight;
@end

@implementation SortsHomeVC

- (void)loadData
{    
    NSDictionary *adParam = [NSDictionary dictionary];
    NSDictionary *goodsParam = [NSDictionary dictionary];
    
    NSInteger currentPage = 1;
    
    if ([self.title isEqualToString:@"电器馆"]) {
        adParam = @{@"adPositionId":@"148"};
        goodsParam = @{@"id":self.sortHomeId,@"pageNumber":@(currentPage), @"pageSize":@"12"};
    }
    else if([self.title isEqualToString:@"服装馆"]){
        adParam = @{@"adPositionId":@"147"};
        goodsParam = @{@"id":self.sortHomeId,@"pageNumber":@(currentPage), @"pageSize":@"12"};
    }
    else{
        adParam = @{@"adPositionId":@"146"};
        goodsParam = @{@"id":self.sortHomeId,@"pageNumber":@(currentPage), @"pageSize":@"12"};
    }
    
    kWeakSelf
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_enter(group);
    [WJRequestTool get:kCatePageUrl param:goodsParam resultClass:[GoodsModelResult class] successBlock:^(GoodsModelResult *result)
     {
         WJLog(@"优质商品---");
         [weakSelf.dataArray removeAllObjects];
         if (!kObjectIsEmpty(result)) {
             for (GoodsModel *dataModel in result.t) {
                 [weakSelf.dataArray addObject:dataModel];
             }
         }
         
         dispatch_group_leave(group);
     } failure:^(NSError *error) {
         dispatch_group_leave(group);
     }];
    
    dispatch_group_enter(group);
    [WJRequestTool get:kAdPositionIdUrl param:adParam resultClass:[AdModelResult class] successBlock:^(AdModelResult *result)
     {
         WJLog(@"首部广告位---");
         if (!kObjectIsEmpty(result)) {
             
             weakSelf.adOneArray = [NSMutableArray arrayWithArray:result.t.ads];
             
             NSMutableArray *frameArray = [NSMutableArray arrayWithCapacity:result.t.ads.count];
             for (AdModel *dataModel in result.t.ads) {
                 AdModel *adModel = [[AdModel alloc] init];
                 adModel = dataModel;
                 
                 NSString *url = [NSString stringWithFormat:@"http://www.wujiaw.com%@",adModel.path];
                 [frameArray addObject:url];
             }
             weakSelf.cycleScrollView.imageURLStringsGroup = [NSArray arrayWithArray:frameArray];
         }
         
         dispatch_group_leave(group);
     } failure:^(NSError *error) {
         dispatch_group_leave(group);
     }];
    
    //返回主线程-刷新UI
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        [weakSelf.collectionView reloadData];
    });
}

#pragma mark -懒加载collectionView
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.minimumLineSpacing = 0;                      //定义 横向的间距
        layout.minimumInteritemSpacing = 0;                 //定义 纵向的间距
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0); //定义 边距
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH - 64) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = kGrayBackgroundColor;
        
        [_collectionView registerClass:[HomeHeaderViewCell class]
            forCellWithReuseIdentifier:@"homeHeaderViewCell"];
        
        [_collectionView registerClass:[SortsListCell class] forCellWithReuseIdentifier:@"SortsListCell"];
        
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ReusableView"];
        
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterView"];
        
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

#pragma mark ---UICollectionViewDataSource 数据源方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if(section == 1){
        return self.dataArray.count;
    }
    else {
        return 8;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        SortsListCell * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"SortsListCell" forIndexPath:indexPath];
        cell.backgroundColor = [UIColor whiteColor];
        cell.sortsGoodsModel = self.dataArray[indexPath.row];
        cell.isGrid = NO;
        
        cell.addCarList = ^(GoodsModel *model)
        {
            WJLog(@"商品id: %@",model.id);
            NSDictionary *param = @{@"id":model.id, @"quantity":@"1"};
            
            [WJRequestTool post:kAddCarUrl param:param successBlock:^(WJBaseRequestResult *result)
             {
                 [MBProgressHUD showTextMessage:@"加入购物车成功!" hideAfter:1.0f];
                 
                 dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                     
                     [[NSNotificationCenter defaultCenter] postNotificationName:@"UpdateShoppingCartAmountNotification" object:nil];
                 });
                 
             } failure:^(NSError *error) {
                 
             }];
        };
        return cell;
    }
    else {
        HomeHeaderViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"homeHeaderViewCell" forIndexPath:indexPath];
        cell.backgroundColor = [UIColor whiteColor];
        
        if ([self.title isEqualToString:@"吾家超市"]) {
            cell.imageName = self.iconHeaderArray[indexPath.row];
            cell.title = self.textHeaderArray[indexPath.row];
        }
        else if ([self.title isEqualToString:@"电器馆"]){
            cell.imageName = self.iconHeaderArray1[indexPath.row];
            cell.title = self.textHeaderArray1[indexPath.row];
        }
        else{
            cell.imageName = self.iconHeaderArray2[indexPath.row];
            cell.title = self.textHeaderArray2[indexPath.row];
        }
        return cell;
    }
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        GoodsModel *dataModel = self.dataArray[indexPath.row];
        
        ProductDetailsVC *productVC = [[ProductDetailsVC alloc] init];
        productVC.productId = dataModel.id;
        [self.navigationController pushViewController:productVC animated:YES];
    }
    
    else {
        
        self.listVC = [[SortsListVC alloc] init];
        
        if ([self.title isEqualToString:@"吾家超市"]) {
            
            NSString *nameStr = self.textHeaderArray[indexPath.row];
            
            if ([nameStr isEqualToString:@"食品饮料"]) {
                self.listVC.sortId = @"29928";
                self.listVC.title = @"食品饮料";
            }
            else if ([nameStr isEqualToString:@"粮油副食"]) {
                self.listVC.sortId = @"29975";
                self.listVC.title = @"粮油副食";
            }
            else if ([nameStr isEqualToString:@"母婴用品"]) {
                self.listVC.sortId = @"29993";
                self.listVC.title = @"母婴用品";
            }
            else if ([nameStr isEqualToString:@"中外名酒"]) {
                self.listVC.sortId = @"29285";
                self.listVC.title = @"中外名酒";
            }
            else if ([nameStr isEqualToString:@"美妆个护"]) {
                self.listVC.sortId = @"30493";
                self.listVC.title = @"美妆个护";
            }
            else if ([nameStr isEqualToString:@"家居家纺"]) {
                self.listVC.sortId = @"30678";
                self.listVC.title = @"家居家纺";
            }
            else if ([nameStr isEqualToString:@"清洁用品"]) {
                self.listVC.sortId = @"30535";
                self.listVC.title = @"清洁用品";
            }
            else {
                self.listVC.sortId = @"29982";
                self.listVC.title = @"地方特产";
            }
        }
        else if ([self.title isEqualToString:@"电器馆"]){
            
            NSString *nameStr = self.textHeaderArray1[indexPath.row];
            
            if ([nameStr isEqualToString:@"家用电器"]) {
                self.listVC.sortId = @"30952";
                self.listVC.title = @"家用电器";
            }
            else if ([nameStr isEqualToString:@"厨房电器"]) {
                self.listVC.sortId = @"30971";
                self.listVC.title = @"厨房电器";
            }
            else if ([nameStr isEqualToString:@"摄影摄像"]) {
                self.listVC.sortId = @"30859";
                self.listVC.title = @"摄影摄像";
            }
            else if ([nameStr isEqualToString:@"影音娱乐"]) {
                self.listVC.sortId = @"30904";
                self.listVC.title = @"影音娱乐";
            }
            else if ([nameStr isEqualToString:@"电脑产品"]) {
                self.listVC.sortId = @"30753";
                self.listVC.title = @"电脑产品";
            }
            else if ([nameStr isEqualToString:@"外设产品"]) {
                self.listVC.sortId = @"30779";
                self.listVC.title = @"外设产品";
            }
            else if ([nameStr isEqualToString:@"智能设备"]) {
                self.listVC.sortId = @"30891";
                self.listVC.title = @"智能设备";
            }
            else {
                self.listVC.sortId = @"30812";
                self.listVC.title = @"办公设备";
            }
        }
        else{
            
            NSString *nameStr = self.textHeaderArray2[indexPath.row];
            
            _textHeaderArray2 = [NSMutableArray arrayWithObjects:@"男装",@"女装",@"男鞋",@"女鞋",@"内衣",@"男包",@"女包",@"户外", nil];
            
            if ([nameStr isEqualToString:@"男装"]) {
                self.listVC.sortId = @"30592";
                self.listVC.title = @"男装";
            }
            else if ([nameStr isEqualToString:@"女装"]) {
                self.listVC.sortId = @"30557";
                self.listVC.title = @"女装";
            }
            else if ([nameStr isEqualToString:@"男鞋"]) {
                self.listVC.sortId = @"29346";
                self.listVC.title = @"男鞋";
            }
            else if ([nameStr isEqualToString:@"女鞋"]) {
                self.listVC.sortId = @"29319";
                self.listVC.title = @"女鞋";
            }
            else if ([nameStr isEqualToString:@"内衣"]) {
                self.listVC.sortId = @"30622";
                self.listVC.title = @"内衣";
            }
            else if ([nameStr isEqualToString:@"男包"]) {
                self.listVC.sortId = @"30420";
                self.listVC.title = @"男包";
            }
            else if ([nameStr isEqualToString:@"女包"]) {
                self.listVC.sortId = @"30409";
                self.listVC.title = @"女包";
            }
            else {
                self.listVC.sortId = @"30248";
                self.listVC.title = @"户外";
            }
        }
        
        [self.navigationController pushViewController:self.listVC animated:YES];
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = (kScreenW - 1) * 0.5;
    CGFloat height = width + 80;
    
    if (indexPath.section == 1) {
        return CGSizeMake(width, height);
    }
    else {
        CGFloat itemWH = kScreenW / 4;
        return CGSizeMake(itemWH, itemWH + 10);
    }
}

- (CGFloat )collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    if (section == 1){
        return 1;
    }
    return 0;
}

#pragma mark ---UICollectionViewDelegateFlowLayout
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (section == 0) {
        return UIEdgeInsetsMake(0, 0, 10, 0);   //设置cell上、左、下、右的间距
    }
    else{
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }
}


#pragma mark -头部显示的内容
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        if (indexPath.section == 0) {
            UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:
                                                    UICollectionElementKindSectionHeader withReuseIdentifier:@"ReusableView" forIndexPath:indexPath];
            
            [headerView addSubview:self.cycleScrollView];//头部广告栏
            return headerView;
        }
        else if(indexPath.section == 1){
            UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:
                                                    UICollectionElementKindSectionHeader withReuseIdentifier:@"ReusableView" forIndexPath:indexPath];
            UIView *backView = [[UIView alloc] init];
            backView.backgroundColor = [UIColor whiteColor];
            backView.frame = headerView.bounds;
            [headerView addSubview:backView];
            
            [backView addBottomSplitLine];
            
            UIImageView *image = [backView addImageViewWithImage:@""];
            image.frame = CGRectMake(10, 10, 75, 20);
            
            if ([self.title isEqualToString:@"电器馆"]) {
                image.image = [UIImage imageNamed:@"home_dianqi"];
            }
            else if ([self.title isEqualToString:@"服装馆"]){
                image.image = [UIImage imageNamed:@"home_fuzhuang"];
            }
            else{
                image.image = [UIImage imageNamed:@"home_chaoshi"];
            }
            
            return headerView;
        }
        else{
            return [UICollectionReusableView new];
        }
        
    }
    else{
        if (indexPath.section == 1) {
            UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:
                                                    UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterView" forIndexPath:indexPath];
            footerView.backgroundColor = kGrayBackgroundColor;
            
            UILabel *footerLab = [footerView addLabelWithText:@"亲,已经到底了" color:[UIColor grayColor]];
            footerLab.frame = footerView.bounds;
            footerLab.textAlignment = NSTextAlignmentCenter;
            
            return footerView;
        }
        return  nil;
    }
}

#pragma mark -设置headerView的宽高
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return CGSizeMake(kScreenW, self.adHeaderHight);
    }
    else if(section == 1){
        return CGSizeMake(kScreenW, 40);
    }
    else{
        return CGSizeMake(0, 0);
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    if (section == 1) {
        return CGSizeMake(kScreenW, 40);
    }
    else{
        return CGSizeMake(0, 0);
    }
}

#pragma mark -首部广告位-点击事件
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
//    ProductDetailsVC *productVC = [[ProductDetailsVC alloc] init];   //商品详情
//    AdModel *adModel =  [self.adOneArray objectAtIndex:index];
//    
//    if (!kStringIsEmpty(adModel.id)) {
//        productVC.productId = adModel.id;
//        [self.navigationController pushViewController:productVC animated:YES];
//    }
//    else{
//        WebUrlVC *webVC = [[WebUrlVC alloc] init];
//        webVC.urlStr = adModel.url;
//        [self.navigationController pushViewController:webVC animated:YES];
//    }
}

#pragma mark -首页广告位view
- (SDCycleScrollView *)cycleScrollView
{
    if (!_cycleScrollView) {
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kScreenW, self.adHeaderHight) delegate:self placeholderImage:[UIImage imageNamed:@"ad_bg"]];
        _cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
        _cycleScrollView.currentPageDotColor = [UIColor whiteColor];
    }
    return _cycleScrollView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (IS_IPHONE_6P_7P_8P) {
        self.adHeaderHight = 170;
    }else if(IS_IPHONE_X){
        self.adHeaderHight = 190;
    }else{
        self.adHeaderHight = 150;
    }
    
    [self loadData];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (NSMutableArray *)iconHeaderArray
{
    if (!_iconHeaderArray) {
        _iconHeaderArray = [NSMutableArray arrayWithObjects:@"yinliao",@"lianyou",@"muying",@"mingjiu",@"meizhuang",@"jujia",@"qingjie",@"techan", nil];
    }
    return _iconHeaderArray;
}

- (NSMutableArray *)textHeaderArray
{
    if (!_textHeaderArray) {
        _textHeaderArray = [NSMutableArray arrayWithObjects:@"食品饮料",@"粮油副食",@"母婴用品",@"中外名酒",@"美妆个护",@"家居家纺",@"清洁用品",@"地方特产", nil];
    }
    return _textHeaderArray;
}

- (NSMutableArray *)iconHeaderArray1
{
    if (!_iconHeaderArray1) {
        _iconHeaderArray1 = [NSMutableArray arrayWithObjects:@"jiadian",@"chufang",@"sheying",@"yingyin",@"diannao",@"waishe",@"zhineng",@"bangong", nil];
    }
    return _iconHeaderArray1;
}

- (NSMutableArray *)textHeaderArray1
{
    if (!_textHeaderArray1) {
        _textHeaderArray1 = [NSMutableArray arrayWithObjects:@"家用电器",@"厨房电器",@"摄影摄像",@"影音娱乐",@"电脑产品",@"外设产品",@"智能设备",@"办公设备", nil];
    }
    return _textHeaderArray1;
}

- (NSMutableArray *)iconHeaderArray2
{
    if (!_iconHeaderArray2) {
        _iconHeaderArray2 = [NSMutableArray arrayWithObjects:@"man",@"women",@"manshoes",@"womenshoues",@"neiyi",@"nanbao",@"nvbao",@"huwai", nil];
    }
    return _iconHeaderArray2;
}

- (NSMutableArray *)textHeaderArray2
{
    if (!_textHeaderArray2) {
        _textHeaderArray2 = [NSMutableArray arrayWithObjects:@"男装",@"女装",@"男鞋",@"女鞋",@"内衣",@"男包",@"女包",@"户外", nil];
    }
    return _textHeaderArray2;
}
@end
