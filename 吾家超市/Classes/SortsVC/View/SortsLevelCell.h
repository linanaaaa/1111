//
//  SortsLevelCell.h
//  吾家超市
//
//  Created by iMac15 on 2017/1/13.
//  Copyright © 2017年 iMac15. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SortsLevelFrame.h"
#import "GoodsModel.h"
#import "HXTagsView.h"

@interface SortsLevelCell : UITableViewCell

+ (instancetype)sortsLevelCellWithTableView:(UITableView *)tableView;

@property (copy, nonatomic) void (^leftSBtnClick)(NSString *tagViewId, NSString *tagViewSSId, NSString *tagViewStr);

@property (strong, nonatomic) SortsLevelFrame *frameModel;
@property (strong, nonatomic) HXTagsView *tagsView;
@end
