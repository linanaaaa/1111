//
//  OrderOptionsCell.m
//  吾家超市
//
//  Created by iMac15 on 2016/10/26.
//  Copyright © 2016年 iMac15. All rights reserved.
//

#import "OrderOptionsCell.h"
#import "WJBadgeButton.h"

@interface OrderOptionsCell()
@property(nonatomic, assign, readwrite)OrderOptionType type;
@property (strong, nonatomic) UIView * line;
@property (strong, nonatomic) NSMutableArray * btnArray;
@end

@implementation OrderOptionsCell

+ (instancetype)optionCellWithTableView:(UITableView *)tableView
{
    OrderOptionsCell *cell = [[OrderOptionsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"OrderOptionCell"];
    
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setBtnTitles:(NSArray *)btnTitles
{
    _btnTitles = btnTitles;
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    for (int i = 0; i < btnTitles.count; i++) {
        WJBadgeButton *btn = [[WJBadgeButton alloc] init];
        [btn setTitle:btnTitles[i][@"title"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnDidClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.imageView.contentMode = UIViewContentModeBottom;
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        btn.titleLabel.font = kFontSize(13.0);
        btn.style = BadgeButtonStyleTopImage;
        btn.tag = i + 2;
        [self addSubview:btn];
        
        [self.btnArray addObject:btn];
        
        btn.badgeValue = self.badgeValues[i];
        
        UIImage *image = [UIImage imageNamed:btnTitles[i][@"icon"]];
        [btn setImage:image forState:UIControlStateNormal];
        if (i == btnTitles.count - 1) {
            [btn setTitleColor:kGlobalRedColor forState:UIControlStateNormal];
        }
        else {
            [btn setTitleColor:kGlobalTextColor forState:UIControlStateNormal];
        }
    }
}

//- (void)setBadgeValues:(NSArray *)badgeValues
//{
//    _badgeValues = badgeValues;
//
//    for (int i = 0; i < badgeValues.count; i++) {
//        BadgeButton *btn = self.subviews[i];
//        btn.badgeValue = badgeValues[i];
//    }
//}

- (void)btnDidClick:(UIButton *)button
{
    self.type = button.tag;
    WJLog(@"%@", button.titleLabel.text);
    if (self.click) {
        self.click(self.type);
    }
}

- (NSMutableArray *)btnArray
{
    if (_btnArray == nil) {
        _btnArray = [[NSMutableArray alloc] init];
    }
    return _btnArray;
}

- (UIView *)line
{
    if (_line == nil) {
        
        _line = [UIView line];
        
        [self addSubview:_line];
    }
    return _line;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat btnW = self.frame.size.width / self.btnTitles.count;
    CGFloat btnH = self.frame.size.height;
    CGFloat btnX = 0;
    CGFloat btnY = 0;
    for (int i = 0; i < self.btnTitles.count; i++) {
        btnX = i * btnW;
        
        UIButton *btn = self.btnArray[i];
        
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        
        if (i == self.btnTitles.count - 1) {
            self.line.frame = CGRectMake(btnX, 0, kSplitLineHeight, self.frame.size.height);
        }
    }
}
@end

