//
//  OrderDetailsVC.m
//  吾家超市
//
//  Created by iMac15 on 2016/11/23.
//  Copyright © 2016年 iMac15. All rights reserved.
//

#import "OrderDetailsVC.h"
#import "OrderDetailsGoodsCell.h"
#import "OrderListFrame.h"
#import "OrderListModel.h"

#import "OrderAddressCell.h"
#import "OrderAddressFrame.h"
#import "OrderModel.h"

#import "OrderDetailHeadCell.h"
#import "OrderDetailFooterCell.h"

#import "AfterSalesVC.h"
#import "OrderTrackingVC.h"

#import "PutInSalesVC.h"
#import "SaleDetailVC.h"

#import "OrderListVC.h"
#import "ProductDetailsVC.h"

@interface OrderDetailsVC ()<UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) NSMutableArray * dataArray;
@property (strong, nonatomic) DefaultReceiverModel *addressModel;
@property (strong, nonatomic) OrderAddressFrame *addressFram;
@property (strong, nonatomic) OrderListModel *orderListModel;
@property (strong, nonatomic) OrderListFrame *orderListFrame;
@property (strong, nonatomic) NSArray *shippingsModelArray;
@property (strong, nonatomic) NSString *shippingStatus;

@property (strong, nonatomic) UIButton *trackBtn;
@property (strong, nonatomic) NSString *trackStr;
@end

@implementation OrderDetailsVC

