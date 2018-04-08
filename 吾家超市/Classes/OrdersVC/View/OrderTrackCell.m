//
//  OrderTrackCell.m
//  吾家超市
//
//  Created by iMac15 on 2017/2/15.
//  Copyright © 2017年 iMac15. All rights reserved.
//

#import "OrderTrackCell.h"

@interface OrderTrackCell()
@property (strong, nonatomic) UILabel *time;
@property (strong, nonatomic) UILabel *context;
@end

@implementation OrderTrackCell

+ (instancetype)OrderTrackCellWithTableView:(UITableView *)tableView
{
    NSString *indentifier = @"OrderTrackCell";
    OrderTrackCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (cell == nil) {
        cell = [[OrderTrackCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        
        self.time = [self addLabelWithText:@""];
        
        self.context = [self addLabelWithText:@""];
        [self.context setNumberOfLines:0];
    }
    return self;
}

- (void)setFrameModel:(OrderTrackFrame *)frameModel
{
    _frameModel = frameModel;
    
    self.time.frame = frameModel.timeF;
    self.context.frame = frameModel.textF;
    
    self.time.text = frameModel.dataModel.createTime;
    self.context.text = frameModel.dataModel.opInfo;
}

@end
