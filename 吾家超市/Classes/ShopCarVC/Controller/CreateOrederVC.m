//
//  CreateOrederVC.m
//  吾家超市
//
//  Created by iMac15 on 2016/11/14.
//  Copyright © 2016年 iMac15. All rights reserved.
//

#import "CreateOrederVC.h"
#import "OrderModel.h"
#import "OrderAddressFrame.h"
#import "OrderAddressCell.h"

#import "OrderGoodsCell.h"
#import "OrderGoodsFrame.h"

#import "SuccessPayForVC.h"
#import "PayOrderVC.h"
#import "AddressListVC.h"

#import "CouponVC.h"
#import "BalanceVC.h"
#import "CatibalVC.h"
#import "WJCountdownButton.h"
#import "AddressModel.h"
#import "OrderInvoiceCell.h"

@interface OrderParam : NSObject
@property (copy, nonatomic) NSString *paymentMethodId;
@property (copy, nonatomic) NSString *shippingMethodId;
@property (copy, nonatomic) NSString *code;
@property (copy, nonatomic) NSString *isInvoice;
@property (copy, nonatomic) NSString *invoiceTitle;
@property (copy, nonatomic) NSString *memo;
@property (copy, nonatomic) NSString *capital;
@property (copy, nonatomic) NSString *depositAmount;
@property (copy, nonatomic) NSString *capitalAmount;
@property (copy, nonatomic) NSString *receiverId;
@property (copy, nonatomic) NSString *generateCode;
@property (copy, nonatomic) NSString *cartToken;
@property (copy, nonatomic) NSString *methods;
@end

@implementation OrderParam

@end


@interface CreateOrederVC () <UITextViewDelegate>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *dataArray;
@property (strong, nonatomic) NSMutableArray *couponArray;
@property (strong, nonatomic) OrderAddressFrame *addressFrame;

@property (strong, nonatomic) OrderData *cellDataModel;

@property (strong, nonatomic) UIView *bootomView;
@property (strong, nonatomic) UILabel *priceLab;
@property (strong, nonatomic) UIButton *orderBtn;
@property (strong, nonatomic) NSString *carToken;
@property (strong, nonatomic) NSString *couponStr;

@property (strong, nonatomic) NSString *blanceVCStr;
@property (strong, nonatomic) NSString *capitalVCStr;
@property (strong, nonatomic) NSString *amountPayableStr;

@property (strong, nonatomic) NSString *meDeposit;
@property (strong, nonatomic) NSString *meCapital;
@property (strong, nonatomic) OrderParam *orderParam;
@property (strong, nonatomic) NSString *invoiceTitleStr;    //发票

@property (strong, nonatomic) NSString *productIdSelectStr;
@property (strong, nonatomic) NSString *goBackCarStr;
@property (strong, nonatomic) NSString *showNameStr;
@property (strong, nonatomic) NSString *isgoBackStr;

@property (strong, nonatomic) NSMutableArray *isgoBackArray;
@property (strong, nonatomic) NSMutableArray *isgoSelectArray;
@end


@implementation CreateOrederVC

#pragma mark - 将不可售商品id-提交回购物车
- (NSMutableArray *)isgoSelectArray
{
    if (!_isgoSelectArray) {
        _isgoSelectArray = [NSMutableArray array];
    }
    return _isgoSelectArray;
}

- (NSMutableArray *)isgoBackArray
{
    if (!_isgoBackArray) {
        _isgoBackArray = [NSMutableArray array];
    }
    return _isgoBackArray;
}

