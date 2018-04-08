//
//  MineVC.m
//  吾家超市
//
//  Created by iMac15 on 2016/10/24.
//  Copyright © 2016年 iMac15. All rights reserved.
//

#import "MineVC.h"
#import "BaseNavigationController.h"

#import "MineHeaderView.h"
#import "OrderOptionsCell.h"
#import "CouponListVC.h"

#import "LoginVC.h"
#import "OrderListVC.h"
#import "AfterSalesVC.h"
#import "AddressListVC.h"
#import "RetrievePassVC.h"
#import "FavoriteListVC.h"
#import "MessageVC.h"
#import "SDImageCache.h"

#define HeaderViewHeight 200
#define NavigationBarHeight 64

@interface MineVC () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSArray * titles;
@property (nonatomic, strong) UIWebView * webView;
@property (nonatomic, strong) NSString *version;
@property (nonatomic, strong) NSArray * orderAmounts;

@property (strong, nonatomic) MineHeaderView *headerView;
@property (strong, nonatomic) UIImageView *HeadImgView; //!< 头部图像

@property (strong, nonatomic) NSString *cacheStr;
@end

@implementation MineVC


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.cacheStr =  [NSString stringWithFormat:@"缓存为%.2fMB",[[SDImageCache sharedImageCache]checkTmpSize]];
    
    [self addFooterView];
}

- (void)logoutBtnDidClick
{
    WJLog(@"退出登录");
    
    [ZNGUser logout];
    
    [self addFooterView];
}

+ (void)deleteCookieWithKey:(NSString *)key
{
    NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    
    NSArray *cookies = [NSArray arrayWithArray:[cookieJar cookies]];
    
    for (NSHTTPCookie *cookie in cookies) {
        if ([[cookie name] isEqualToString:key]) {
            [cookieJar deleteCookie:cookie];
        }
    }
}

#pragma mark -footerView
- (void)addFooterView
{
    if ([ZNGUser userInfo].isOnline)
    {
        UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 64)];
        [footerView addTopSplitLine];
        self.tableView.tableFooterView = footerView;
        
        UIButton *logoutBtn = [footerView addButtonFilletWithTitle:@"退出当前账号" target:self action:@selector(logoutBtnDidClick)];
        logoutBtn.frame = CGRectMake(10, 10, kScreenW - 20, 44);
        
        [self.tableView reloadData];
    }
    else{
        self.tableView.tableFooterView = [UIView new];
        
        [self.tableView reloadData];
    }
}

/**
 *  重写这个代理方法就行了，利用contentOffset这个属性改变frame
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat offsetY = scrollView.contentOffset.y;
    
    if (offsetY < 0) {
        self.HeadImgView.frame = CGRectMake(offsetY/2, offsetY, kScreenW - offsetY, HeaderViewHeight - offsetY);  // 修改头部的frame值就行了
    }
    
    /* 往上滑动contentOffset值为正，大多数都是监听这个值来做一些事 */
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.HeadImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, HeaderViewHeight)];
    self.HeadImgView.image = [UIImage imageNamed:@"bjtu"];
    
    [self.tableView addSubview:self.HeadImgView];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorColor = kGlobalLineColor;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.tableView.frame = CGRectMake(0, 0, kScreenW, kScreenH - kTabbarHeight + 10);
}

#pragma mark -headerView

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    kWeakSelf
    if (section == 0) {
        self.headerView = [[MineHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, HeaderViewHeight)];
        self.headerView.balanceMineStr = [ZNGUser userInfo].sumPoint;
        self.headerView.catibalMineStr = [ZNGUser userInfo].blanceCapital;
        
        if (!kStringIsEmpty([ZNGUser userInfo].name)) {
            self.headerView.loginNameStr = [ZNGUser userInfo].name;
        }
        else{
            self.headerView.loginNameStr = [ZNGUser userInfo].mobile;
        }
        
        self.headerView.loginClik = ^()  //未登录 登录/注册
        {
            [weakSelf.navigationController pushViewController:[LoginVC new] animated:YES];
        };
        
        return self.headerView;
    }
    else{
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 200;
    }
    else{
        return 0;
    }
}

