//
//  MessageVC.m
//  吾家超市
//
//  Created by iMac15 on 2016/12/12.
//  Copyright © 2016年 iMac15. All rights reserved.
//

#import "MessageVC.h"
#import "MessageFrameModel.h"
#import "MessageModel.h"
#import "MessageCell.h"

@interface MessageVC ()<UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) NSMutableArray *dataArray;
@property (strong, nonatomic) UIView *placeHolder;
@end

@implementation MessageVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadMessage];
}

#pragma mark -我的消息
- (void)loadMessage
{
    kWeakSelf
    
    [WJRequestTool get:kMessageListUrl param:nil resultClass:[MessageResult class] successBlock:^(MessageResult *result)
     {
        [weakSelf.dataArray removeAllObjects];
         
        [weakSelf.dataArray addObjectsFromArray: [MessageFrameModel frameModelArrayWithDataArray:result.t]];
        [weakSelf.tableView reloadData];
         
         if (kArrayIsEmpty(weakSelf.dataArray)) {
             weakSelf.placeHolder.hidden = NO;
         }
         
     } failure:^(NSError *error) {
         
     }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的消息";
    [self.view addTopSplitLine];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:self.placeHolder];
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
    MessageCell *cell = [MessageCell cellWithTableView:tableView reuseIdentifier:@"MessageCell"];
    cell.frameModel = self.dataArray[indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessageFrameModel *frameModel = self.dataArray[indexPath.row];
    return frameModel.cellHeight;
}

#pragma mark -无消息显示view
- (UIView *)placeHolder
{
    if (!_placeHolder) {
        _placeHolder = [[UIView alloc] initWithFrame:self.view.bounds];
        _placeHolder.backgroundColor = kGrayBackgroundColor;
        _placeHolder.hidden = YES;
        
        UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenW - 100)/2, (kScreenH - 300)/2, 100, 100)];
        image.image = [UIImage imageNamed:@"message"];
        [_placeHolder addSubview:image];
        
        UILabel *label = [_placeHolder addLabelWithText:@"暂时木有消息哦!" color:[UIColor grayColor]];
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
