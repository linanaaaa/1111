//
//  OrderTrackingVC.m
//  吾家超市
//
//  Created by iMac15 on 2017/2/15.
//  Copyright © 2017年 iMac15. All rights reserved.
//

#import "OrderTrackingVC.h"
#import "OrderListModel.h"
#import "OrderTrackFrame.h"
#import "OrderTrackCell.h"

@interface OrderTrackingVC ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) NSMutableArray *dataArray;
@property (strong, nonatomic) UIView *placeHolder;
@end

@implementation OrderTrackingVC

#pragma mark -加载订单跟踪
- (void)loadData
{
    kWeakSelf
    NSDictionary *param = @{@"sn":self.orderTrackSN};
    [WJRequestTool get:kOrderTrackUrl param:param resultClass:[OrderTrackResult class] successBlock:^(OrderTrackResult *result)
     {
         if ([result.type isEqualToString:@"success"] && !kObjectIsEmpty(result.t)) {
             weakSelf.placeHolder.hidden = YES;
             [weakSelf.dataArray removeAllObjects];
             
             [weakSelf.dataArray addObjectsFromArray: [OrderTrackFrame frameModelArrayWithDataArray:result.t.orderTrack]];
             [weakSelf.tableView reloadData];
         }
         else{
             weakSelf.placeHolder.hidden = NO;
         }         
     } failure:^(NSError *error) {
         
     }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单跟踪";
    [self.view addTopSplitLine];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    [self loadData];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderTrackCell *cell = [OrderTrackCell cellWithTableView:tableView reuseIdentifier:@"OrderTrackCell"];
    cell.frameModel = self.dataArray[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderTrackFrame *frameModel = self.dataArray[indexPath.row];
    return frameModel.cellHeight;
}

#pragma mark -无消息显示view
- (UIView *)placeHolder
{
    if (!_placeHolder) {
        _placeHolder = [[UIView alloc] initWithFrame:self.view.bounds];
        _placeHolder.backgroundColor = kGrayBackgroundColor;
        _placeHolder.hidden = YES;
        [self.view addSubview:_placeHolder];
        
        UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenW - 100)/2, (kScreenH - 300)/2, 100, 100)];
        image.image = [UIImage imageNamed:@"message"];
        [_placeHolder addSubview:image];
        
        UILabel *label = [_placeHolder addLabelWithText:@"暂时木有物流消息哦!" color:[UIColor grayColor]];
        label.frame = CGRectMake(0, CGRectGetMaxY(image.frame) + 10, kScreenW, 20);
        label.textAlignment = NSTextAlignmentCenter;
    }
    return _placeHolder;
}

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

@end
