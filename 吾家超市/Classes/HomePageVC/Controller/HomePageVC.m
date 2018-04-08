//
//  HomePageVC.m
//  吾家超市
//
//  Created by iMac15 on 2016/12/12.
//  Copyright © 2016年 iMac15. All rights reserved.
//

#import "HomePageVC.h"

@interface HomePageVC ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,SDCycleScrollViewDelegate,UIWebViewDelegate,UIScrollViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (strong, nonatomic) UIView *searchBarView;

@property (strong, nonatomic) NSMutableArray *adOneArray;       //首部广告位
@property (strong, nonatomic) NSMutableArray *adTwoArray;       //中间广告位
@property (strong, nonatomic) NSMutableArray *goodsArray;       //更多商品

@property (strong, nonatomic) NSArray *iconArray;               //分类菜单按钮图片
@property (strong, nonatomic) NSArray *titleArray;              //分类文字数组

@property (strong, nonatomic) SDCycleScrollView *cycleScrollView; //首页广告
@property (assign, nonatomic) NSInteger currentPage;
@property (strong, nonatomic) UIButton *backTopBtn;

@property (strong, nonatomic) NSString *isLoginStr;
@property (assign, nonatomic) CGFloat adHeaderHight;

@property (strong, nonatomic) NSString *indexPadesID;
@property (strong, nonatomic) NSArray *category1Array;
@property (strong, nonatomic) NSArray *category2Array;
@end

@implementation HomePageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.titleView = self.searchBarView;     //添加搜索栏
    [self.view addSubview:self.collectionView];             //添加collectionView
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
    self.collectionView.mj_header = header;
    
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    footer.refreshingTitleHidden = YES;
    self.collectionView.mj_footer = footer;
    
    [self loadData];
    
    if (![ZNGUser userInfo].isOnline) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"UpdateShoppingCartAmountNotification" object:nil];
    }
}

- (void)loadData
{
    kWeakSelf
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_enter(group);    //首部广告位 @"138"
    [WJRequestTool get:kAdPositionIdUrl param:@{@"adPositionId":@"30120"} resultClass:[AdModelResult class] successBlock:^(AdModelResult *result)
     {
         WJLog(@"首部广告位---");
         [weakSelf.adOneArray removeAllObjects];
         
         if (!kObjectIsEmpty(result)) {
             weakSelf.adOneArray = [NSMutableArray arrayWithCapacity:result.t.ads.count];
             for (AdModel *dataModel in result.t.ads) {
                 NSString *url = [NSString stringWithFormat:@"http://www.wujiaw.com%@",dataModel.path];
                 [weakSelf.adOneArray addObject:url];
             }
             weakSelf.cycleScrollView.imageURLStringsGroup = [NSArray arrayWithArray:weakSelf.adOneArray];
         }
         
         dispatch_group_leave(group);
     } failure:^(NSError *error) {
         dispatch_group_leave(group);
     }];

    
    dispatch_group_enter(group);    //热销商品
    self.currentPage = 1;
    [WJRequestTool get:kHomeGoodsUrl param:nil resultClass:[GoodsModelNewResult class] successBlock:^(GoodsModelNewResult *result)
     {
         WJLog(@"热销商品---");
         
         weakSelf.category1Array = result.t.category1;
         weakSelf.category2Array = result.t.category2;
         
         weakSelf.indexPadesID = result.t.category3.categoryId;
         [weakSelf.goodsArray removeAllObjects];
         if (!kObjectIsEmpty(result)) {
             [weakSelf.goodsArray addObjectsFromArray:[GoodsFrameModel frameModelArrayWithDataArray:result.t.category3.products]];
             weakSelf.currentPage++;
         }
         
         dispatch_group_leave(group);
     } failure:^(NSError *error) {
         dispatch_group_leave(group);
     }];
    
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{  //返回主线程-刷新UI
        
        [weakSelf.collectionView.mj_header endRefreshing];
        
        if (kArrayIsEmpty(weakSelf.goodsArray)) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakSelf loadData];
            });
        }else{
            [weakSelf.collectionView reloadData];
        }
        
        [MBProgressHUD hideHUDForView:self.collectionView];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"isLoginAuto" object:nil userInfo:@{@"isLoginYes":@"400"}];
    });
}

