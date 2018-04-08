//
//  CouponListVC.m
//  吾家超市
//
//  Created by iMac15 on 2017/1/23.
//  Copyright © 2017年 iMac15. All rights reserved.
//

#import "CouponListVC.h"
#import "CouponModel.h"
#import "CouponCellFrame.h"
#import "CouponListCell.h"
#import "CouponGoodsVC.h"
#import "HMSegmentedControl.h"
#import "OrderListModel.h"

@interface CouponListVC ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) NSMutableArray *dataArray;
@property (strong, nonatomic) UIView *placeHolder;
@property (strong, nonatomic) HMSegmentedControl *segmentControl;
@property (strong, nonatomic) NSString *typeStr;
@property (strong, nonatomic) CouponsListParam *param;
@end

@implementation CouponListVC

- (CouponsListParam *)param
{
    if (!_param) {
        _param = [[CouponsListParam alloc] init];
    }
    return _param;
}

#pragma mark -分段点击事件
- (void)segmentedControlChangedValue:(HMSegmentedControl *)segmentedControl
{
    if ((long)segmentedControl.selectedSegmentIndex == 0) { //全部
        self.typeStr = @"0";
    }
    else if ((long)segmentedControl.selectedSegmentIndex == 1){ //未使用
        self.typeStr = @"1";
    }
    else if ((long)segmentedControl.selectedSegmentIndex == 2){ //已使用
        self.typeStr = @"2";
    }
    else {                                                      //已过期
        self.typeStr = @"3";
    }
    [self loadData];
}

#pragma mark -我的优惠券
- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)loadData
{
    kWeakSelf
    //0 =  @"false";  1 = @"true";
    if ([self.typeStr isEqualToString:@"0"]) {
        self.param.isUsed = nil;
        self.param.hasExpired = nil;
    }
    else if ([self.typeStr isEqualToString:@"1"]){
        self.param.isUsed = @"false";
        self.param.hasExpired = @"false";
    }
    else if ([self.typeStr isEqualToString:@"2"]){
        self.param.isUsed = @"true";
        self.param.hasExpired = nil;
    }
    else if ([self.typeStr isEqualToString:@"3"]){
        self.param.isUsed = @"false";
        self.param.hasExpired = @"true";
    }
    
    [WJRequestTool get:kCouponCodeUrl param:self.param resultClass:[CouponModelResult class] successBlock:^(CouponModelResult *result)
     {
         if ([result.type isEqualToString:@"success"] && !kObjectIsEmpty(result.t)) {
             weakSelf.placeHolder.hidden = YES;
             [weakSelf.dataArray removeAllObjects];
             
             [weakSelf.dataArray addObjectsFromArray: [CouponCellFrame frameModelArrayWithDataArray:result.t]];
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
    self.title = @"我的优惠券";
    self.typeStr = @"0";
    [self.tableView addTopSplitLine];
    
    [self.view addSubview:self.segmentControl];
    
    self.tableView.frame = CGRectMake(0, 44, kScreenW, kScreenH - 44- kNavigationBarHeight);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = kGlobalBackgroundColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self loadData];
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
    CouponListCell *cell = [CouponListCell cellWithTableView:tableView reuseIdentifier:@"CouponListCell"];
    cell.frameModel = self.dataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CouponCellFrame *frameModel =  self.dataArray[indexPath.row];
    
    CouponGoodsVC *vc = [[CouponGoodsVC alloc] init];
    vc.titileStr = frameModel.dataModel.name;
    vc.couponIdStr = frameModel.dataModel.couponId;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CouponCellFrame *frameModel = self.dataArray[indexPath.row];
    return frameModel.cellHeight;
}

- (HMSegmentedControl *)segmentControl
{
    if (!_segmentControl) {
        _segmentControl = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"全部", @"未使用", @"已使用", @"已过期"]];
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

#pragma mark -无商品显示view
- (UIView *)placeHolder
{
    if (!_placeHolder) {
        _placeHolder = [[UIView alloc] initWithFrame:CGRectMake(0, 44, kScreenW, kScreenH - kNavigationBarHeight - 44)];
        _placeHolder.backgroundColor = kGrayBackgroundColor;
        _placeHolder.hidden = YES;
        [self.view addSubview:_placeHolder];
        
        UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenW - 100)/2, (kScreenH - 300)/2, 100, 100)];
        image.image = [UIImage imageNamed:@"favorite"];
        [_placeHolder addSubview:image];
        
        UILabel *label = [_placeHolder addLabelWithText:@"您还没有任何优惠券!" color:[UIColor grayColor]];
        label.frame = CGRectMake(0, CGRectGetMaxY(image.frame) + 10, kScreenW, 20);
        label.textAlignment = NSTextAlignmentCenter;
        
        UIButton *btn = [_placeHolder addButtonLineWithTitle:@"去商场逛逛" target:self action:@selector(goShoping)];
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
