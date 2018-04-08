//
//  FavoriteListVC.m
//  吾家超市
//
//  Created by iMac15 on 2016/12/9.
//  Copyright © 2016年 iMac15. All rights reserved.
//

#import "FavoriteListVC.h"
#import "GoodsModel.h"
#import "FavoriteFrameModel.h"
#import "FavoriteCell.h"

@interface FavoriteListVC ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) NSMutableArray *dataArray;
@property (strong, nonatomic) UIView *placeHolder;
@end

@implementation FavoriteListVC

#pragma mark -收藏商品
- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)loadFavorite
{
    kWeakSelf
    [WJRequestTool get:kPavoriteListUrl param:nil resultClass:[GoodsFavoriteListResult class] successBlock:^(GoodsFavoriteListResult *result)
     {
         if ([result.type isEqualToString:@"success"] && !kObjectIsEmpty(result.t)) {
             weakSelf.placeHolder.hidden = YES;
             [weakSelf.dataArray removeAllObjects];
             [weakSelf.dataArray addObjectsFromArray: [FavoriteFrameModel frameModelArrayWithDataArray:result.t]];
             [weakSelf.tableView reloadData];
         }
         else{
             weakSelf.placeHolder.hidden = NO;
         }
     } failure:^(NSError *error){
         
     }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的收藏";
    [self.view addTopSplitLine];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self loadFavorite];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FavoriteCell *cell = [FavoriteCell cellWithTableView:tableView reuseIdentifier:@"FavoriteCell"];
    cell.frameModel = self.dataArray[indexPath.row];
    
    cell.cleanFav = ^(GoodsFavoriteModel *goodsModel)
    {
        kWeakSelf
        NSDictionary *param = @{@"id":goodsModel.productId};
        [WJRequestTool post:kDeleteFavoriteUrl param:param successBlock:^(WJBaseRequestResult *result)
         {
             [MBProgressHUD showTextMessage:@"取消收藏成功!" hideAfter:2.0f];
             [weakSelf loadFavorite];
         } failure:^(NSError *error) {
             
         }];
    };
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FavoriteFrameModel *frameModel = self.dataArray[indexPath.row];
    return frameModel.cellHeight;
}

#pragma mark -无商品显示view
- (UIView *)placeHolder
{
    if (!_placeHolder) {
        _placeHolder = [[UIView alloc] initWithFrame:self.view.bounds];
        _placeHolder.backgroundColor = kGrayBackgroundColor;
        _placeHolder.hidden = YES;
        [self.view addSubview:_placeHolder];
        
        UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenW - 100)/2, (kScreenH - 300)/2, 100, 100)];
        image.image = [UIImage imageNamed:@"favorite"];
        [_placeHolder addSubview:image];
        
        UILabel *label = [_placeHolder addLabelWithText:@"您还没有任何收藏呢!" color:[UIColor grayColor]];
        label.frame = CGRectMake(0, CGRectGetMaxY(image.frame) + 10, kScreenW, 20);
        label.textAlignment = NSTextAlignmentCenter;
        
        UIButton *btn = [_placeHolder addButtonLineWithTitle:@"去首页逛逛" target:self action:@selector(goShoping)];
        btn.frame = CGRectMake((kScreenW - 120)/2, CGRectGetMaxY(label.frame) + 10, 120, 30);
        btn.layer.borderColor = kGlobalRedColor.CGColor;
        [btn setTitleColor:kGlobalRedColor forState:UIControlStateNormal];
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
@end