#pragma mark -加载更多数据
- (void)loadMoreData
{
    kWeakSelf
    [WJRequestTool get:kHoteGoodsUrl param:@{@"id":self.indexPadesID,
                                             @"pageNumber":@(self.currentPage),
                                             @"pageSize":@"20"} resultClass:[GoodsModelResult class] successBlock:^(GoodsModelResult *result)
     {
         [weakSelf.goodsArray addObjectsFromArray:[GoodsFrameModel frameModelArrayWithDataArray:result.t]];
         
         if (result.t.count < kPageSize) {
             weakSelf.collectionView.mj_footer = nil;
         }
         else {
             weakSelf.currentPage++;
         }
         
         [weakSelf.collectionView reloadData];
         [weakSelf.collectionView.mj_footer endRefreshing];
         
     } failure:^(NSError *error) {
         [weakSelf.collectionView.mj_footer endRefreshing];
     }];
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
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH - 49-64) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = kColor(238, 238, 238);
        
        [_collectionView registerClass:[HomeHeaderViewCell class]
            forCellWithReuseIdentifier:@"homeHeaderViewCell"];
        
        [_collectionView registerClass:[TwoAdCell class]
            forCellWithReuseIdentifier:@"twoAdCell"];
        
        [_collectionView registerClass:[FourAdCell class]
            forCellWithReuseIdentifier:@"fourAdCell"];
        
        [_collectionView registerClass:[GoodsHeaderCell class]
            forCellWithReuseIdentifier:@"goodsHeaderCell"];
        
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ReusableView"];
    }
    return _collectionView;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 4;
}