#pragma mark -加载订单详情
- (void)loadData
{
    kWeakSelf
    NSDictionary *param = @{@"sn":self.orderSN};
    [WJRequestTool get:kOrderViewUrl param:param resultClass:[OrderDetailsResult class] successBlock:^(OrderDetailsResult *result)
     {
         if (!kObjectIsEmpty(result.t)) {
             weakSelf.orderListModel = [[OrderListModel alloc] init];
             weakSelf.orderListModel = result.t;
             
             weakSelf.trackStr = result.t.sn;
             
             if ([result.t.orderStatusShow isEqualToString:@"已支付,已发货"]) {
                 weakSelf.trackBtn.hidden = NO;
             }
             else{
                 weakSelf.trackBtn.hidden = YES;
             }
             
             //用户地址
             weakSelf.addressModel = [[DefaultReceiverModel alloc] init];
             weakSelf.addressModel.areaName = result.t.areaName;
             weakSelf.addressModel.address = result.t.address;
             weakSelf.addressModel.consignee = result.t.consignee;
             weakSelf.addressModel.createDate = result.t.createDate;
             weakSelf.addressModel.id = result.t.id;
             weakSelf.addressModel.isDefault = @"";
             weakSelf.addressModel.modifyDate = result.t.modifyDate;
             weakSelf.addressModel.phone = result.t.phone;
             weakSelf.addressModel.zipCode = result.t.zipCode;
             
             weakSelf.addressFram = [[OrderAddressFrame alloc] init];
             weakSelf.addressFram.dataModel = weakSelf.addressModel;
             
             if ([result.t.shippingStatus isEqualToString:@"shipped"]) {
                 weakSelf.shippingsModelArray = result.t.shippings;
                 weakSelf.shippingStatus = result.t.shippingStatus;
             }
             
             //商品列表
             [weakSelf.dataArray removeAllObjects];
             [weakSelf.dataArray addObjectsFromArray: [OrderListFrame frameModelArrayWithDataArray:result.t.orderItems]];
             [weakSelf.tableView reloadData];
         }
     } failure:^(NSError *error) {
         
     }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单详情";
    [self.view addSplitLineWithFrame:CGRectMake(0, 0, kScreenW, kSplitLineHeight)];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorColor = kGlobalLineColor;
    self.tableView.backgroundColor = kGrayBackgroundColor;
    
    CGFloat hight;
    
    if (self.trackBtn.hidden == YES) {
        hight = kScreenH - 64;
    }
    else{
        hight = kScreenH - 64 - 44;
    }
    self.tableView.frame = CGRectMake(0, 0, kScreenW, hight);

    [self loadData];
}

#pragma mark -查看物流
- (UIButton *)trackBtn
{
    if (!_trackBtn) {
        _trackBtn = [self.view addButtonFilletWithTitle:@"查看物流"
                                                     target:self
                                                     action:@selector(trackBtnClick)];
        _trackBtn.frame = CGRectMake(0, kScreenH -kNavigationBarHeight - 44, kScreenW, 44);
        _trackBtn.layer.cornerRadius = 0;
        _trackBtn.hidden = YES;
        [self.view addSubview:_trackBtn];
    }
    return _trackBtn;
}

- (void)trackBtnClick
{
    if (!kStringIsEmpty(self.trackStr)) {
        OrderTrackingVC *vc = [[OrderTrackingVC alloc] init];
        vc.orderTrackSN = self.trackStr;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - UITabelViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 2) {
        return self.dataArray.count;
    }
    else{
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifer=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        cell.textLabel.textColor = kGlobalTextColor;
        cell.textLabel.font = kTextFont;
    }
    
    kWeakSelf
    
    if (indexPath.section == 0) {
        OrderDetailHeadCell *cell = [OrderDetailHeadCell cellWithTableView:tableView reuseIdentifier:@"OrderDetailHeadCell"];
        cell.accessoryType=UITableViewCellAccessoryNone;
        cell.headerDetailModel = self.orderListModel;
        return cell;
    }
    else if (indexPath.section == 1) {
        OrderAddressCell *cell = [OrderAddressCell cellWithTableView:tableView reuseIdentifier:@"OrderAddressCell"];
        cell.accessoryType=UITableViewCellAccessoryNone;
        cell.frameModel = self.addressFram;
        cell.topLine.hidden = YES;
        
        return cell;
    }
    else if (indexPath.section == 2) {
        OrderDetailsGoodsCell *cell = [OrderDetailsGoodsCell cellWithTableView:tableView reuseIdentifier:@"OrderDetailsGoodsCell"];
        
        OrderListFrame *cellFrameModel = self.dataArray[indexPath.row];
        cell.orderItemModel = cellFrameModel.dataModel;
        cell.shippingStatus = weakSelf.shippingStatus;
        
        cell.orderSaleBtn = ^(OrderItems *orderItemModel, NSString *type)
        {
            if ([type isEqualToString:@"退换货"]) {
                PutInSalesVC *vc = [[PutInSalesVC alloc] init];
                vc.maxNumberStr = orderItemModel.quantity;
                vc.orderItemId = orderItemModel.id;
                [self.navigationController pushViewController:vc animated:YES];
            }
            else if ([type isEqualToString:@"查看售后"]){
                SaleDetailVC *vc = [[SaleDetailVC alloc] init];
                vc.salesDetailId = orderItemModel.returnGoodsId;
                [self.navigationController pushViewController:vc animated:YES];
            }            
        };
        
        return cell;
    }
    else {
        OrderDetailFooterCell *cell = [OrderDetailFooterCell cellWithTableView:tableView reuseIdentifier:@"OrderDetailFooterCell"];
        cell.accessoryType=UITableViewCellAccessoryNone;
        cell.footerDetailModel = self.orderListModel;
        return cell;
    }
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!kArrayIsEmpty(self.dataArray)) {
        if (indexPath.section == 0){
            return 120;
        }
        else if (indexPath.section == 1){
            return 80;
        }
        else if (indexPath.section == 2){
            return 80;
        }
        else{
            return 110;
        }
    }else{
        return 0;
    }
}

- (CGFloat)tableView:( UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 1 || section == 2|| section == 0) {
        return 10;
    }
    else{
        return 0;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2) {
        OrderListFrame *cellFrameModel = self.dataArray[indexPath.row];
        
        ProductDetailsVC *vc = [[ProductDetailsVC alloc] init];
        vc.productId = cellFrameModel.dataModel.productID;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return  _dataArray;
}

- (NSArray *)shippingsModelArray
{
    if (!_shippingsModelArray) {
        _shippingsModelArray = [NSArray array];
    }
    return _shippingsModelArray;
}

@end