- (void)goBackCar
{
    kWeakSelf
    
    if (!kStringIsEmpty(self.goBackCarStr)) {
        
        NSDictionary *param = @{@"id":self.goBackCarStr};
        
        [WJRequestTool get:kOrderGoBackCartUrl param:param resultClass:[OrderAddressGoodsResult class] successBlock:^(OrderAddressGoodsResult *result)
         {
             weakSelf.goBackCarStr = @"";
             weakSelf.showNameStr = @"";
             
             if ([result.type isEqualToString:@"success"]) {
                 
                 weakSelf.isgoBackStr = @"2";
                 
                 if (weakSelf.isgoSelectArray.count > 0) {
                     [weakSelf loadData];
                 }
                 else{
                     [weakSelf.navigationController popViewControllerAnimated:YES];
                     [MBProgressHUD showTextMessage:@"此商品此收货地址无货!" hideAfter:3.0f];
                 }
             }
             
         } failure:^(NSError *error) {
             
         }];
    }
}

#pragma mark - 商品是否可售
- (void)loadOrderAddressGoods
{
    kWeakSelf
    
    if (!kStringIsEmpty(self.addressFrame.dataModel.id) && !kStringIsEmpty(self.productIdSelectStr)) {
        
        NSDictionary *param = @{@"receiverId":self.addressFrame.dataModel.id, @"productId":self.productIdSelectStr};
        
        [WJRequestTool get:kOrderGetAreaLimitUrl param:param resultClass:[OrderAddressGoodsResult class] successBlock:^(OrderAddressGoodsResult *result)
         {
             if ([result.type isEqualToString:@"success"] && result.t.count > 0) {
                 
                 weakSelf.goBackCarStr = @"";   //返回购物车-id
                 NSString *strZ = @",";
                 
                 weakSelf.showNameStr= @"";   //不可售-商品名称
                 NSString *showZ = @"\n";
                 
                 for (OrderAddressGoodsModel *orderAddModel in result.t) {
                     
                     if ([orderAddModel.isSale isEqualToString:@"0"]) {
                         
                         for (OrderItemsModel *itemsGoModel in weakSelf.isgoBackArray) {
                             
                             //                             if ([orderAddModel.gropID isEqualToString:itemsGoModel.grapId]) {
                             //
                             ////                                 weakSelf.goBackCarStr = [weakSelf.goBackCarStr stringByAppendingFormat:@"%@%@",itemsGoModel.productID,strZ];
                             ////
                             ////                                 weakSelf.showNameStr = [weakSelf.showNameStr stringByAppendingFormat:@"-->缺货%@%@",itemsGoModel.fullName,showZ];
                             //                                 if (weakSelf.isgoSelectArray.count > 0) {
                             //                                     [weakSelf.isgoSelectArray removeObject:itemsGoModel];
                             //                                 }
                             //                             }
                             //                             else{
                             //                                 [weakSelf.isgoSelectArray addObject:itemsGoModel];
                             //                             }
                             
                         }
                         
                     }
                 }
                 
                 if (!kStringIsEmpty(weakSelf.goBackCarStr)) {  //处理无货商品
                     
                     WJAlertView *alert = [[WJAlertView alloc] initWithTitle:@"缺货提示!" message:weakSelf.showNameStr cancelButtonTitle:@"继续下单" otherButtonTitles:@"返回购物车", nil];
                     [alert show];
                     
                     [alert showWithButtonClickAction:^(NSInteger index) {
                         if (index == 1) {
                             [weakSelf.navigationController popViewControllerAnimated:YES];
                         }else{
                             [weakSelf goBackCar];
                         }
                     }];
                 }
                 
             }
             
         } failure:^(NSError *error) {
             
         }];
    }
}

#pragma mark -确认下单
- (OrderParam *)orderParam
{
    if (!_orderParam) {
        
        NSString *insInvoice;
        if (kStringIsEmpty(self.invoiceTitleStr)) {
            insInvoice = @"false";
        }
        else{
            insInvoice = @"true";
        }
        
        _orderParam = [[OrderParam alloc] init];
        _orderParam.paymentMethodId = @"1";                 //支付方法
        _orderParam.shippingMethodId = @"1";                //配送方法
        _orderParam.isInvoice = insInvoice;
        _orderParam.invoiceTitle = self.invoiceTitleStr;    //发票抬头
        _orderParam.memo = @"";
        _orderParam.capital = @"";
        _orderParam.code = @"";                             //优惠券
        _orderParam.depositAmount = @"";                    //余额
        _orderParam.capitalAmount = @"";                    //消费资本
        _orderParam.receiverId = self.addressFrame.dataModel.id;                   //收货地址
        _orderParam.generateCode = @"";    //短信验证码
        _orderParam.cartToken = self.carToken;
        _orderParam.methods = @"";
    }
    return _orderParam;
}

