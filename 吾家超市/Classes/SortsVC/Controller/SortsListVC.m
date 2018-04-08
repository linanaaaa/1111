//
//  SortsListVC.m
//  吾家超市
//
//  Created by iMac15 on 2016/12/27.
//  Copyright © 2016年 iMac15. All rights reserved.
//

#import "SortsListVC.h"
#import "SortsListCell.h"
#import "GoodsModel.h"
#import "ProductDetailsVC.h"
#import "ShopCarVC.h"
#import "ScreenModelVC.h"
#import "CBHeaderChooseViewScrollView.h"

@interface SortsListVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate>
@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) NSMutableArray *dataArray;
@property (strong, nonatomic) UIView *placeHolder;
@property (strong, nonatomic) WJBadgeButton *goCarBtn;//购物车

@property (strong, nonatomic) UIView *topView;
@property (strong, nonatomic) UIButton *leftBtn;    //综合排序
@property (strong, nonatomic) UIButton *centerBtn;  //销量排序
@property (strong, nonatomic) UIButton *rightBtn;   //价格排序
@property (strong, nonatomic) UIButton *chooseBtn;   //价格排序

@property (strong, nonatomic) NSString *startPriceStr;  //起始价格
@property (strong, nonatomic) NSString *endPriceStr;  //结束价格

@property (strong, nonatomic) SortListParam *param;

@property (assign, nonatomic) NSInteger currentPage;
@property (strong, nonatomic) UIButton *backTopBtn;
@property (strong, nonatomic) UIButton *isGridBtn;

@property (strong, nonatomic) CBHeaderChooseViewScrollView *tagsView;
@end

@implementation SortsListVC

#pragma mark -获取二级分类
- (void)loadSortListType
{
    kWeakSelf
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_enter(group);
    [WJRequestTool get:kAutoCategoryUrl param:@{@"id":self.sortId} resultClass:[SortsLevelResult class] successBlock:^(SortsLevelResult *result)
     {
         if (!kObjectIsEmpty(result)) {
             NSMutableArray *array = [NSMutableArray arrayWithCapacity:result.t.children.count];
             for (SortsLevelModel *dataModel in result.t.children) {
                 if ([dataModel.isPullOff isEqualToString:@"0"]) {
                     [array addObject:dataModel.name];
                 }
             }
             
             if (!kArrayIsEmpty(array)) {
                 weakSelf.sortTagArray = array;
                 weakSelf.sortsHomeModel = result.t;
                 [weakSelf.tagsView setUpTitleArray:weakSelf.sortTagArray titleColor:nil titleSelectedColor:nil titleFontSize:0];
                 
                 NSString *nameStr = [weakSelf.sortTagArray objectAtIndex:0];
                 
                 for (SortsLevelModel *dataModel in weakSelf.sortsHomeModel.children) {
                     if ([dataModel.name isEqualToString:nameStr]) {
                         weakSelf.sortId = dataModel.id;
                     }
                 }
             }
         }
         dispatch_group_leave(group);
     } failure:^(NSError *error) {
         dispatch_group_leave(group);
     }];
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        [weakSelf loadData];
    });
}

#pragma mark -获取结果
- (SortListParam *)param
{
    if (!_param) {
        _param = [[SortListParam alloc] init];
    }
    return _param;
}

