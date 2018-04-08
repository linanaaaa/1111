//
//  TypeGoodsVC.m
//  吾家网
//
//  Created by iMac15 on 2017/6/12.
//  Copyright © 2017年 iMac15. All rights reserved.
//

#import "TypeGoodsVC.h"
#import "HXTagsCell.h"
#import "OrderListModel.h"

@interface TypeGoodsVC ()<UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) UIView *bakeView;

@property (strong, nonatomic) UIView *topView;
@property (strong, nonatomic) UIImageView *picImageView;
@property (strong, nonatomic) UILabel *pirceLab;
@property (strong, nonatomic) UILabel *numberLab;
@property (strong, nonatomic) UIButton *addCarBtn;

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *typeGoodsArray;
@property (nonatomic,strong) HXTagCollectionViewFlowLayout *layout;//布局layout
@property (nonatomic,strong) NSArray *selectTags;
@end

@implementation TypeGoodsVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadData];
}

- (void)loadData
{
    kWeakSelf
    
    [WJRequestTool get:kCategoryUrl param:@{@"id":@"719"} resultClass:[SortsLevelResult class] successBlock:^(SortsLevelResult *result)
     {
         [weakSelf.typeGoodsArray removeAllObjects];
         
         
         weakSelf.typeGoodsArray = [NSMutableArray arrayWithCapacity:result.t.children.count];
         for (OrderItems *dataModel in result.t.children)
         {
             [weakSelf.typeGoodsArray addObject:dataModel];
         }
         
//         [weakSelf.dataArray addObjectsFromArray: [SortsLevelFrame frameModelArrayWithDataArray:result.t.children]];
         [weakSelf.tableView reloadData];
         
     } failure:^(NSError *error) {
         
     }];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.bakeView];
    
    [self topGoodsView];
    [self.bakeView addSubview:self.tableView];
}

- (HXTagCollectionViewFlowLayout *)layout {
    if (!_layout) {
        _layout = [HXTagCollectionViewFlowLayout new];
        _layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    }
    return _layout;
}


#pragma mark UITableViewDataSource/UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.typeGoodsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HXTagsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    if (!cell) {
        cell = [[HXTagsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellId"];
    }
    
    cell.tags = self.typeGoodsArray[indexPath.row];
    
    cell.selectedTags = [NSMutableArray arrayWithArray:_selectTags];
    cell.layout = self.layout;
    cell.completion = ^(NSArray *selectTags,NSInteger currentIndex) {
        NSLog(@"selectTags:%@ currentIndex:%ld",selectTags, (long)currentIndex);
        _selectTags = selectTags;
        
    };
    [cell reloadData];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    float height = [HXTagsCell getCellHeightWithTags:self.typeGoodsArray[indexPath.row] layout:self.layout tagAttribute:nil width:tableView.frame.size.width];
    return height;
}


- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 70, kScreenW, kScreenH - 310) style:UITableViewStylePlain];
        _tableView.backgroundColor = kGrayBackgroundColor;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.separatorColor = kGlobalLineColor;
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}


- (NSMutableArray *)typeGoodsArray
{
    if (!_typeGoodsArray) {
        _typeGoodsArray = [NSMutableArray array];
    }
    return _typeGoodsArray;
}

#pragma mark -商品视图
- (void)topGoodsView
{
    self.topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW - 30, 70)];
    self.topView.backgroundColor = [UIColor whiteColor];
    [self.bakeView addSubview:self.topView];
    
    [self.topView addSplitLineWithFrame:CGRectMake(0, 70, kScreenW, kSplitLineHeight)];
    
    self.picImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, -20, 80, 80)];
    self.picImageView.backgroundColor = [UIColor whiteColor];
    [self.picImageView sd_setImageWithURL:[NSURL URLWithString:self.dataModel.image] placeholderImage:[UIImage imageNamed:@"shangpin_bg"]];
    self.picImageView.layer.cornerRadius = self.picImageView.frame.size.width / 10;
    self.picImageView.layer.masksToBounds = YES;
    [self.topView addSubview:self.picImageView];
    
    NSString *price = [NSString stringWithFormat:@"¥ %@",self.dataModel.price];
    self.pirceLab = [self.topView addLabelWithText:price color:[UIColor redColor]];
    self.pirceLab.frame = CGRectMake(CGRectGetMaxX(self.picImageView.frame) + 10, 20, kScreenW - 130, 20);
    
    NSString *number = [NSString stringWithFormat:@"商品编号: %@",self.dataModel.sn];
    self.numberLab = [self.topView addLabelWithText:number];
    self.numberLab.frame = CGRectMake(CGRectGetMaxX(self.picImageView.frame) + 10, CGRectGetMaxY(self.pirceLab.frame), kScreenW - 130, 20);
}

- (UIView *)bakeView
{
    if (!_bakeView) {
        _bakeView = [UIView new];
        _bakeView.frame = CGRectMake(0, 200, kScreenW, kScreenH - 200);
        _bakeView.backgroundColor = [UIColor whiteColor];
        
        UIButton *closeBtn = [_bakeView addButtonWithTitle:@"X" target:self action:@selector(closeClick)];
        closeBtn.frame = CGRectMake(kScreenW - 30, 10, 20, 20);
        
        _addCarBtn = [_bakeView addButtonFilletWithTitle:@"加入购物车" target:self action:@selector(addCarClick)];
        _addCarBtn.frame = CGRectMake(0, kScreenH - 240, kScreenW, 40);
        _addCarBtn.layer.cornerRadius = 0;
    }
    return _bakeView;
}

#pragma mark -加入购物车
- (void)addCarClick
{
    
}

- (void)closeClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
