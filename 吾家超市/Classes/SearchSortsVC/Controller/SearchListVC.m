//
//  SearchListVC.m
//  吾家超市
//
//  Created by iMac15 on 2016/11/10.
//  Copyright © 2016年 iMac15. All rights reserved.
//

#import "SearchListVC.h"
#import "GoodsModel.h"
#import "GoodsFrameModel.h"
#import "ProductDetailsVC.h"
#import "ShopCarVC.h"
#import "SearchListCell.h"
#import "SearchListFrame.h"
#import "SortsModel.h"

@interface SearchListVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) NSMutableArray *dataArray;

@property (assign, nonatomic) NSInteger currentPage;

@property (strong, nonatomic) UIView *placeHolder;

@property (strong, nonatomic) UIView *topView;
@property (strong, nonatomic) UIButton *typeBtn;
@property (strong, nonatomic) UIButton *priceAsc;
@property (strong, nonatomic) UIButton *saleDesc;

@property (strong, nonatomic) UIButton *backTopBtn;
@property (strong, nonatomic) SearchListTypeParam *param;
@end

@implementation SearchListVC

- (SearchListTypeParam *)param
{
    if (!_param) {
        _param = [[SearchListTypeParam alloc] init];
        _param.keyword = self.keyword;
        _param.orderType = @"";
    }
    return _param;
}

- (UIView *)topView
{
    if (!_topView) {
        _topView = [[UIView alloc] init];
        _topView.frame = CGRectMake(0, 0, kScreenW, 44);
        _topView.backgroundColor = [UIColor whiteColor];
        [_topView addTopSplitLine];
        [_topView addSplitLineWithFrame:CGRectMake(0, 43.5, kScreenW, kSplitLineHeight)];
        
        self.typeBtn = [_topView addButtonWithTitle:@"综合" target:self action:@selector(btnClick:)];
        self.typeBtn.frame = CGRectMake(10, 5, (kScreenW - 40)/3, 30);
        [self.typeBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        self.typeBtn.tag = 100;
        
        self.saleDesc = [_topView addButtonWithTitle:@"销量" target:self action:@selector(btnClick:)];
        self.saleDesc.frame = CGRectMake(CGRectGetMaxX(self.typeBtn.frame), 5, (kScreenW - 40)/3, 30);
        self.saleDesc.tag = 101;
        
        self.priceAsc = [_topView addButtonWithTitle:@"价格↑↓" target:self action:@selector(btnClick:)];
        self.priceAsc.frame = CGRectMake(CGRectGetMaxX(self.saleDesc.frame), 5, (kScreenW - 40)/3, 30);
        self.priceAsc.tag = 102;
    }
    return _topView;
}

- (void)btnClick:(UIButton *)sender
{
    self.param.keyword = self.keyword;
    
    if (sender.tag == 101) {
        [self.typeBtn setTitleColor:kGlobalTextColor forState:UIControlStateNormal];
        [self.priceAsc setTitleColor:kGlobalTextColor forState:UIControlStateNormal];
        [self.saleDesc setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [self.saleDesc setTitle:@"销量↓" forState:UIControlStateNormal];

        self.param.orderType = @"salesDesc";
    }
    else if (sender.tag == 102){
        sender.selected = !sender.selected;

        [self.typeBtn setTitleColor:kGlobalTextColor forState:UIControlStateNormal];
        [self.priceAsc setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [self.saleDesc setTitleColor:kGlobalTextColor forState:UIControlStateNormal];
        
        if (self.priceAsc.selected) {   //价格 升
            self.param.orderType = @"priceAsc";
            [self.priceAsc setTitle:@"价格↑" forState:UIControlStateNormal];
        }
        else{                           //价格 降
            self.param.orderType = @"priceDesc";
            [self.priceAsc setTitle:@"价格↓" forState:UIControlStateNormal];
        }
    }
    else {
        [self.typeBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [self.priceAsc setTitleColor:kGlobalTextColor forState:UIControlStateNormal];
        [self.saleDesc setTitleColor:kGlobalTextColor forState:UIControlStateNormal];
        [self.priceAsc setTitle:@"价格↑↓" forState:UIControlStateNormal];

        self.param.orderType = @"";
    }
    
    [self loadData];
}

#pragma mark -获取搜索结果
- (void)loadData
{
    kWeakSelf
    self.currentPage = 1;
    self.param.pageNumber = [NSString stringWithFormat:@"%ld",self.currentPage];
    self.param.pageSize = @"20";

    [WJRequestTool get:kSearchUrl param:self.param resultClass:[GoodsModelResult class] successBlock:^(GoodsModelResult *result)
     {
         if (!kObjectIsEmpty(result.t) && [result.type isEqualToString:@"success"]) {
             weakSelf.placeHolder.hidden = YES;

             [weakSelf.dataArray removeAllObjects];
             [weakSelf.dataArray addObjectsFromArray: [SearchListFrame frameModelArrayWithDataArray:result.t]];
             [weakSelf.collectionView reloadData];
             [weakSelf.collectionView setContentOffset:CGPointMake(0, 0) animated:YES];
             
             if (!(result.t.count < 20)) {
                 weakSelf.currentPage++;
             }
             else{
                 [weakSelf.collectionView.mj_footer endRefreshingWithNoMoreData];
             }
         }
         else{
             weakSelf.placeHolder.hidden = NO;
         }
     } failure:^(NSError *error) {
         
     }];
}

#pragma mark -上拉加载更多数据
- (void)loadNextData
{
    kWeakSelf
    self.param.pageNumber = [NSString stringWithFormat:@"%ld",self.currentPage];
    self.param.pageSize = @"20";
    
    [WJRequestTool get:kSearchUrl param:self.param resultClass:[GoodsModelResult class] successBlock:^(GoodsModelResult *result)
     {
         if (!kObjectIsEmpty(result.t) && [result.type isEqualToString:@"success"]) {
             [weakSelf.placeHolder setHidden:YES];

             [weakSelf.dataArray addObjectsFromArray: [SearchListFrame frameModelArrayWithDataArray:result.t]];
             
             if (result.t.count < 20) {
                 [weakSelf.collectionView.mj_footer endRefreshingWithNoMoreData];
             }
             else {
                 weakSelf.currentPage++;
                 [weakSelf.collectionView.mj_footer endRefreshing];
             }
             
             [weakSelf.collectionView reloadData];
         }
         else{
             [weakSelf.collectionView.mj_footer endRefreshing];
             [weakSelf.placeHolder setHidden:NO];
         }         
     } failure:^(NSError *error) {
         [weakSelf.collectionView.mj_footer endRefreshing];
     }];
}


#pragma mark -去购物车
- (void)shopCarClick
{
    [self.navigationController pushViewController:[ShopCarVC new] animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kGlobalBackgroundColor;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"购物车" style:UIBarButtonItemStylePlain target:self action:@selector(shopCarClick)];
    
    if (self.keyword.length > 0) {
        self.title = self.keyword;
    }
    else{
        self.title = @"搜索";
    }
    
    [self.view addSubview:self.topView];
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.placeHolder];
    
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadNextData)];
    footer.refreshingTitleHidden = YES;
    self.collectionView.mj_footer = footer;
    
    [self loadData];
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
    SearchListCell * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"searchListCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    cell.frameModel = self.dataArray[indexPath.row];
    
    /*  加入购物车点击事件
    cell.addCarList = ^(GoodsModel *model)
    {
        NSDictionary *param = @{@"id":model.id, @"quantity":@"1"};
        
        [WJRequestTool post:kAddCarUrl param:param successBlock:^(WJBaseRequestResult *result)
         {
             if ([result.type isEqualToString:@"success"] && [result.content isEqualToString:@"添加成功"]) {
                 [MBProgressHUD showTextMessage:@"加入购物车成功!" hideAfter:1.0f];
                 
                 dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                     
                     [[NSNotificationCenter defaultCenter] postNotificationName:@"UpdateShoppingCartAmountNotification" object:nil];
                 });
             }
         } failure:^(NSError *error) {
             
         }];
    };
    */
    return cell;
}

#pragma mark -点击 item进入详情
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    GoodsFrameModel *frameModel = self.dataArray[indexPath.row];
    
    ProductDetailsVC *vc = [[ProductDetailsVC alloc] init];
    vc.productId = frameModel.dataModel.id;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(kScreenW, 100);
}