- (void)loadData
{
    kWeakSelf
    [self.collectionView setContentOffset:CGPointMake(0, 0) animated:YES];
    
    
    CGFloat top;
    UIColor *color;
    
    if (kArrayIsEmpty(self.sortTagArray)) {
        top = 0;
        color = [UIColor whiteColor];
        [self.topView addSplitLineWithFrame:CGRectMake(0, 0, kScreenW, kSplitLineHeight)];
    }
    else{
        top = 44;
        color = kGrayBackgroundColor;
    }
    
    self.topView.frame = CGRectMake(0, top, kScreenW, 44);
    self.topView.backgroundColor = color;
    
    CGFloat coll_top;
    if (kArrayIsEmpty(self.sortTagArray)) {
        coll_top = 44;
    }
    else{
        coll_top = 88;
    }
    weakSelf.collectionView.frame = CGRectMake(0, coll_top, kScreenW, kScreenH - kTabbarHeight - 10 - coll_top);
    
    self.currentPage = 1;
    self.param.id = self.sortId;    //三级分类
    self.param.pageNumber = @"1";
    self.param.pageSize = @"20";
    
    [WJRequestTool get:kCatePageUrl param:self.param resultClass:[GoodsModelResult class] successBlock:^(GoodsModelResult *result)
     {
         [weakSelf.dataArray removeAllObjects];
         
         for (GoodsModel *dataModel in result.t){
             [weakSelf.dataArray addObject:dataModel];
         }
         
         if (kArrayIsEmpty(weakSelf.dataArray)) {
             weakSelf.placeHolder.hidden = NO;
         }
         else{
             weakSelf.placeHolder.hidden = YES;
         }
         
         if (result.t.count < 20) {
             [weakSelf.collectionView.mj_footer endRefreshingWithNoMoreData];
         }
         else {
             weakSelf.currentPage++;
             [weakSelf.collectionView.mj_footer endRefreshing];
         }
         
         [weakSelf.collectionView reloadData];
         
     } failure:^(NSError *error) {
         [MBProgressHUD hideHUD];
     }];
}

#pragma mark -上拉加载更多数据
- (void)loadTheNextData
{
    kWeakSelf
    self.param.pageNumber = [NSString stringWithFormat:@"%ld",self.currentPage];
    self.param.pageSize = @"20";
    
    [WJRequestTool get:kCatePageUrl param:self.param resultClass:[GoodsModelResult class] successBlock:^(GoodsModelResult *result)
     {
         for (GoodsModel *dataModel in result.t){
             [weakSelf.dataArray addObject:dataModel];
         }
         
         if (kArrayIsEmpty(weakSelf.dataArray)) {
             weakSelf.placeHolder.hidden = NO;
         }
         else{
             weakSelf.placeHolder.hidden = YES;
         }
         
         if (result.t.count < 20) {
             [weakSelf.collectionView.mj_footer endRefreshingWithNoMoreData];
         }
         else {
             weakSelf.currentPage++;
             [weakSelf.collectionView.mj_footer endRefreshing];
         }
         
         [weakSelf.collectionView reloadData];
         
     } failure:^(NSError *error) {
         [weakSelf.collectionView.mj_footer endRefreshing];
     }];
}

