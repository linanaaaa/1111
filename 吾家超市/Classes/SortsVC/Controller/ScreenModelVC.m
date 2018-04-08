//
//  ScreenModelVC.m
//  吾家超市
//
//  Created by iMac15 on 2017/1/13.
//  Copyright © 2017年 iMac15. All rights reserved.
//

#import "ScreenModelVC.h"
#import "BrandListModel.h"
#import "GSFilterView.h"
#import "GSMacros.h"

@interface ScreenModelVC ()<DKFilterViewDelegate,UIAlertViewDelegate,UITextFieldDelegate>
@property (strong, nonatomic) GSFilterView *filterView;

@property (strong, nonatomic) DKFilterModel *brandsModel;       //品牌
@property (strong, nonatomic) NSMutableArray *brandsDataArray;  //品牌 数组
@property (strong, nonatomic) NSMutableArray *brandsArray;      //品牌名称 数组
@property (strong, nonatomic) NSString *brandsString;
@property (strong, nonatomic) NSString *brandsId;

//@property (strong, nonatomic) DKFilterModel *typeModel;         //类型
//@property (strong, nonatomic) NSMutableArray *typeDataArray;
//@property (strong, nonatomic) NSString *typeString;

@property (strong, nonatomic) UIView *topView;
@property (strong, nonatomic) UITextField *startField;
@property (strong, nonatomic) UITextField *endField;
@end


@implementation ScreenModelVC

-(void)viewDidAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadData];
}