- (void)orderBtnClick
{
    kWeakSelf
    [self.view endEditing:YES];
    
    if (kStringIsEmpty(self.orderParam.receiverId)) {
        [MBProgressHUD showTextMessage:@"请选择收货地址!"];
        return;
    }
    else{
        [WJRequestTool post:kOrderCreateUrl param:self.orderParam resultClass:[OrderSuccessResult class] successBlock:^(OrderSuccessResult *result)
         {
             if ([result.type isEqualToString:@"success"]) {
                 OrderModel *orderModel = [[OrderModel alloc] init];
                 orderModel = [result.t objectAtIndex:0];
                 
                 PayOrderVC *vc = [[PayOrderVC alloc] init];
                 vc.payNumberStr = orderModel.sn;
                 vc.payPriceStr = orderModel.amountPayable;
                 vc.addressStr = [NSString stringWithFormat:@"%@%@",orderModel.areaName,orderModel.address];
                 [weakSelf.navigationController pushViewController:vc animated:YES];
             }
             else{
                 [MBProgressHUD showTextMessage:result.content];
             }
         } failure:^(NSError *error) {
             
         }];
    }
}

#pragma mark -计算预定单数据
- (void)loadTheCalculate
{
    kWeakSelf
    
    NSString *insInvoice;   //是否开-发票
    if (kStringIsEmpty(self.invoiceTitleStr)) {
        insInvoice = @"false";
    }
    else{
        insInvoice = @"true";
    }
    
    NSString *addressId;    //收货地址id
    if (kStringIsEmpty(self.addressFrame.dataModel.id)) {
        addressId = @"";
    }
    else{
        addressId = self.addressFrame.dataModel.id;
    }
    
    self.orderParam.paymentMethodId = @"1";     //支付方法
    self.orderParam.shippingMethodId = @"1";    //配送方法
    self.orderParam.isInvoice = insInvoice;
    self.orderParam.invoiceTitle = self.invoiceTitleStr;
    self.orderParam.memo = @"";
    self.orderParam.capital = @"";
    self.orderParam.code = @"";                 //优惠券
    self.orderParam.depositAmount = @"";        //余额
    self.orderParam.capitalAmount = @"";        //消费资本
    self.orderParam.receiverId = addressId;     //收货地址
    self.orderParam.cartToken = self.carToken;
    self.orderParam.methods = @"";
    
    [WJRequestTool post:kCalculateUrl param:self.orderParam  resultClass:[OrderResult class] successBlock:^(OrderResult *result)
     {
         [weakSelf.dataArray removeAllObjects];
         
         weakSelf.addressFrame.dataModel = result.t.defaultReceiver; //用户地址
         
         OrderModel *orderModel = [[OrderModel alloc] init];
         orderModel = [result.t.order objectAtIndex:0];
         [weakSelf.dataArray addObjectsFromArray: [OrderGoodsFrame frameModelArrayWithDataArray:orderModel.orderItems]]; //商品列表
         
         weakSelf.cellDataModel = result.t; //订单信息
         weakSelf.priceLab.text = [NSString stringWithFormat:@"应付: ¥ %.2f",[result.t.amountPayable floatValue]];
         weakSelf.carToken = result.t.cartTag;
         
         [weakSelf.tableView reloadData];
         
     } failure:^(NSError *error) {
         
     }];
}

#pragma mark -加载订单数据
- (OrderAddressFrame *)addressFrame //收货地址
{
    if (!_addressFrame) {
        _addressFrame = [[OrderAddressFrame alloc] init];
    }
    return _addressFrame;
}

- (OrderModel *)cellDataModel   //订单信息
{
    if (!_cellDataModel) {
        _cellDataModel = [[OrderModel alloc] init];
    }
    return _cellDataModel;
}