#pragma mark -商品排序
- (void)btnClick:(UIButton *)sender
{
    if (sender.tag == 101) {    //综合默认排序
        self.param.orderType = @"";
        
        [self.leftBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [self.centerBtn setTitleColor:kGlobalTextColor forState:UIControlStateNormal];
        [self.rightBtn setTitleColor:kGlobalTextColor forState:UIControlStateNormal];
        [self.centerBtn setTitle:@"销量" forState:UIControlStateNormal];
        [self.rightBtn setTitle:@"价格" forState:UIControlStateNormal];
    }
    else if (sender.tag == 102){    //销售降
        self.param.orderType = @"salesDesc";
        
        [self.leftBtn setTitleColor:kGlobalTextColor forState:UIControlStateNormal];
        [self.centerBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [self.rightBtn setTitleColor:kGlobalTextColor forState:UIControlStateNormal];
        [self.centerBtn setTitle:@"销量↓" forState:UIControlStateNormal];
        [self.rightBtn setTitle:@"价格" forState:UIControlStateNormal];
    }
    else {
        [self.leftBtn setTitleColor:kGlobalTextColor forState:UIControlStateNormal];
        [self.centerBtn setTitleColor:kGlobalTextColor forState:UIControlStateNormal];
        [self.rightBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [self.centerBtn setTitle:@"销量" forState:UIControlStateNormal];
        
        sender.selected = !sender.selected;
        
        if (self.rightBtn.selected) {   //价格 升
            self.param.orderType = @"priceAsc";
            [self.rightBtn setTitle:@"价格↑" forState:UIControlStateNormal];
        }else{                           //价格 降
            self.param.orderType = @"priceDesc";
            [self.rightBtn setTitle:@"价格↓" forState:UIControlStateNormal];
        }
    }
    [self loadData];
}

#pragma mark -改变列表展示
- (void)isGridClick
{
    _isTypeGrid = !_isTypeGrid;
    
    [self.collectionView reloadData];
    
    if (_isTypeGrid) {
        self.isGridBtn.selected = YES;
    }
    else{
        self.isGridBtn.selected = NO;
    }
}

#pragma mark -筛选
- (void)chooseBtnClick
{
    kWeakSelf
    ScreenModelVC * vc=[[ScreenModelVC alloc]init];
    vc.screenId = self.sortId;
    
    vc.screenModelClick = ^(NSString *brandIdStr,NSString *startPrice, NSString *endPrice)
    {
        weakSelf.param.brandId = brandIdStr;
        weakSelf.param.startPrice = startPrice;
        weakSelf.param.endPrice = endPrice;
        
        [weakSelf loadData];
    };
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:^{
    }];
}

- (UIView *)topView
{
    if (!_topView) {
        _topView = [[UIView alloc] init];
        
        self.leftBtn = [_topView addButtonWithTitle:@"综合" target:self action:@selector(btnClick:)];
        self.leftBtn.frame = CGRectMake(10, 10, (kScreenW - 40)/4, 30);
        [self.leftBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        self.leftBtn.tag = 101;
        
        self.centerBtn = [_topView addButtonWithTitle:@"销量" target:self action:@selector(btnClick:)];
        self.centerBtn.frame = CGRectMake(CGRectGetMaxX(self.leftBtn.frame), 10, (kScreenW - 40)/4, 30);
        self.centerBtn.tag = 102;
        
        self.rightBtn = [_topView addButtonWithTitle:@"价格" target:self action:@selector(btnClick:)];
        self.rightBtn.frame = CGRectMake(CGRectGetMaxX(self.centerBtn.frame), 10, (kScreenW - 40)/4, 30);
        self.rightBtn.tag = 103;
        
        self.chooseBtn = [_topView addButtonWithTitle:@"筛选" target:self action:@selector(chooseBtnClick)];
        self.chooseBtn.frame = CGRectMake(CGRectGetMaxX(self.rightBtn.frame), 10, (kScreenW - 40)/4, 30);
        self.chooseBtn.tag = 104;
        
        [self.view addSubview:_topView];
    }
    return _topView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kGlobalBackgroundColor;
    
    UIView *rightItemView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 90, 40)];
    
    self.goCarBtn = [[WJBadgeButton alloc] init];
    self.goCarBtn.titleLabel.font = kFontSize(12.0);
    [self.goCarBtn setTitleColor:kGlobalTextColor forState:UIControlStateNormal];
    [self.goCarBtn setImage:[UIImage imageNamed:@"shopping"] forState:UIControlStateNormal];
    [self.goCarBtn addTarget:self action:@selector(shopCarClick) forControlEvents:UIControlEventTouchUpInside];
    self.goCarBtn.style = BadgeButtonStyleTopImage;
    [rightItemView addSubview:self.goCarBtn];
    self.goCarBtn.frame = CGRectMake(0, 5, 40, 35);
    
    self.isGridBtn = [rightItemView addButtonSelectedSetImage:@"classify" selected:@"classfiySelect" target:self action:@selector(isGridClick)];
    self.isGridBtn.frame = CGRectMake(50, 0, 40, 40);
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightItemView];
    
    [self.view addSubview:self.collectionView];
    
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadTheNextData)];
    footer.refreshingTitleHidden = NO;
    self.collectionView.mj_footer = footer;
    
    [self.view addSubview:self.placeHolder];
    
    [self loadSortListType];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateAmountSuccess:) name:@"UpdateCommodityAmountNotification" object:nil];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"UpdateShoppingCartAmountNotification" object:nil];
}

#pragma mark -商品数量
- (void)updateAmountSuccess:(NSNotification *)notice
{
    NSDictionary *userInfo = notice.userInfo;
    self.goCarBtn.badgeValue = userInfo[@"badgeValue"];
}