#pragma mark ---UICollectionViewDataSource 数据源方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 3) {
        return self.goodsArray.count;
    }
    else if (section == 2) {
        return 1;
    }
    else if(section == 1){
        return 4;
    }
    else {
        return self.iconArray.count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 3) {
        GoodsHeaderCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"goodsHeaderCell" forIndexPath:indexPath];
        cell.frameModel = self.goodsArray[indexPath.row];
        return cell;
    }
    else if (indexPath.section == 2) {
        FourAdCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"fourAdCell" forIndexPath:indexPath];
        return cell;
    }
    else if (indexPath.section == 1) {
        TwoAdCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"twoAdCell" forIndexPath:indexPath];
        cell.adTwoimageName = self.adTwoArray[indexPath.row];
        return cell;
    }
    else {
        HomeHeaderViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"homeHeaderViewCell" forIndexPath:indexPath];
        cell.imageName = self.iconArray[indexPath.row];
        cell.title = self.titleArray[indexPath.row];
        return cell;
    }
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 3) {
        ProductDetailsVC *productVC = [[ProductDetailsVC alloc] init];
        
        GoodsFrameModel *frameModel = self.goodsArray[indexPath.row];
        productVC.productId = frameModel.dataModel.id;
        [self.navigationController pushViewController:productVC animated:YES];
    }
    else if (indexPath.section == 2) {

    }
    else if (indexPath.section == 1) {
        
        SortsListVC *vc = [[SortsListVC alloc] init];
        vc.isTypeGrid = YES;

        if (indexPath.row == 0) {
            GoodsModelGory *model = [self.category2Array objectAtIndex:0];
            vc.sortId = model.categoryId;
            vc.title = @"电脑办公";
        }
        else if(indexPath.row == 1){
            GoodsModelGory *model = [self.category2Array objectAtIndex:1];
            vc.sortId = model.categoryId;
            vc.title = @"母婴用品";
        }
        else if(indexPath.row == 2){
            GoodsModelGory *model = [self.category2Array objectAtIndex:2];
            vc.sortId = model.categoryId;
            vc.title = @"汽车用品";
        }
        else {
            GoodsModelGory *model = [self.category2Array objectAtIndex:3];
            vc.sortId = model.categoryId;
            vc.title = @"家居家纺";
        }
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.section == 0){
        
        NSString *str = self.titleArray[indexPath.row];
        SortsHomeVC *lvc = [[SortsHomeVC alloc] init];
        
        if([str isEqualToString:@"吾家超市"]){
            lvc.title = @"吾家超市";
            GoodsModelGory *model = [self.category1Array objectAtIndex:0];
            lvc.sortHomeId = model.categoryId;
            [self.navigationController pushViewController:lvc animated:YES];
        }
        else if([str isEqualToString:@"服装馆"]){
            lvc.title = @"服装馆";
            GoodsModelGory *model = [self.category1Array objectAtIndex:1];
            lvc.sortHomeId = model.categoryId;
            [self.navigationController pushViewController:lvc animated:YES];
        }
        else if([str isEqualToString:@"电器馆"]){
            lvc.title = @"电器馆";
            GoodsModelGory *model = [self.category1Array objectAtIndex:2];
            lvc.sortHomeId = model.categoryId;
            [self.navigationController pushViewController:lvc animated:YES];
        }
        else if([str isEqualToString:@"珠宝首饰"]){
            SortsListVC *vc = [SortsListVC new];
            GoodsModelGory *model = [self.category1Array objectAtIndex:3];
            vc.sortId = model.categoryId;
            vc.title = @"珠宝首饰";
            [self.navigationController pushViewController:vc animated:YES];
        }
        else if([str isEqualToString:@"全部分类"]){
            SortsLevelVC *vc = [SortsLevelVC new];
            vc.idLevelStr = @"719";
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 3) {
        return CGSizeMake(kScreenW , 100);
    }
    else if (indexPath.section == 2) {
        return CGSizeMake(kScreenW, 60);
    }
    else  if (indexPath.section == 1) {
        return CGSizeMake((kScreenW - 1)/2, 70);
    }
    else {
        CGFloat itemWH = kScreenW / 5;
        return CGSizeMake(itemWH, itemWH + 10);
    }
}

#pragma mark ---UICollectionViewDelegateFlowLayout
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (section == 0 || section == 1 || section == 2) {
        return UIEdgeInsetsMake(0, 0, 10, 0);
    }
    else{
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }
}

- (CGFloat )collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    if (section == 1){
        return 1;
    }
    return 0;
}

#pragma mark -头部显示的内容
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:
                                                UICollectionElementKindSectionHeader withReuseIdentifier:@"ReusableView" forIndexPath:indexPath];
        
        [headerView addSubview:self.cycleScrollView];
        return headerView;
    }
    else{
        return [UICollectionReusableView new];
    }
}

#pragma mark -设置headerView的宽高
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return CGSizeMake(kScreenW, self.adHeaderHight);
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
- (CGFloat)adHeaderHight
{
    if (!_adHeaderHight) {
        
        if (IS_IPHONE_6P_7P_8P) {
            _adHeaderHight = 170;
        }else if(IS_IPHONE_X){
            _adHeaderHight = 170;
        }else{
            _adHeaderHight = 150;
        }
    }
    return _adHeaderHight;
}

- (SDCycleScrollView *)cycleScrollView
{
    if (!_cycleScrollView) {
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kScreenW, self.adHeaderHight) delegate:self placeholderImage:[UIImage imageNamed:@"ad_bg"]];
        _cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
        _cycleScrollView.currentPageDotColor = [UIColor whiteColor];
    }
    return _cycleScrollView;
}