- (UICollectionView *)collectionView
{
    if (!_collectionView)
    {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        flowLayout.sectionInset = UIEdgeInsetsMake(10, 0, 0, 0);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 44, kScreenW, kScreenH - kNavigationBarHeight - 44) collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = kGlobalBackgroundColor;
        _collectionView.showsVerticalScrollIndicator = NO;
        
        [_collectionView registerClass:[SearchListCell class] forCellWithReuseIdentifier:@"searchListCell"];
    }
    return _collectionView;
}

#pragma mark -无商品显示view
- (UIView *)placeHolder
{
    if (!_placeHolder) {
        _placeHolder = [[UIView alloc] initWithFrame:CGRectMake(0, 44, kScreenW, kScreenH - kNavigationBarHeight - 44)];
        _placeHolder.backgroundColor = kGrayBackgroundColor;
        _placeHolder.hidden = YES;
        
        UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenW - 100)/2, (kScreenH - 300)/2, 100, 100)];
        image.image = [UIImage imageNamed:@"wudingdan"];
        [_placeHolder addSubview:image];
        
        UILabel *label = [_placeHolder addLabelWithText:@"没有合适的商品!" color:[UIColor grayColor]];
        label.frame = CGRectMake(0, CGRectGetMaxY(image.frame) + 10, kScreenW, 20);
        label.textAlignment = NSTextAlignmentCenter;
    }
    return _placeHolder;
}

- (NSMutableArray*)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
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
    if (scrollView.contentOffset.y > kScreenH + 50) {
        self.backTopBtn.hidden = NO;
    }
    else {
        self.backTopBtn.hidden = YES;
    }
}

@end