- (NSString *)isgoBackStr   //判断是否可售
{
    if (!_isgoBackStr) {
        _isgoBackStr = @"1";
    }
    return _isgoBackStr;
}

#pragma mark -获取预定单数据
- (void)loadData
{
    kWeakSelf
    [WJRequestTool get:kOrderInfoUrl param:nil resultClass:[OrderResult class] successBlock:^(OrderResult *result)
     {
         if ([result.type isEqualToString:@"success"]) {
             
             [weakSelf.dataArray removeAllObjects];
             [weakSelf.isgoBackArray removeAllObjects];
             [weakSelf.isgoSelectArray removeAllObjects];
             
             weakSelf.addressFrame.dataModel = result.t.defaultReceiver; //用户地址
             
             OrderModel *orderModel = [[OrderModel alloc] init];
             orderModel = [result.t.order objectAtIndex:0];
             [weakSelf.dataArray addObjectsFromArray: [OrderGoodsFrame frameModelArrayWithDataArray:orderModel.orderItems]]; //商品列表
             
             weakSelf.cellDataModel = result.t; //订单信息
             weakSelf.priceLab.text = [NSString stringWithFormat:@"应付: ¥ %.2f",[result.t.amountPayable floatValue]];
             weakSelf.carToken = result.t.cartTag;
             
             [weakSelf.tableView reloadData];
             //
             //             if ([weakSelf.isgoBackStr isEqualToString:@"1"]) {    //验证商品是否可售
             //                 [weakSelf loadOrderAddressGoods];
             //             }
             
             //             weakSelf.productIdSelectStr = @""; //所有商品id
             //             NSString *str = @",";
             
             //             for (OrderItemsModel *itemsModel in result.t.order.orderItems) {
             
             //                 weakSelf.productIdSelectStr = [weakSelf.productIdSelectStr stringByAppendingFormat:@"%@=%@%@",itemsModel.productID,itemsModel.quantity,str];
             
             //                 [weakSelf.isgoBackArray addObject:itemsModel];
             //             }
             //             WJLog(@"-->预订单商品--拼接 productid : %@",self.productIdSelectStr);
             
         }
         else{
             [weakSelf.navigationController popViewControllerAnimated:YES];
         }
         
     } failure:^(NSError *error) {
         
     }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单确认";
    self.view.backgroundColor = kGrayBackgroundColor;
    [self.view addSplitLineWithFrame:CGRectMake(0, kNavigationBarHeight, kScreenW, kSplitLineHeight)];
    
    self.tableView = [self.view addTableViewWithDelegate:self dataSource:self];
    self.tableView.frame = CGRectMake(0, 1, kScreenW, kScreenH - 45 - kNavigationBarHeight);
    
    [self loadBootomView];
    [self loadData];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 1){
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
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifer];
        cell.textLabel.textColor = kGlobalTextColor;
        cell.textLabel.font = kTextFont;
        cell.detailTextLabel.font = kTextFont;
    }
    
    if (indexPath.section == 0) {
        
        OrderAddressCell *cell = [OrderAddressCell cellWithTableView:tableView reuseIdentifier:@"OrderAddressCell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.frameModel = self.addressFrame;
        return cell;
    }
    else if (indexPath.section == 1){
        
        OrderGoodsCell *cell = [OrderGoodsCell cellWithTableView:tableView reuseIdentifier:@"OrderGoodsCell"];
        cell.goodsFrame = self.dataArray[indexPath.row];
        return cell;
    }
    else if(indexPath.section == 2){
        
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.textLabel.text = @"价格合计:";
        cell.detailTextLabel.text = [NSString stringWithFormat:@"¥ %@",self.cellDataModel.amountPayable];
        return  cell;
    }
    else if(indexPath.section == 3){
        
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.textLabel.text = @"快递费用:";
        cell.detailTextLabel.text = [NSString stringWithFormat:@"¥ %@",self.cellDataModel.freight];
        return  cell;
    }
    else if(indexPath.section == 4){
        
        if (cell==nil) {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        }
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.textLabel.text = @"";
        cell.detailTextLabel.text = @"由吾家网负责发货";
        [cell.textLabel setTintColor:kGlobalRedColor];
        return  cell;
    }
    //    else if(indexPath.section == 5){
    //
    //        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    //        cell.textLabel.text = @"使用优惠码:";
    //
    //        if ([self.cellDataModel.couponDiscount isEqualToString:@"0"]) {
    //            cell.detailTextLabel.text = @"";
    //        }
    //        else{
    //            cell.detailTextLabel.text = [NSString stringWithFormat:@"立减¥ %@",self.cellDataModel.couponDiscount];
    //        }
    //        [cell.detailTextLabel setTintColor:[UIColor blackColor]];
    //        return  cell;
    //    }
    else {  //发票信息
        
        OrderInvoiceCell *cell = [OrderInvoiceCell cellWithTableView:tableView reuseIdentifier:@"OrderInvoiceCell"];
        cell.textView.delegate = self;
        return cell;
    }
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 80;
    }
    else if (indexPath.section == 1) {
        OrderGoodsFrame *frameModel = self.dataArray[indexPath.row];
        return frameModel.cellHeight;
    }
    else if (indexPath.section == 5) {
        return 110;
    }
    else{
        return 44;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self.view endEditing:YES];
    
    kWeakSelf
    
    if (indexPath.section == 0){
        
        AddressListVC *addressVC = [[AddressListVC alloc] init];
        addressVC.addressType = @"1";
        addressVC.changeAddress = ^(AddressModel *currentAddress)
        {
            DefaultReceiverModel *addressDefault = [[DefaultReceiverModel alloc] init];
            
            addressDefault.address = currentAddress.address;
            addressDefault.areaName = currentAddress.areaName;
            addressDefault.consignee = currentAddress.consignee;
            addressDefault.createDate = currentAddress.createDate;
            addressDefault.id = currentAddress.id;
            addressDefault.modifyDate = currentAddress.modifyDate;
            addressDefault.phone = currentAddress.phone;
            addressDefault.zipCode = currentAddress.zipCode;
            
            weakSelf.addressFrame.dataModel = addressDefault;
            
            NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:0];    //地址section刷新
            [weakSelf.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
            
            [weakSelf loadTheCalculate];   //计算预定单数据
        };
        
        [self.navigationController pushViewController:addressVC animated:YES];
    }
}

