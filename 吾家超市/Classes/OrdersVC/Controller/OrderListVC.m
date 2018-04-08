//
//  OrderListVC.m
//  吾家超市
//
//  Created by iMac15 on 2016/11/22.
//  Copyright © 2016年 iMac15. All rights reserved.
//

#import "OrderListVC.h"
#import "HMSegmentedControl.h"
#import "OrderListCell.h"
#import "OrderListFrame.h"
#import "OrderListModel.h"

#import "OrderDetailsVC.h"
#import "PayOrderVC.h"

#import "OrderListHeader.h"
#import "OrderListFooter.h"

#import "MineVC.h"

@interface OrderListVC ()<UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) HMSegmentedControl *segmentControl;       //头部 分段显示器
@property (strong, nonatomic) NSMutableArray *dataArray;                //总订单 数组
@property (strong, nonatomic) NSMutableArray *orderItemsArray;          //每个订单 商品数组
@property (strong, nonatomic) OrderListModel *orderListModel;

@property (strong, nonatomic) UILabel *snLab;
@property (strong, nonatomic) UILabel *stateLab;
@property (strong, nonatomic) UILabel *numberPriceLab;

@property (strong, nonatomic) OrderListParam *param;
@property (strong, nonatomic) NSString *orderSn;
@property (assign, nonatomic) NSInteger currentPage;

@property (strong, nonatomic) UIView *placeHolder;         // 无商品提示view
@end

@implementation OrderListVC

- (OrderListParam *)param
{
    if (!_param) {
        _param = [[OrderListParam alloc] init];
    }
    return _param;
}

#pragma mark -分段点击事件
- (void)segmentedControlChangedValue:(HMSegmentedControl *)segmentedControl
{
    NSLog(@"点击了第-%ld-个选项", (long)segmentedControl.selectedSegmentIndex);
    
    //    二、参数说明：pageNumber=第几页，
    //    shippingStatus=发货状态（可选值：unshipped：未发货，shipped：已发货，returned：已退货）
    //    paymentStatus==支付状态（可选值：unpaid=未支付，paid=已支付，refunded=已退款）
    //    orderStatus==订单状态（可选值：completed=已完成，cancelled=已取消）
    
    if ((long)segmentedControl.selectedSegmentIndex == 0) { //全部订单
        
        self.typeStr = @"0";
    }
    else if ((long)segmentedControl.selectedSegmentIndex == 1){ //待付款
        
        self.typeStr = @"1";
    }
    else if ((long)segmentedControl.selectedSegmentIndex == 2){ //待收货
        
        self.typeStr = @"2";
    }
    else if ((long)segmentedControl.selectedSegmentIndex == 3){ //已签收
        
        self.typeStr = @"3";
    }
    else {
        self.typeStr = @"4";
    }
    
    [self loadData];
}

#pragma mark -获取订单数据
- (void)loadData
{
    kWeakSelf
    [self.tableView setContentOffset:CGPointMake(0,0)animated:NO];
    self.segmentControl.userInteractionEnabled = NO;
    
    self.currentPage = 1;
    
    if ([self.typeStr isEqualToString:@"0"]) {
        self.param.pageNumber = [NSString stringWithFormat:@"%ld",self.currentPage];
        self.param.status = nil;
    }
    else if ([self.typeStr isEqualToString:@"1"]){
        self.param.pageNumber = [NSString stringWithFormat:@"%ld",self.currentPage];
        self.param.status = @"pendingPayment";
    }
    else if ([self.typeStr isEqualToString:@"2"]){
        self.param.pageNumber = [NSString stringWithFormat:@"%ld",self.currentPage];
        self.param.status = @"shipped";
    }
    else if ([self.typeStr isEqualToString:@"3"]){
        self.param.pageNumber = [NSString stringWithFormat:@"%ld",self.currentPage];
        self.param.status = @"received";
    }
    else if ([self.typeStr isEqualToString:@"4"]){
        self.param.pageNumber = [NSString stringWithFormat:@"%ld",self.currentPage];
        self.param.status = @"completed";
    }
    
    [WJRequestTool get:kOrderListUrl param:self.param resultClass:[OrderListResult class] successBlock:^(OrderListResult *result)
     {
         if ([result.type isEqualToString:@"success"] && !kObjectIsEmpty(result.t)) {
             weakSelf.placeHolder.hidden = YES;
             
             [weakSelf.dataArray removeAllObjects];
             [weakSelf.dataArray addObjectsFromArray:result.t];
             
             [OrderListFrame frameModelArrayWithDataArray:result.t];
             
             weakSelf.currentPage++;
             [weakSelf.tableView reloadData];
         }
         else{
             weakSelf.placeHolder.hidden = NO;
         }
         [weakSelf.tableView.mj_header endRefreshing];
         weakSelf.segmentControl.userInteractionEnabled = YES;
         
     } failure:^(NSError *error) {
         [weakSelf.tableView.mj_header endRefreshing];
     }];
}