#pragma mark -获取全部品牌
- (void)loadData
{
    kWeakSelf
    NSDictionary *param = @{@"productCategoryId":self.screenId};
    
    [WJRequestTool get:kCateBrandUrl param:param resultClass:[BrandListResult class] successBlock:^(BrandListResult *result)
     {
         weakSelf.brandsDataArray = [NSMutableArray arrayWithArray:result.t];
         
         for (BrandListModel *dataModel in result.t) {
             
             [weakSelf.brandsArray addObject:dataModel.name];
         }
     
         weakSelf.brandsModel.title = @"品牌";
         [weakSelf.filterView setFilterModels:@[weakSelf.brandsModel]];
         
         [weakSelf.filterView.tableView reloadData];
         
     } failure:^(NSError *error) {
         
     }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"筛选";
    self.view.backgroundColor = kGlobalBackgroundColor;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cleanClick)];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.modalPresentationCapturesStatusBarAppearance = NO;
    
    self.topView = [UIView contentViewWithSplitLine];
    self.topView.frame = CGRectMake(0, 0, kScreenW, 70);
    self.topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.topView];
    
    UILabel *label = [self.topView addLabelWithText:@"价格区间" color:[UIColor blackColor]];
    label.frame = CGRectMake(10, 10, kScreenW - 20, 20);
    
    self.startField = [self.topView addTextFieldWithPlaceholder:@"最低价" delegate:self target:self action:nil];
    self.startField.frame = CGRectMake(10, CGRectGetMaxY(label.frame)+10, (kScreenW - 60)/2, 20);
    self.startField.backgroundColor = kGlobalBackgroundColor;
    self.startField.textAlignment = NSTextAlignmentCenter;
    self.startField.borderStyle = UITextBorderStyleRoundedRect;
    self.startField.keyboardType = UIKeyboardTypeNumberPad;
    
    UILabel *centerLabel = [self.topView addLabelWithText:@"---" color:[UIColor blackColor]];
    centerLabel.frame = CGRectMake(CGRectGetMaxX(self.startField.frame) + 10, CGRectGetMaxY(label.frame)+10, 20, 20);
    
    self.endField = [self.topView addTextFieldWithPlaceholder:@"最高价" delegate:self target:self action:nil];
    self.endField.frame = CGRectMake(kScreenW - (kScreenW - 60)/2 - 10, CGRectGetMaxY(label.frame)+10, (kScreenW - 60)/2, 20);
    self.endField.backgroundColor = kGlobalBackgroundColor;
    self.endField.textAlignment = NSTextAlignmentCenter;
    self.endField.borderStyle = UITextBorderStyleRoundedRect;
    self.endField.keyboardType = UIKeyboardTypeNumberPad;
    
    self.filterView = [[GSFilterView alloc] initWithFrame:CGRectMake(0, 80, kScreenW, kScreenH - 44- 54 - 80)];
    self.filterView.delegate = self;
    [self.view addSubview:self.filterView];
    
    UIButton *filterButton = [[UIButton alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT -104, SCREEN_WIDTH, 44)];
    filterButton.backgroundColor = GS_SELECTBACKGROUND_COLOR;
    [filterButton setTitle:@"提交" forState:UIControlStateNormal];
    [filterButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [filterButton addTarget:self action:@selector(brandsStrClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:filterButton];
}

- (void)didClickAtModel:(DKFilterModel *)data{
    if (data == self.brandsModel) {
        self.brandsString = data.clickedButtonText;
        WJLog(@"选择品牌--%@",self.brandsString);
        
        for (BrandListModel *dataModel in self.brandsDataArray) {
            
            if ([dataModel.name isEqualToString:self.brandsString]) {
                self.brandsId = dataModel.id;
                WJLog(@"品牌id: %@",self.brandsId);
            }
        }
    }
}

#pragma mark -提交筛选
- (void)brandsStrClick
{
    if (self.screenModelClick) {
        self.screenModelClick(self.brandsId,self.startField.text,self.endField.text);
    }
    
    [self dismissViewControllerAnimated:YES completion:^{ }];
}

- (DKFilterModel *)brandsModel
{
    if (!_brandsModel) {
        _brandsModel = [[DKFilterModel alloc] initElement:self.brandsArray ofType:DK_SELECTION_SINGLE];
        _brandsModel.style = DKFilterViewDefault;
    }
    return  _brandsModel;
}

- (NSMutableArray *)brandsDataArray
{
    if (!_brandsDataArray) {
        _brandsDataArray = [NSMutableArray array];
    }
    return _brandsDataArray;
}

- (NSMutableArray *)brandsArray
{
    if (!_brandsArray) {
        _brandsArray = [NSMutableArray array];
    }
    return _brandsArray;
}

//- (DKFilterModel *)typeModel
//{
//    if (!_typeModel) {
//        _typeModel = [[DKFilterModel alloc] initElement:self.typeDataArray ofType:DK_SELECTION_SINGLE];
//        _typeModel.style = DKFilterViewDefault;
//    }
//    return _typeModel;
//}
//
//- (NSMutableArray *)typeDataArray
//{
//    if (!_typeDataArray) {
//        _typeDataArray = [NSMutableArray array];
//    }
//    return _typeDataArray;
//}

- (void)cleanClick
{
    [self dismissViewControllerAnimated:YES completion:^{ }];
}

/*
 
 [MBProgressHUD showLoadingMessage];
 
 dispatch_group_t group = dispatch_group_create();
 
 NSDictionary *param = @{@"productCategoryId":self.screenId};
 
 dispatch_group_enter(group);
 [WJRequestTool get:kCateAttributeUrl param:param resultClass:[BrandListResult class] successBlock:^(BrandListResult *result)
 {
 for (BrandListModel *dataModel in result.t) {
 
 [weakSelf.typeDataArray addObject:dataModel.name];
 }
 
 dispatch_group_leave(group);
 } failure:^(NSError *error) {
 dispatch_group_leave(group);
 }];
 
 dispatch_group_enter(group);
 [WJRequestTool get:kCateBrandUrl param:param resultClass:[BrandListResult class] successBlock:^(BrandListResult *result)
 {
 weakSelf.brandsDataArray = [NSMutableArray arrayWithArray:result.t];
 
 for (BrandListModel *dataModel in result.t) {
 
 [weakSelf.brandsArray addObject:dataModel.name];
 }
 
 dispatch_group_leave(group);
 } failure:^(NSError *error) {
 dispatch_group_leave(group);
 }];
 
 //返回主线程-刷新UI
 dispatch_group_notify(group, dispatch_get_main_queue(), ^{
 
 if (kArrayIsEmpty(weakSelf.typeDataArray)){
 [weakSelf.filterView setFilterModels:@[weakSelf.brandsModel]];
 weakSelf.brandsModel.title = @"品牌";
 
 }
 else  if (kArrayIsEmpty(weakSelf.brandsArray)){
 [weakSelf.filterView setFilterModels:@[weakSelf.typeModel]];
 weakSelf.typeModel.title = @"类型";
 }
 else if (!kArrayIsEmpty(weakSelf.typeDataArray) && !kArrayIsEmpty(weakSelf.brandsArray)) {
 weakSelf.brandsModel.title = @"品牌";
 weakSelf.typeModel.title = @"类型";
 [weakSelf.filterView setFilterModels:@[weakSelf.typeModel, weakSelf.brandsModel]];
 }
 
 [weakSelf.filterView.tableView reloadData];
 
 [MBProgressHUD hideHUD];
 });
 
 */

@end

