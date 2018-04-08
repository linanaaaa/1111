//
//  AfterSalesVC.m
//  吾家超市
//
//  Created by iMac15 on 2017/2/15.
//  Copyright © 2017年 iMac15. All rights reserved.
//

#import "AfterSalesVC.h"
#import "AfterSalesModel.h"
#import "AfterSalesCell.h"
#import "SaleDetailVC.h"
#import "PutInSalesVC.h"

@interface AfterSalesVC ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) NSMutableArray *dataArray;
@property (strong, nonatomic) UIView *placeHolder;
@end

@implementation AfterSalesVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadData];
}

#pragma mark -加载退换货列表
- (void)loadData
{
    kWeakSelf
    
    [WJRequestTool get:kSalesListUrl param:nil resultClass:[AfterSaleListResult class] successBlock:^(AfterSaleListResult *result)
     {
         [weakSelf.dataArray removeAllObjects];
         
         [weakSelf.dataArray addObjectsFromArray:result.t];
         
         [weakSelf.tableView reloadData];
         
         if (kArrayIsEmpty(weakSelf.dataArray)) {
             weakSelf.placeHolder.hidden = NO;
         }
         
     } failure:^(NSError *error) {
         
     }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"退换货";
    [self.view addTopSplitLine];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    [self.view addSubview:self.placeHolder];
}

#pragma mark - UITabelViewDataSource

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
    AfterSalesCell *cell = [AfterSalesCell cellWithTableView:tableView reuseIdentifier:@"AfterSalesCell"];
    AfterSalesModel *model = self.dataArray[indexPath.row];
    cell.dataModel = model;
    
    cell.saleEditBtn = ^(AfterSalesModel *afterSalesModel){
        
        WJLog(@"编辑售后");
        PutInSalesVC *vc = [[PutInSalesVC alloc] init];
        vc.maxNumberStr = afterSalesModel.quantity;
        vc.orderItemId = afterSalesModel.id;
        [self.navigationController pushViewController:vc animated:YES];
    };
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 143;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AfterSalesModel *model = self.dataArray[indexPath.row];

    SaleDetailVC *vc = [[SaleDetailVC alloc] init];
    vc.salesDetailId = model.id;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark -无消息显示view
- (UIView *)placeHolder
{
    if (!_placeHolder) {
        _placeHolder = [[UIView alloc] initWithFrame:self.view.bounds];
        _placeHolder.backgroundColor = kGrayBackgroundColor;
        _placeHolder.hidden = YES;
        
        UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenW - 100)/2, (kScreenH - 300)/2, 100, 100)];
        image.image = [UIImage imageNamed:@"message"];
        [_placeHolder addSubview:image];
        
        UILabel *label = [_placeHolder addLabelWithText:@"未找到订单!" color:[UIColor grayColor]];
        label.frame = CGRectMake(0, CGRectGetMaxY(image.frame) + 10, kScreenW, 20);
        label.textAlignment = NSTextAlignmentCenter;
    }
    return _placeHolder;
}

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

@end