#pragma mark -获取更多数据
- (void)loadMoreData
{
    kWeakSelf
    if ([self.typeStr isEqualToString:@"0"]) {
        self.param.pageNumber = [NSString stringWithFormat:@"%ld",self.currentPage];
        self.param.status = nil;
    }
    else if ([self.typeStr isEqualToString:@"1"]){
        self.param.pageNumber = [NSString stringWithFormat:@"%ld",self.currentPage];
        self.param.status = @"pendingPayment";
    }
    else if ([self.typeStr isEqualToString:@"2"]){
        self.param.pageNumber = [NSString stringWithFormat:@"%ld",self.currentPage];
        self.param.status = @"shipped";
    }
    else if ([self.typeStr isEqualToString:@"3"]){
        self.param.pageNumber = [NSString stringWithFormat:@"%ld",self.currentPage];
        self.param.status = @"received";
    }
    else if ([self.typeStr isEqualToString:@"4"]){
        self.param.pageNumber = [NSString stringWithFormat:@"%ld",self.currentPage];
        self.param.status = @"completed";
    }
    
    [WJRequestTool get:kOrderListUrl param:self.param resultClass:[OrderListResult class] successBlock:^(OrderListResult *result)
     {
         [weakSelf.dataArray addObjectsFromArray:result.t];
         
         [OrderListFrame frameModelArrayWithDataArray:result.t];
         
         if (result.t.count < kPageSize) {
             [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
         }
         else {
             weakSelf.currentPage++;
             [weakSelf.tableView.mj_footer endRefreshing];
         }
         [weakSelf.tableView reloadData];
         
     } failure:^(NSError *error) {
         [weakSelf.tableView.mj_footer endRefreshing];
     }];
}

- (void)loadTheRemoveOrder
{
    kWeakSelf
    
    NSDictionary *param = @{@"orderSn":self.orderSn};
    
    [WJRequestTool post:kCancelOrderUrl param:param successBlock:^(WJBaseRequestResult *result)
     {
         [weakSelf.dataArray enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(OrderListModel *orderDataModel, NSUInteger idx, BOOL * _Nonnull stop) {
             if ([orderDataModel.sn isEqualToString:weakSelf.orderSn]) {
                 [weakSelf.dataArray removeObject:orderDataModel];
             }
         }];
         
         [weakSelf.tableView reloadData];
         
     } failure:^(NSError *error) {
         
     }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的订单";
    
    [self.view addSubview:self.segmentControl];
    
    self.tableView.frame = CGRectMake(0, 44, kScreenW, kScreenH - 44- kNavigationBarHeight);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorColor = kGlobalLineColor;
    self.tableView.backgroundColor = kGlobalBackgroundColor;
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
    self.tableView.mj_header = header;
    [self.tableView.mj_header beginRefreshing];
    
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    footer.refreshingTitleHidden = YES;
    self.tableView.mj_footer = footer;
}

#pragma mark - UITabelViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    OrderListModel *model = self.dataArray[section];
    
    return [model.orderItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderListCell *cell = [OrderListCell cellWithTableView:tableView reuseIdentifier:@"OrderListCell"];
    OrderListModel *model = self.dataArray[indexPath.section];
    cell.orderItemsModel =  model.orderItems[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    OrderListHeader *headerView = [OrderListHeader orderHeadeViewWithTableView:tableView reuseIdentifier:@"OrderListHeader"];
    headerView.dataModel = self.dataArray[section];
    return headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    kWeakSelf
    OrderListFooter *footerView = [OrderListFooter orderFooterViewWithTableView:tableView reuseIdentifier:@"OrderListFooter"];
    footerView.dataModel = self.dataArray[section];
    
    footerView.removeOrder = ^(OrderListModel *orderDataModel)
    {
        WJLog(@"确定取消 %@ 订单",orderDataModel.sn);
        weakSelf.orderSn = orderDataModel.sn;
        [weakSelf loadTheRemoveOrder];
    };
    
    footerView.payforOrder = ^(OrderListModel *orderDataModel)
    {
        WJLog(@"去支付订单号:%@",orderDataModel.sn);
        PayOrderVC *vc = [[PayOrderVC alloc] init];
        vc.payNumberStr = orderDataModel.sn;
        vc.payPriceStr = orderDataModel.amountPayable;
        vc.addressStr = [NSString stringWithFormat:@"%@%@", orderDataModel.areaName, orderDataModel.address];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    
    return footerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 54;
}

- (CGFloat)tableView:( UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderListModel *model = self.dataArray[indexPath.section];
    
    OrderDetailsVC *vc = [[OrderDetailsVC alloc] init];
    vc.orderSN = model.sn;
    vc.titleStr = model.orderStatusShow;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark -去掉 header footer 粘性
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == self.tableView){
        
        UITableView *tableview = (UITableView *)scrollView;
        CGFloat sectionHeaderHeight = 54;
        CGFloat sectionFooterHeight = 44;
        CGFloat offsetY = tableview.contentOffset.y;
        
        if (offsetY >= 0 && offsetY <= sectionHeaderHeight){
            
            tableview.contentInset = UIEdgeInsetsMake(-offsetY, 0, -sectionFooterHeight, 0);
            
        }else if (offsetY >= sectionHeaderHeight && offsetY <= tableview.contentSize.height - tableview.frame.size.height - sectionFooterHeight){
            
            tableview.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, -sectionFooterHeight, 0);
            
        }else if (offsetY >= tableview.contentSize.height - tableview.frame.size.height - sectionFooterHeight && offsetY <= tableview.contentSize.height - tableview.frame.size.height){
            
            tableview.contentInset = UIEdgeInsetsMake(-offsetY, 0, -(tableview.contentSize.height - tableview.frame.size.height - sectionFooterHeight), 0);
        }
    }
}

- (HMSegmentedControl *)segmentControl
{
    if (!_segmentControl) {
        _segmentControl = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"全部", @"待付款", @"待收货", @"已签收", @"已完成"]];
        _segmentControl.frame = CGRectMake(0, 0, kScreenW, 44);
        _segmentControl.selectionIndicatorHeight = 2.0f;
        _segmentControl.backgroundColor = [UIColor whiteColor];
        _segmentControl.titleTextAttributes = @{NSForegroundColorAttributeName : kGlobalTextColor};
        _segmentControl.selectionIndicatorColor = [UIColor colorWithHexString:@"#f15353"];
        _segmentControl.selectionStyle = HMSegmentedControlSelectionStyleFullWidthStripe;
        _segmentControl.selectedSegmentIndex = HMSegmentedControlNoSegment;
        _segmentControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
        _segmentControl.shouldAnimateUserSelection = NO;
        [_segmentControl setSelectedSegmentIndex:[self.typeStr integerValue]];
        [_segmentControl addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
        
        [_segmentControl addTopSplitLine];
        [_segmentControl addBottomSplitLine];
    }
    return _segmentControl;
}

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return  _dataArray;
}

