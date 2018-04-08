//
//  ChooseAddressVC.m
//  吾家网
//
//  Created by HuaCapf on 2017/6/17.
//  Copyright © 2017年 iMac15. All rights reserved.
//

#import "ChooseAddressVC.h"
#import "AddressModel.h"

@interface ChooseAddressVC ()<UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) HXTagsView *tagsView;
@property (strong, nonatomic) NSMutableArray *tagsArray;      //选中地址-标签数组

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *dataArray;

@property (strong, nonatomic) NSString *parentIdStr;
@property (strong, nonatomic) NSIndexPath *selectPath;         //存放被点击的哪一行的标志

@property (strong, nonatomic) NSMutableArray *selectAddArray;  //存放选中地址
@property (strong, nonatomic) NSMutableArray *selectCodeArray; //存放选中地址id;

@property (strong, nonatomic) UIView *bakeView;

@end

@implementation ChooseAddressVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.parentIdStr = @"";
    [self loadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"请选择";
    [self.view addSubview:self.bakeView];
    [self.bakeView addSubview:self.tagsView];
    [self.bakeView addSubview:self.tableView];
}

#pragma mark - 获取用户地址信息
- (void)loadData
{
    kWeakSelf
    self.selectPath = nil;
    NSDictionary *param = @{@"parentId":self.parentIdStr};
    [WJRequestTool get:kAreaaAdrressUrl param:param resultClass:[AddressChooseResult class] successBlock:^(AddressChooseResult *result)
     {
         if (!kArrayIsEmpty(result.t)) {
             [weakSelf.dataArray removeAllObjects];
             
             weakSelf.dataArray = [NSMutableArray arrayWithCapacity:result.t.count];
             
             for (AddressChooseModel *model in result.t)
             {
                 [weakSelf.dataArray addObject:model];
             }
             
             [weakSelf.tableView reloadData];
         }
         else{
             WJLog(@"地址移到最后一个字段");
             
             if (!kArrayIsEmpty(weakSelf.selectAddArray) & !kStringIsEmpty(weakSelf.parentIdStr)) {
                 
                 NSString *addressStr = @"";
                 
                 for (int i = 0; i < weakSelf.selectAddArray.count; i++) {
                     addressStr = [addressStr stringByAppendingFormat:@"%@",[weakSelf.selectAddArray objectAtIndex:i]];
                 }
                 WJLog(@"选中的地址 --%@ \n 选中 地址 id -- %@",addressStr, weakSelf.parentIdStr);
                 
                 if (weakSelf.chooseEditAdd) {
                     weakSelf.chooseEditAdd(addressStr, weakSelf.parentIdStr);
                 }
                 
                 [weakSelf closeClick];
             }
         }
         
         [weakSelf.tableView setContentOffset:CGPointMake(0, 0) animated:YES];
         
     } failure:^(NSError *error) {
         
     }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"UITableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    
    if (_selectPath == indexPath) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    AddressChooseModel *model = [[AddressChooseModel alloc] init];
    model = self.dataArray[indexPath.row];
    
    cell.textLabel.text = model.name;
    cell.tintColor = [UIColor redColor];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    int newRow = (int)[indexPath row];
    int oldRow = (int)(_selectPath != nil) ? (int)[_selectPath row]:-1;
    if (newRow != oldRow) {
        UITableViewCell *newCell = [tableView cellForRowAtIndexPath:indexPath];
        newCell.accessoryType = UITableViewCellAccessoryCheckmark;
        
        UITableViewCell *oldCell = [tableView cellForRowAtIndexPath:_selectPath];
        oldCell.accessoryType = UITableViewCellAccessoryNone;
        _selectPath = [indexPath copy];
    }
    
    AddressChooseModel *model = [[AddressChooseModel alloc] init];
    model = self.dataArray[indexPath.row];
    
    if (self.tagsArray.count == 1 && [[self.tagsArray objectAtIndex:0] isEqualToString:@"请选择"]) {
        [self.tagsArray removeAllObjects];
        [self.tagsArray addObject:model.name];
        [self.tagsView reloadData];
        
        [self.selectAddArray removeAllObjects];
        [self.selectAddArray addObject:model.name];
    }
    else{
        [self.tagsArray addObject:model.name];
        [self.tagsView reloadData];
        
        [self.selectAddArray addObject:model.name];
    }
    
    self.parentIdStr = model.id;
    [self loadData];
}

- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 90, kScreenW, kScreenH - 340) style:UITableViewStylePlain];
        _tableView.backgroundColor = kGrayBackgroundColor;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.separatorColor = kGlobalLineColor;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _tableView.tableFooterView = [[UIView alloc] init];
    }
    return _tableView;
}

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

#pragma mark - 选中地址标签view
- (HXTagsView *)tagsView
{
    if (!_tagsView) {
        _tagsView = [[HXTagsView alloc] initWithFrame:CGRectMake(0, 40, kScreenW, 50)];
        _tagsView.tags = self.tagsArray;
        [_tagsView addBottomSplitLine];
        
        kWeakSelf
        _tagsView.completion = ^(NSArray *selectTags,NSInteger currentIndex)
        {
            WJLog(@"%@",selectTags);
            weakSelf.parentIdStr = @"";
            [weakSelf.tagsArray removeAllObjects];
            [weakSelf.selectAddArray removeAllObjects];
            [weakSelf.tagsArray addObject:@"请选择"];
            [weakSelf loadData];
        };
    }
    return _tagsView;
}

- (NSMutableArray *)tagsArray
{
    if (!_tagsArray) {
        _tagsArray = [NSMutableArray arrayWithObject:@"请选择"];
    }
    return _tagsArray;
}

- (NSMutableArray *)selectAddArray
{
    if (!_selectAddArray) {
        _selectAddArray = [NSMutableArray array];
    }
    return _selectAddArray;
}

- (NSMutableArray *)selectCodeArray
{
    if (!_selectCodeArray) {
        _selectCodeArray = [NSMutableArray array];
    }
    return _selectCodeArray;
}

#pragma mark - 基view
- (UIView *)bakeView
{
    if (!_bakeView) {
        _bakeView = [UIView new];
        _bakeView.frame = CGRectMake(0, 250, kScreenW, kScreenH - 250);
        _bakeView.backgroundColor = [UIColor whiteColor];
        
        [_bakeView addTopSplitLine];
        
        UILabel *lab = [_bakeView addLabelWithText:@"配送至" color:[UIColor grayColor]];
        lab.frame = CGRectMake(0, 10, kScreenW - 40, 20);
        lab.textAlignment = NSTextAlignmentCenter;
        
        UIButton *closeBtn = [_bakeView addButtonWithTitle:@"X" target:self action:@selector(closeClick)];
        closeBtn.frame = CGRectMake(kScreenW - 30, 10, 20, 20);
    }
    return _bakeView;
}

- (void)closeClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
