//
//  SortsLevelVC.m
//  吾家超市
//
//  Created by iMac15 on 2017/1/13.
//  Copyright © 2017年 iMac15. All rights reserved.
//

#import "SortsLevelVC.h"
#import "GoodsModel.h"
#import "SortsLevelFrame.h"
#import "SortsLevelCell.h"

#import "SortsListVC.h"
#import "BrandsListVC.h"

#import "HXTagsView.h"

@interface SortsLevelVC ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) NSMutableArray *dataArray;

@property (strong, nonatomic) HXTagsView *tagsView;
@property (strong, nonatomic) NSMutableArray *tagssArray;
@end

@implementation SortsLevelVC

- (void)loadData
{
    kWeakSelf
    [WJRequestTool get:kCategoryUrl param:@{@"id":self.idLevelStr} resultClass:[SortsLevelResult class] successBlock:^(SortsLevelResult *result)
     {
         [weakSelf.dataArray removeAllObjects];
         
         [weakSelf.dataArray addObjectsFromArray: [SortsLevelFrame frameModelArrayWithDataArray:result.t.children]];
         
        [weakSelf.tableView reloadData];
         
     } failure:^(NSError *error) {
         
     }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"分类";
    [self.view addSplitLineWithFrame:CGRectMake(0, 0, kScreenW, kSplitLineHeight)];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = kColor(245.0f, 246.0f, 247.0f);
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
    NSString *CellIdentifier = [NSString stringWithFormat:@"cell%ld%ld",indexPath.section,indexPath.row];
    SortsLevelCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[SortsLevelCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    cell.frameModel = self.dataArray[indexPath.row];
    
    //获取cell items
    [self.tagssArray removeAllObjects];
    
    for (int i = 0; i<cell.frameModel.dataModel.children.count; i++)
    {
        NSMutableArray *array = [NSMutableArray array];
        [array addObject: [cell.frameModel.dataModel.children objectAtIndex:i]];
        
        for (SortsLevelData *dataTag in array)
        {
            if ([dataTag.isPullOff isEqualToString:@"0"]) {
                [self.tagssArray addObject:dataTag.name];
            }
        }
    }
    self.tagsView.tags = self.tagssArray;
    
    kWeakSelf
    cell.leftSBtnClick = ^(NSString *tagViewId, NSString *tagViewSSId, NSString *tagViewStr)
    {
        WJLog(@"tagViewId : %@\n tagViewSSId:%@\n tagViewStr:%@\n",tagViewId,tagViewSSId,tagViewStr);
        
        SortsListVC *vc = [[SortsListVC alloc] init];
        vc.title = tagViewStr;
        vc.isTypeGrid = YES;
        vc.sortId = tagViewId;
        vc.sortSid = tagViewSSId;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    
    [cell.tagsView reloadData];

    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    SortsLevelFrame *frameModel = self.dataArray[indexPath.row];
//    return frameModel.cellHeight;
    
    CGFloat height = [HXTagsView getHeightWithTags:self.tagsView.tags layout:self.tagsView.layout tagAttribute:self.tagsView.tagAttribute width:kScreenW];
    
    return height + 45;
}

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (HXTagsView *)tagsView
{
    if (!_tagsView) {
        _tagsView = [[HXTagsView alloc] init];
        _tagsView.layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _tagsView.hidden = YES;
        [self.view addSubview:_tagsView];
    }
    return _tagsView;
}

- (NSMutableArray *)tagssArray
{
    if (!_tagssArray) {
        _tagssArray = [NSMutableArray array];
    }
    return _tagssArray;
}

@end