- (CGFloat)tableView:( UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0 || section == 1 || section == 4 || section == 5) {
        return 10;
    }else{
        return 0;
    }
}

-(void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section
{
    view.tintColor = kGrayBackgroundColor;
}

#pragma mark -UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView
{
    self.invoiceTitleStr = textView.text;
}

#pragma mark -商品数组
- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

#pragma mark -优惠券
- (NSMutableArray *)couponArray
{
    if (!_couponArray) {
        _couponArray = [NSMutableArray array];
    }
    return _couponArray;
}

#pragma mark -底部ToolBar
- (void)loadBootomView
{
    _bootomView = [[UIView alloc] init];
    _bootomView.frame = CGRectMake(0, kScreenH - kNavigationBarHeight -44, kScreenW, 44);
    _bootomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_bootomView];
    
    [_bootomView addSplitLineWithFrame:CGRectMake(0, 0, kScreenW, kSplitLineHeight)];
    
    _orderBtn = [_bootomView addButtonFilletWithTitle:@"确认下单" target:self action:@selector(orderBtnClick)];
    _orderBtn.frame = CGRectMake(kScreenW - 90, 0, 90, 44);
    _orderBtn.layer.cornerRadius = 0;
    
    _priceLab = [_bootomView addLabelWithText:@"" color:kGlobalRedColor];
    _priceLab.frame = CGRectMake(10, 0, kScreenW - 110, 44);
}

#pragma mark - cell线短15cm
- (void)viewDidLayoutSubviews
{
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

@end