- (NSMutableArray *)orderItemsArray
{
    if (!_orderItemsArray) {
        _orderItemsArray = [NSMutableArray array];
    }
    return _orderItemsArray;
}

- (OrderListModel *)orderListModel
{
    if (!_orderListModel) {
        _orderListModel = [[OrderListModel alloc] init];
    }
    return _orderListModel;
}

#pragma mark -无商品显示view
- (UIView *)placeHolder
{
    if (!_placeHolder) {
        _placeHolder = [[UIView alloc] initWithFrame:CGRectMake(0, 44, kScreenW, kScreenH - 44 - kNavigationBarHeight)];
        _placeHolder.backgroundColor = kGrayBackgroundColor;
        _placeHolder.hidden = YES;
        [self.view addSubview:_placeHolder];
        
        UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenW - 100)/2, (kScreenH - 300)/2, 100, 100)];
        image.image = [UIImage imageNamed:@"wudingdan"];
        [_placeHolder addSubview:image];
        
        UILabel *label = [_placeHolder addLabelWithText:@"未查询到订单!" color:[UIColor grayColor]];
        label.frame = CGRectMake(0, CGRectGetMaxY(image.frame) + 10, kScreenW, 20);
        label.textAlignment = NSTextAlignmentCenter;
    }
    return _placeHolder;
}

@end
