//
//  AddressListVC.m
//  吾家超市
//
//  Created by iMac15 on 2016/11/16.
//  Copyright © 2016年 iMac15. All rights reserved.
//

#import "AddressListVC.h"

@interface AddressListVC ()<UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) NSMutableArray *addressList;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) AddressModel *addressModel;

@property (strong, nonatomic) UIView *bottomView;
@property (strong, nonatomic) UIView *placeHolder;
@end

@implementation AddressListVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"地址管理";
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.bottomView];
}

#pragma mark - 新建收货地址
- (void)greatAddressBtn:(WJFilletButton *)sender
{
    kWeakSelf
    CreateNewAddressVC *vc = [[CreateNewAddressVC alloc] init];
    vc.createAddressType = self.addressType;
    
    if ([self.addressType isEqualToString:@"1"]) {
        vc.creatAddress = ^(AddressModel *currentAddress)
        {
            if (weakSelf.changeAddress) {
                weakSelf.changeAddress(currentAddress);
            }
        };
    }
    
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 获取用户地址信息
- (void)loadData
{
    kWeakSelf
    [WJRequestTool get:kAddrressListUrl param:nil resultClass:[AddressListResult class] successBlock:^(AddressListResult *result)
     {
         if ([result.type isEqualToString:@"success"] && !kObjectIsEmpty(result.t)) {
            [weakSelf.addressList removeAllObjects];
            [weakSelf.addressList addObjectsFromArray: [AddressListCellFrameModel frameModelArrayWithDataArray:result.t]];
            [weakSelf.tableView reloadData];
         }
         else{
             weakSelf.placeHolder.hidden = NO;
         }
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
    AddressListCell *cell = [AddressListCell addressListCellWithTableView:tableView];
    cell.frameModel = self.addressList[indexPath.row];
    
    kWeakSelf
    
    //编辑地址
    cell.editAddress = ^(AddressModel *address)
    {
        CreateNewAddressVC *vc = [[CreateNewAddressVC alloc] init];
        vc.createAddressType = self.addressType;
        vc.editAddressModel = address;
        
        if ([self.addressType isEqualToString:@"1"]) {
            vc.creatAddress = ^(AddressModel *currentAddress)
            {
                if (weakSelf.changeAddress) {
                    weakSelf.changeAddress(currentAddress);
                }
            };
        }
        
        [self.navigationController pushViewController:vc animated:YES];
    };
    
    //删除地址
    cell.deleteAddress = ^(AddressModel *address)
    {
        WJAlertView *alert = [[WJAlertView alloc] initWithTitle:@"确认删除地址?" message:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert showWithButtonClickAction:^(NSInteger index)
         {
             if (index == 1)
             {
                 NSDictionary *param = @{@"id":address.id};
                 [WJRequestTool post:kDeleteAdrressUrl param:param resultClass:[ShopCarResult class] successBlock:^(ShopCarResult *result)
                  {
                      if ([result.type isEqualToString:@"success"]) {
                          if (!kArrayIsEmpty(weakSelf.addressList)) {
                              [weakSelf.addressList removeObjectAtIndex:indexPath.row];
                              [weakSelf.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                              if (!kArrayIsEmpty(weakSelf.addressList)) {
                                  [weakSelf.tableView reloadData];
                              }
                              else{
                                  weakSelf.placeHolder.hidden = NO;
                              }
                          }
                      }
                      
                  } failure:^(NSError *error) {
                      
                  }];
             }
         }];
    };
    
    //设置默认地址
    cell.defaultAddress = ^(AddressModel *address)
    {
        
    };
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AddressListCellFrameModel *frameModel = self.addressList[indexPath.row];
    return frameModel.height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AddressListCellFrameModel *frameModel =  self.addressList[indexPath.row];
    
    if (self.changeAddress) {
        self.changeAddress(frameModel.dataModel);
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH - 64 - 46) style:UITableViewStyleGrouped];
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
    if (_addressList == nil) {
        _addressList = [NSMutableArray array];
    }
    return _addressList;
}

#pragma mark -收货地址-为空-view
- (UIView *)placeHolder
{
    if (!_placeHolder) {
        _placeHolder = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH - kNavigationBarHeight - 46)];
        _placeHolder.backgroundColor = kGrayBackgroundColor;
        _placeHolder.hidden = YES;
        [self.view addSubview:_placeHolder];
        
        UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenW - 100)/2, (kScreenH - 300)/2, 100, 100)];
        image.image = [UIImage imageNamed:@"wudizhi"];
        [_placeHolder addSubview:image];
        
        UILabel *label = [_placeHolder addLabelWithText:@"收货地址为空!" color:[UIColor grayColor]];
        label.frame = CGRectMake(0, CGRectGetMaxY(image.frame) + 10, kScreenW, 20);
        label.textAlignment = NSTextAlignmentCenter;
    }
    return _placeHolder;
}

- (UIView *)bottomView
{
    if (!_bottomView) {
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenH - kNavigationBarHeight - 46, kScreenW, 46)];
        _bottomView.backgroundColor = [UIColor whiteColor];
        
        UIButton *greatAddressBtn = [_bottomView addButtonFilletWithTitle:@"+ 添加新地址" target:self action:@selector(greatAddressBtn:)];
        greatAddressBtn.frame = CGRectMake(10, 5, kScreenW - 20, 36);
    }
    return _bottomView;
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