#pragma mark - UITabelViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.titles.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.titles[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dict = self.titles[indexPath.section][indexPath.row];
    if (indexPath.section == 0) {
        OrderOptionsCell *cell = [OrderOptionsCell optionCellWithTableView:tableView];
        cell.badgeValues = self.orderAmounts;
        cell.btnTitles = dict[@"titles"];
        kWeakSelf
        cell.click = ^(OrderOptionType type){
            
            if ([ZNGUser userInfo].isOnline){
                
                OrderListVC *vc = [[OrderListVC alloc] init];
                vc.title = dict[@"titles"][type - 2][@"title"];
                switch (type) {
                    case OrderOptionTypeWaitingForPayment:
                        vc.typeStr = @"1";
                        break;
                    case OrderOptionTypeWaitingForDelivery:
                        vc.typeStr = @"2";
                        break;
                    case OrderOptionTypeWaitingForReceiving:
                        vc.typeStr = @"4";
                        break;
                    case OrderOptionTypeAfterSales:
                    {
                        AfterSalesVC *vc = [[AfterSalesVC alloc] init];
                        [weakSelf.navigationController pushViewController:vc animated:YES];
                        return ;
                    }
                        break;
                    case OrderOptionTypeAllOrder:
                    default:
                        vc.typeStr = @"0";
                        break;
                }
                
                [weakSelf.navigationController pushViewController:vc animated:YES];
                
            }
            else{
                [MBProgressHUD showTextMessage:@"请先登录您的账号!"];
            }
        };
        return cell;
    }
    else {
        UITableViewCell *cell = [UITableViewCell cellWithTableView:tableView reuseIdentifier:@"MineCell"];
        if ([dict[@"showArrow"] isEqualToString:@"1"]) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        else {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        
        if ([dict[@"showArrow"] isEqualToString:@"3"]) {
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
        }
        else {
            cell.textLabel.textAlignment = NSTextAlignmentLeft;
        }
        
        cell.textLabel.text = dict[@"title"];
        cell.textLabel.font = kTextFont;
        cell.textLabel.textColor = kGlobalTextColor;
        
        cell.detailTextLabel.font = kTextFont;
        cell.detailTextLabel.textColor = dict[@"detailColor"];
        
        if ([dict[@"showArrow"] isEqualToString:@"5"]) {
            cell.detailTextLabel.text = self.cacheStr;
        }
        else {
            cell.detailTextLabel.text = dict[@"detail"];
        }
        
        return cell;
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *dict = self.titles[indexPath.section][indexPath.row];
    
    [self clickCellWithTitle:dict[@"title"]];
}

#pragma mark -cell 点击事件

- (void)clickCellWithTitle:(NSString *)title
{
    if ([title isEqualToString:@"联系我们"]) {
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"tel://400-898-7788"]]];
    }else if ([title isEqualToString:@"清除缓存"]) {
        
        kWeakSelf
        
        NSString *str = [NSString stringWithFormat:@"确定清理缓存%@",self.cacheStr];
        WJAlertView *alert = [[WJAlertView alloc] initWithTitle:@"提示" message:str cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        [alert show];
        
        [alert showWithButtonClickAction:^(NSInteger index) {
            
            if (index == 0) {
                
                [[SDImageCache sharedImageCache] clearDisk];
                
                weakSelf.cacheStr = @"";
                
                [weakSelf.tableView reloadData];
            }
        }];
        
    }
    else if ([ZNGUser userInfo].isOnline){
        if ([title isEqualToString:@"地址管理"]) {
            [self.navigationController pushViewController:[AddressListVC new] animated:YES];
        }
        else if ([title isEqualToString:@"我的消息"]) {
            [self.navigationController pushViewController:[MessageVC new] animated:YES];
        }
        else if ([title isEqualToString:@"我的收藏"]) {
            [self.navigationController pushViewController:[FavoriteListVC new] animated:YES];
        }
        else if ([title isEqualToString:@"我的优惠券"]) {
            [self.navigationController pushViewController:[CouponListVC new] animated:YES];
        }
        else if ([title isEqualToString:@"修改密码"]) {
            RetrievePassVC *vc = [[RetrievePassVC alloc] init];
            vc.phoneStr = [ZNGUser userInfo].mobile;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    else{
        [MBProgressHUD showTextMessage:@"请先登录您的账号!"];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 60;
    }
    else {
        return 44;
    }
}

- (UIWebView *)webView
{
    if (_webView == nil) {
        _webView = [[UIWebView alloc] init];
    }
    return _webView;
}

- (NSArray *)titles
{
    if (_titles == nil) {
        _titles = @[
                    @[@{@"icon" : @"11",
                        @"title" : @"11",
                        @"detail" : @"11",
                        @"showArrow" : @"",
                        @"titles" : @[
                                @{@"title" : @"待付款", @"icon" : @"indent_Changing or Refunding"},
                                @{@"title" : @"待收货", @"icon" : @"indent_For the goods"},
                                @{@"title" : @"已完成", @"icon" : @"indent_complete"},
                                @{@"title" : @"退款/换货", @"icon" : @"indent_obligation"},
                                @{@"title" : @"全部订单", @"icon" : @"drafts"}
                                ],
                        }],
                    
                    @[@{@"icon" : @"",
                        @"title" : @"我的优惠券",
                        @"detail" : @"",
                        @"showArrow" : @"1",
                        @"detailColor" : kGlobalTextColor
                        }],
                    
                    @[@{@"icon" : @"",
                        @"title" : @"我的收藏",
                        @"detail" : @"",
                        @"showArrow" : @"1",
                        @"detailColor" : kGlobalTextColor
                        }],
                    
                    @[@{@"icon" : @"",
                        @"title" : @"我的消息",
                        @"detail" : @"",
                        @"showArrow" : @"1",
                        @"detailColor" : kGlobalTextColor
                        }],
                    
                    @[@{@"icon" : @"",
                        @"title" : @"地址管理",
                        @"detail" : @"",
                        @"showArrow" : @"1",
                        @"detailColor" : kGlobalTextColor
                        }],
                    
                    @[@{@"icon" : @"",
                        @"title" : @"修改密码",
                        @"detail" : @"",
                        @"showArrow" : @"1",
                        @"detailColor" : kGlobalTextColor
                        }],
                    
                    @[@{@"icon" : @"",
                        @"title" : @"清除缓存",
                        @"detail" : @"",
                        @"showArrow" : @"5",
                        @"detailColor" : kGlobalTextColor
                        }],
                    
                    @[@{@"icon" : @"",
                        @"title" : @"联系我们",
                        @"detail" : @"400-898-7788",
                        @"showArrow" : @"0",
                        @"detailColor" : kGlobalTextColor
                        }],
                    ];
    }
    return _titles;
}

- (instancetype)init
{
    if (self) {
        self.hidesBottomBarWhenPushed = NO;
    }
    return self;
}
@end
