//
//  BrandsListVC.m
//  吾家超市
//
//  Created by iMac15 on 2017/1/10.
//  Copyright © 2017年 iMac15. All rights reserved.
//

#import "BrandsListVC.h"
#import "BrandListModel.h"
#import "BMChineseSort.h"
#import "SortsListVC.h"

@interface BrandsListVC ()<UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) NSMutableArray *dataArray;
@property (strong, nonatomic) NSMutableArray *indexArray;       //排序后的出现过的拼音首字母数组
@property (strong, nonatomic) NSMutableArray *letterResultArr;  //排序好的结果数组
@end

@implementation BrandsListVC

#pragma mark -加载全部品牌
- (void)loadData
{
    kWeakSelf
    [WJRequestTool get:kCateBrandUrl param:nil resultClass:[BrandListResult class] successBlock:^(BrandListResult *result)
    {
        weakSelf.dataArray  = [NSMutableArray arrayWithArray:result.t];
        
        //根据Person对象的 name 属性 按中文 对 Person数组 排序
        weakSelf.indexArray = [BMChineseSort IndexWithArray:weakSelf.dataArray Key:@"name"];
        weakSelf.letterResultArr = [BMChineseSort sortObjectArray:weakSelf.dataArray Key:@"name"];
        
        [weakSelf.tableView reloadData];
        
    } failure:^(NSError *error) {
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"全部品牌";
    self.view.backgroundColor = kGlobalBackColor;

    [self.view addSplitLineWithFrame:CGRectMake(0, 0, kScreenW, kSplitLineHeight)];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorColor = kGlobalLineColor;
    self.tableView.sectionIndexColor = kGlobalTextColor;
    
    [self loadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//选中后的反显颜色即刻消失
    
    BrandListModel *model = [[self.letterResultArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    SortsListVC *vc = [[SortsListVC alloc] init];
    vc.title = model.name;
    vc.sortId = model.id;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UITabelViewDataSource
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [self.indexArray objectAtIndex:section];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.indexArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[self.letterResultArr objectAtIndex:section] count];
}

-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return self.indexArray;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    return index;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [UITableViewCell cellWithTableView:tableView reuseIdentifier:@"BrandListCell"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.textAlignment = NSTextAlignmentLeft;
    
    BrandListModel *model = [[self.letterResultArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];

    cell.textLabel.text = model.name;
    cell.textLabel.font = kTextFont;
    cell.textLabel.textColor = kGlobalTextColor;
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

@end
