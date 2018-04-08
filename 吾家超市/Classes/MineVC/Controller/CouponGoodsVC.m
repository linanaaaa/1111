//
//  CouponGoodsVC.m
//  吾家超市
//
//  Created by iMac15 on 2017/1/23.
//  Copyright © 2017年 iMac15. All rights reserved.
//

#import "CouponGoodsVC.h"
#import "SortsListCell.h"
#import "GoodsModel.h"
#import "ProductDetailsVC.h"

@interface CouponGoodsVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate>
@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) NSMutableArray *dataArray;
@property (strong, nonatomic) UIView *placeHolder;
@property (strong, nonatomic) UIButton *backTopBtn;
@property (assign, nonatomic) BOOL isGrid;
@end

@implementation CouponGoodsVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadData];
}

#pragma mark -优惠券可使用的商品
- (void)loadData
{
    kWeakSelf
    
    NSDictionary *param = @{@"couponId":self.couponIdStr};
    
    [WJRequestTool get:kCouponGoodsUrl param:param resultClass:[GoodsModelResult class] successBlock:^(GoodsModelResult *result)
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
         
         [weakSelf.collectionView reloadData];
         
     } failure:^(NSError *error){
         
     }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.titileStr;
    self.view.backgroundColor = kGlobalBackgroundColor;
    
    self.isGrid = NO;
    
    [self.view addSubview:self.collectionView];
    
    [self.view addSubview:self.placeHolder];

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
    cell.isGrid = self.isGrid;
    
    cell.addCarList = ^(GoodsModel *model)
    {
        WJLog(@"商品id: %@",model.id);
        NSDictionary *param = @{@"id":model.id, @"quantity":@"1"};
        
        [WJRequestTool post:kAddCarUrl param:param successBlock:^(WJBaseRequestResult *result)
         {
             [MBProgressHUD showTextMessage:@"加入购物车成功!" hideAfter:2.0];
         } failure:^(NSError *error) {
             
         }];
    };
    
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
    
    if (self.isGrid) {
        return CGSizeMake(width, height);
    }
    else{
        return CGSizeMake(kScreenW - 20, 100);
    }
}

- (UICollectionView *)collectionView
{
    if (!_collectionView)
    {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        flowLayout.sectionInset = UIEdgeInsetsMake(10, 0, 0, 0);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH -64) collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = kGlobalBackgroundColor;
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

#pragma mark -无商品显示view
- (UIView *)placeHolder
{
    if (!_placeHolder) {
        _placeHolder = [[UIView alloc] initWithFrame:self.view.bounds];
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
    if (scrollView.contentOffset.y > kScreenH + 50) {
        self.backTopBtn.hidden = NO;
    }
    else {
        self.backTopBtn.hidden = YES;
    }
}

@end
