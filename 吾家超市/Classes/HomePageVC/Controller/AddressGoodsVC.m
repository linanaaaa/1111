//
//  AddressGoodsVC.m
//  吾家网
//
//  Created by iMac15 on 2017/6/15.
//  Copyright © 2017年 iMac15. All rights reserved.
//

#import "AddressGoodsVC.h"
#import "ChooseAddressVC.h"

@interface AddressGoodsVC ()<UITableViewDataSource, UITableViewDelegate,UINavigationControllerDelegate>
@property (strong, nonatomic) UIView *bakeView;

@property (strong, nonatomic) NSMutableArray *addressArray;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) AddressModel *addressModel;

@property (strong, nonatomic) NSMutableArray *addressList;

@end

@implementation AddressGoodsVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadData];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self closeClick];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.delegate = self;

    self.view.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.bakeView];
    [self.bakeView addSubview:self.tableView];
}

#pragma mark - 获取用户地址信息
- (void)loadData
{
    kWeakSelf
    
    [WJRequestTool get:kAddrressListUrl param:nil resultClass:[AddressListResult class] successBlock:^(AddressListResult *result)
     {
         [weakSelf.addressList removeAllObjects];
         
         [weakSelf.addressList addObjectsFromArray: [AddressGoodsFrame frameModelArrayWithDataArray:result.t]];
         
        [weakSelf.tableView reloadData];
         
     } failure:^(NSError *error) {
         
     }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.addressList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AddressGoodsCell *cell = [AddressGoodsCell addressGoodsCellWithTableView:tableView];
    cell.frameModel = self.addressList[indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AddressGoodsFrame *frameModel = self.addressList[indexPath.row];
    return frameModel.height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AddressGoodsFrame *frameModel =  self.addressList[indexPath.row];
    
    NSString *str = [NSString stringWithFormat:@"%@%@",frameModel.dataModel.areaName, frameModel.dataModel.address];

    //选择完成传值
    if (self.chooseAddress) {
        self.chooseAddress (str, frameModel.dataModel.id);
        [self closeClick];
    }
}

- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, kScreenW, kScreenH - 250 - 80) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = kGrayBackgroundColor;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.separatorColor = kGlobalLineColor;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 10)];
        _tableView.tableFooterView = [[UIView alloc] init];
    }
    return _tableView;
}

- (NSMutableArray *)addressList
{
    if (!_addressList) {
        _addressList = [NSMutableArray array];
    }
    return _addressList;
}

#pragma mark -选择其他地址

- (NSMutableArray *)addressArray
{
    if (!_addressArray) {
        _addressArray = [NSMutableArray array];
    }
    return _addressArray;
}

- (void)chroessNewAddBtn
{
    [self presentViewController:[ChooseAddressVC new] animated:YES completion:^{
        
    }];
}

#pragma mark - 基view
- (UIView *)bakeView
{
    if (!_bakeView) {
        _bakeView = [UIView new];
        _bakeView.frame = CGRectMake(0, 250, kScreenW, kScreenH - 250);
        _bakeView.backgroundColor = [UIColor whiteColor];
        
        [_bakeView addTopSplitLine];
        [_bakeView addSplitLineWithFrame:CGRectMake(0, 40, kScreenW, kSplitLineHeight)];
        
        UILabel *lab = [_bakeView addLabelWithText:@"配送至" color:[UIColor grayColor]];
        lab.frame = CGRectMake(0, 10, kScreenW - 40, 20);
        lab.textAlignment = NSTextAlignmentCenter;
        
        UIButton *closeBtn = [_bakeView addButtonWithTitle:@"X" target:self action:@selector(closeClick)];
        closeBtn.frame = CGRectMake(kScreenW - 30, 10, 20, 20);
        
        UIButton *greatAddressBtn = [_bakeView addButtonFilletWithTitle:@"选择其他地址" target:self action:@selector(chroessNewAddBtn)];
        greatAddressBtn.frame = CGRectMake(0, _bakeView.frame.size.height - 44, kScreenW, 44);
        greatAddressBtn.layer.cornerRadius = 0;
    }
    return _bakeView;
}

- (void)closeClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 判断要显示的控制器是否是自己
    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
    
    [self.navigationController setNavigationBarHidden:isShowHomePage animated:YES];
}

@end
