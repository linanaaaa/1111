//
//  MessageCell.m
//  吾家超市
//
//  Created by iMac15 on 2016/12/12.
//  Copyright © 2016年 iMac15. All rights reserved.
//

#import "MessageCell.h"

@interface MessageCell()
@property (strong, nonatomic) UIImageView *image;
@property (strong, nonatomic) UILabel *detailText;
@end

@implementation MessageCell

+ (instancetype)messageCellWithTalbeView:(UITableView *)tableView
{
    NSString *indentifier = @"MessageCell";
    MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (cell == nil) {
        cell = [[MessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"xiaoxi"]];
        self.image.contentMode = UIViewContentModeScaleAspectFill;
        self.image.backgroundColor = kGlobalBackgroundColor;
        [self addSubview:self.image];
        
        self.detailText = [self addLabelWithText:@""];
        self.detailText.numberOfLines = 2;
    }
    return self;
}

- (void)setFrameModel:(MessageFrameModel *)frameModel
{
    _frameModel = frameModel;
    
    self.image.frame = frameModel.picImageF;
    self.detailText.frame = frameModel.detailF;
    
    self.detailText.text = frameModel.dataModel.content;
}

@end