- (void)shopCarClick
{
    [self.navigationController pushViewController:[ShopCarVC new] animated:YES];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SortsListCell * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"SortsListCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    cell.sortsGoodsModel = self.dataArray[indexPath.row];
    cell.isGrid = self.isTypeGrid;
    
//    cell.addCarList = ^(GoodsModel *model)
//    {
//        WJLog(@"商品id: %@",model.id);
//        NSDictionary *param = @{@"id":model.id, @"quantity":@"1"};
//        
//        [WJRequestTool post:kAddCarUrl param:param successBlock:^(WJBaseRequestResult *result)
//         {
//             if ([result.type isEqualToString:@"success"] && [result.content isEqualToString:@"添加成功"]) {
//                 [MBProgressHUD showTextMessage:@"加入购物车成功!" hideAfter:1.0f];
//                 
//                 dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                     
//                     [[NSNotificationCenter defaultCenter] postNotificationName:@"UpdateShoppingCartAmountNotification" object:nil];
//                 });
//             }
//         } failure:^(NSError *error) {
//             
//         }];
//    };
    return cell;
}

#pragma mark -点击 item进入详情
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    GoodsModel *frameModel = self.dataArray[indexPath.row];
    
    ProductDetailsVC *vc = [[ProductDetailsVC alloc] init];
    vc.productId = frameModel.id;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = (kScreenW - 10) * 0.5;
    CGFloat height = width + 80;
    
    if (self.isTypeGrid) {
        return CGSizeMake(kScreenW - 20, 100);
    }
    else{
        return CGSizeMake(width, height);
    }
}

- (UICollectionView *)collectionView
{
    if (!_collectionView)
    {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        flowLayout.sectionInset = UIEdgeInsetsMake(10, 0, 0, 0);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 44, kScreenW, kScreenH - kTabbarHeight - 10 - 44) collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = kGrayBackgroundColor;
        _collectionView.showsVerticalScrollIndicator = NO;
        
        [_collectionView registerClass:[SortsListCell class] forCellWithReuseIdentifier:@"SortsListCell"];
    }
    return _collectionView;
}

- (NSMutableArray*)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

#pragma mark -分类展示
- (NSArray *)sortTagArray
{
    if (!_sortTagArray) {
        _sortTagArray = [NSArray array];
    }
    return _sortTagArray;
}

- (CBHeaderChooseViewScrollView *)tagsView
{
    if (!_tagsView) {
        kWeakSelf
        _tagsView = [[CBHeaderChooseViewScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 44)];
        _tagsView.backgroundColor = [UIColor whiteColor];
        _tagsView.btnChooseClickReturn = ^(NSInteger x, NSString *chooseStr)
        {
            NSLog(@"点击了第%ld个按钮---%@",x+1, chooseStr);
            
            for (SortsLevelModel *dataModel in weakSelf.sortsHomeModel.children) {
                if ([dataModel.name isEqualToString:chooseStr]) {
                    weakSelf.sortId = dataModel.id;
                }
            }
            
            [weakSelf loadData];
        };
        
        [self.view addSubview:_tagsView];
    }
    return _tagsView;
}

#pragma mark -无商品显示view
- (UIView *)placeHolder
{
    if (!_placeHolder) {
        
        CGFloat topHight;
        if (kArrayIsEmpty(self.sortTagArray)) {
            topHight = 0;
        }else{
            topHight = 88;
        }
        
        _placeHolder = [[UIView alloc] initWithFrame:CGRectMake(0, topHight, kScreenW, kScreenH)];
        _placeHolder.backgroundColor = kGrayBackgroundColor;
        _placeHolder.hidden = YES;
        
        UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenW - 100)/2, 200, 100, 100)];
        image.image = [UIImage imageNamed:@"wudingdan"];
        image.backgroundColor = [UIColor clearColor];
        [_placeHolder addSubview:image];
        
        UILabel *label = [_placeHolder addLabelWithText:@"没有合适的商品!" color:[UIColor grayColor]];
        label.frame = CGRectMake(0, CGRectGetMaxY(image.frame) + 10, kScreenW, 20);
        label.textAlignment = NSTextAlignmentCenter;
    }
    return _placeHolder;
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

#pragma mark -滚动位置 控制返回顶部按钮 隐藏/显示
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y > kScreenH) {
        self.backTopBtn.hidden = NO;
    }
    else {
        self.backTopBtn.hidden = YES;
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
