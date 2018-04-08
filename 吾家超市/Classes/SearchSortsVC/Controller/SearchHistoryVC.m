//
//  SearchHistoryVC.m
//  吾家超市
//
//  Created by iMac15 on 2016/11/25.
//  Copyright © 2016年 iMac15. All rights reserved.
//

#import "SearchHistoryVC.h"
#import "SearchListVC.h"

@interface SearchHistoryVC ()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>
@property (strong, nonatomic) UITextField *searchTF;
@property (strong, nonatomic) UIButton *searchBtn;
@property (strong, nonatomic) NSMutableArray *dataArray;
@end

@implementation SearchHistoryVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadTableView];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
    self.searchTF.text = nil;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    [self searchBtnClick];
    
    return YES;
}

#pragma mark -搜索点击事件
- (void)searchBtnClick
{
    [self.searchTF resignFirstResponder];
    
    if (self.searchTF.text.length == 0) {
        [MBProgressHUD showTextMessage:@"请输入关键字"];
        return;
    }
    
    BOOL isbool = [self.dataArray containsObject: self.searchTF.text];
    
    if (isbool == NO) {
        [self.dataArray insertObject:self.searchTF.text atIndex:0];
        
        NSArray *array = [NSArray arrayWithArray:self.dataArray];
        kUserDefaultSetObjectForKey(array, @"historySearchVC");
    }
    
    SearchListVC *vc = [[SearchListVC alloc] init];
    vc.keyword = self.searchTF.text;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark -清空搜索历史
- (void)clearnBtn
{
    kUserDefaultRemoveObjectForKey(@"historySearchVC");
    [self.dataArray removeAllObjects];
    self.tableView.hidden = YES;
}

- (void)loadTableView
{
    if (self.dataArray.count > 0) {
        self.tableView.hidden = NO;
        [self.tableView reloadData];
    }
    else{
        self.tableView.hidden = YES;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"搜索" style:UIBarButtonItemStylePlain target:self action:@selector(searchBtnClick)];

    [self addTheSearchBar];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
}

#pragma mark -搜索栏
- (void)addTheSearchBar
{
    UIView *navView = [[UIView alloc] init];
    navView.backgroundColor = [UIColor whiteColor];
    navView.frame = CGRectMake(0, 0, kScreenW, 44);
    self.navigationItem.titleView = navView;
    
    UIImageView *backImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"searchVC"]];
    backImage.frame = CGRectMake(0, 5, kScreenW - 115, 34);
    backImage.userInteractionEnabled = YES;
    [navView addSubview:backImage];
    
    UIImageView *picImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"searchicon"]];
    picImage.frame = CGRectMake(10, 8, 16, 15);
    [backImage addSubview:picImage];
    
    self.searchTF = [backImage addTextFieldWithPlaceholder:@"搜索商品" delegate:self target:nil action:nil];
    self.searchTF.frame = CGRectMake(CGRectGetMaxX(picImage.frame) + 5, 0, backImage.frame.size.width - 30, 34);
    [self.searchTF setBackgroundColor:[UIColor clearColor]];
    self.searchTF.returnKeyType = UIReturnKeySearch;

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
    UITableViewCell *cell = [UITableViewCell cellWithTableView:tableView reuseIdentifier:@"SearchHistoryVC"];
    
    cell.textLabel.text = [self.dataArray objectAtIndex:indexPath.row];
    [cell.textLabel setTextColor:[UIColor blackColor]];
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//选中后的反显颜色即刻消失
    SearchListVC *vc = [[SearchListVC alloc] init];

    BOOL isbool = [self.dataArray containsObject: [self.dataArray objectAtIndex:indexPath.row]];
    
    if (isbool == YES) {
        vc.keyword = [self.dataArray objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else{
        [self.dataArray addObject:[self.dataArray objectAtIndex:indexPath.row]];
        NSArray *array = [NSArray arrayWithArray:self.dataArray];
        kUserDefaultSetObjectForKey(array, @"historySearchVC");

        vc.keyword = self.searchTF.text;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, kScreenW, 44.0)] ;
    customView.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(10, 0, kScreenW, 44);
    label.textAlignment = NSTextAlignmentLeft;
    label.text = @"历史搜索";
    label.font = kFontSize(18);
    label.textColor = [UIColor blackColor];
    [customView addSubview:label];
    
    [customView addSplitLineWithFrame:CGRectMake(0, 0, kScreenW, kSplitLineHeight)];
    [customView addSplitLineWithFrame:CGRectMake(0, CGRectGetMaxY(label.frame), kScreenW, kSplitLineHeight)];
    return customView;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footView = [[UIView alloc] init];
    footView.frame = CGRectMake(0, 0, kScreenW, 54);
    footView.backgroundColor = [UIColor whiteColor];
    
    UIButton *clearnBtn = [[UIButton alloc] init];
    clearnBtn.frame = CGRectMake((kScreenW - 150)/2, 10, 150, 34);
    clearnBtn.layer.borderWidth = kSplitLineHeight;
    clearnBtn.layer.borderColor = kGlobalBackColor.CGColor;
    clearnBtn.layer.cornerRadius = 4;
    clearnBtn.layer.masksToBounds = YES;
    [clearnBtn setImage:[UIImage imageNamed:@"clean"] forState:UIControlStateNormal];
    [clearnBtn setImage:[UIImage imageNamed:@"clean"] forState:UIControlStateHighlighted];
    [clearnBtn setTitle:@"清空历史记录" forState:UIControlStateNormal];
    [clearnBtn setTitle:@"清空历史记录" forState:UIControlStateHighlighted];
    [clearnBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    clearnBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [clearnBtn setTintColor:[UIColor whiteColor]];
    [clearnBtn addTarget:self action:@selector(clearnBtn) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:clearnBtn];
    
    [footView addSplitLineWithFrame:CGRectMake(0, 0, kScreenW, kSplitLineHeight)];
    
    return footView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 44;
}

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
       NSArray * array = [NSArray arrayWithArray:kUserDefaultObjectForKey(@"historySearchVC")];
        _dataArray = [NSMutableArray arrayWithArray:[[array reverseObjectEnumerator] allObjects]];
    }
    return _dataArray;
}

@end