#pragma mark -回到顶部
- (UIButton *)backTopBtn
{
    if (_backTopBtn == nil) {
        _backTopBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _backTopBtn.hidden = YES;
        _backTopBtn.frame = CGRectMake(kScreenW - 50, kScreenH - kTabbarHeight - 110, 40, 40);
        
        [_backTopBtn setImage:[UIImage imageNamed:@"back-to-top"] forState:UIControlStateNormal];
        [_backTopBtn addTarget:self action:@selector(backTopBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.backTopBtn];
        
    }
    return _backTopBtn;
}

- (void)backTopBtnDidClick:(UIButton *)button
{
    [self.collectionView setContentOffset:CGPointMake(0, 0) animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y > kScreenH) {
        self.backTopBtn.hidden = NO;
    }
    else {
        self.backTopBtn.hidden = YES;
    }
}

- (NSMutableArray *)goodsArray
{
    if (!_goodsArray) {
        _goodsArray = [NSMutableArray array];
    }
    return _goodsArray;
}

- (NSMutableArray *)adOneArray
{
    if (!_adOneArray) {
        _adOneArray = [NSMutableArray array];
    }
    return _adOneArray; 
}

- (NSMutableArray *)adTwoArray
{
    if (!_adTwoArray) {
        _adTwoArray = [NSMutableArray arrayWithObjects:@"home_hdiannao",@"home_hmuying",@"home_hqiche",@"home_hchongwu", nil];
    }
    return _adTwoArray;
}

#pragma mark 分类-图片数组
- (NSArray *)iconArray
{
    if (!_iconArray) {
        _iconArray = [NSArray arrayWithObjects:@"chaoshi_icon",@"clothes_icon",@"dianqi_icon",@"zhubao_icon",@"all_icon",nil];
    }
    return _iconArray;
}

#pragma mark 分类-文字数组
- (NSArray *)titleArray
{
    if (!_titleArray) {
        _titleArray = [NSArray arrayWithObjects: @"吾家超市", @"服装馆", @"电器馆", @"珠宝首饰", @"全部分类", nil];
    }
    return _titleArray;
}

- (NSArray *)category1Array
{
    if (!_category1Array) {
        _category1Array = [NSArray array];
    }
    return _category1Array;
}

- (NSArray *)category2Array
{
    if (!_category2Array) {
        _category2Array = [NSArray array];
    }
    return _category2Array;
}

#pragma mark -搜索栏
- (UIView *)searchBarView
{
    if (!_searchBarView) {
        _searchBarView = [[UIView alloc] init];
        _searchBarView.backgroundColor = [UIColor whiteColor];
        _searchBarView.frame = CGRectMake(0, 0, kScreenW, 44);
        
        UIImageView *logoImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"imglogo"]];
        logoImage.frame = CGRectMake(10, 11, 62, 18);
        [_searchBarView addSubview:logoImage];
        
        UIImageView *souchImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"search"]];
        souchImage.frame = CGRectMake(82, 6, kScreenW - 140, 30);
        souchImage.userInteractionEnabled = YES;
        [_searchBarView addSubview:souchImage];
        
        [souchImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(searchClick:)]];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(_searchBarView.frame.size.width - 45, 10, 22, 20);
        [btn setBackgroundImage:[UIImage imageNamed:@"messHomeicon"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(pushToReward) forControlEvents:UIControlEventTouchUpInside];
        [_searchBarView addSubview:btn];
    }
    return _searchBarView;
}

#pragma mark -消息
- (void)pushToReward
{
    if ([ZNGUser userInfo].isOnline){
        [self.navigationController pushViewController:[MessageVC new] animated:YES];
    }
    else{
        [self.navigationController pushViewController:[LoginVC new] animated:YES];
    }
}

#pragma mark -搜索
- (void)searchClick:(UITapGestureRecognizer *)gestureRecognizer
{
    [self.navigationController pushViewController:[SearchHistoryVC new] animated:YES];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.collectionView.mj_footer endRefreshing];
    [MBProgressHUD hideHUDForView:self.view];
}

@end
