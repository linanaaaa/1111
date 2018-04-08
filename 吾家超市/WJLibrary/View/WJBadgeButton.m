//
//  WJBadgeButton.m
//  吾家超市
//
//  Created by iMac15 on 2016/10/26.
//  Copyright © 2016年 iMac15. All rights reserved.
//

#import "WJBadgeButton.h"

@interface WJBadgeButton()
@property(nonatomic, weak)UILabel *badgeLabel;
@end

@implementation WJBadgeButton

- (instancetype)init
{
    if (self = [super init]) {
        [self addBadgeLabel];
        
        self.adjustsImageWhenHighlighted = NO;
        self.adjustsImageWhenDisabled = NO;
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self addBadgeLabel];
}

- (void)addBadgeLabel
{
    UILabel *badge = [[UILabel alloc] init];
    badge.backgroundColor = kGlobalRedColor;
    badge.layer.masksToBounds = YES;
    //    badge.layer.borderColor = [UIColor whiteColor].CGColor;
    //    badge.layer.borderWidth = kSplitLineHeight;
    
    badge.textAlignment = NSTextAlignmentCenter;
    badge.textColor = [UIColor whiteColor];
    badge.font = kFontSize(10.0);
    badge.layer.masksToBounds = YES;
    self.badgeLabel = badge;
    [self addSubview:badge];
    badge.hidden = YES;
}

- (void)setHideBadgeValue:(BOOL)hideBadgeValue
{
    _hideBadgeValue = hideBadgeValue;
    
    self.badgeLabel.hidden = hideBadgeValue;
}

- (void)setBadgeValue:(NSString *)badgeValue
{
    _badgeValue = badgeValue.integerValue > 99 ? @"99+" : badgeValue;
    if (badgeValue.integerValue > 0) {
        self.badgeLabel.text = badgeValue;
        self.badgeLabel.hidden = self.hideBadgeValue;
        
        [self insertSubview:self.badgeLabel aboveSubview:self.titleLabel];
    }
    else {
        self.badgeLabel.text = @"";
        self.badgeLabel.hidden = YES;
    }
    //    self.badgeLabel.text = @"99+";
    //    self.badgeLabel.hidden = NO;
}

- (void)setStyle:(BadgeButtonStyle)style
{
    _style = style;
    
    if (style == BadgeButtonStyleTopImage) {
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    else {
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat badgeW = 0;
    CGFloat badgeH = 0;
    CGFloat badgeX = 0;
    CGFloat badgeY = 0;
    
    if (self.style == BadgeButtonStyleTopImage) {
        
        CGFloat titleX = 0;
        CGFloat titleW = self.frame.size.width;
        CGFloat titleH = self.titleLabel.frame.size.height;
        
        CGFloat imageW = self.imageView.image.size.width;
        CGFloat imageH = self.imageView.image.size.height;
        
        CGFloat margin = (self.frame.size.height - titleH - imageH - 5) * 0.5;
        
        CGFloat titleY = self.frame.size.height - titleH - margin;
        
        self.titleLabel.frame = CGRectMake(titleX, titleY, titleW, titleH);
        
        CGFloat imageX = (self.frame.size.width - imageW) * 0.5;
        CGFloat imageY = titleY - imageH - 5;
        if (imageY < 0) {
            imageY = 0;
        }
        self.imageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
    }
    
    //    CGSize size = [self.badgeValue boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : kFontSize(10.0)} context:nil].size;
    
    //    badgeW = size.width > 18 ? size.width + 8 : 20;
    //    badgeH = 20;
    badgeW = 24;
    badgeH = 15;
    if (self.appressTitle) {
        badgeX = self.frame.size.width * 0.5 + self.titleLabel.frame.size.width * 0.5 - badgeW * 0.5 - 5;
        badgeY = CGRectGetMaxY(self.titleLabel.frame) * 0.5 - self.titleLabel.frame.size.height * 0.5 - badgeH * 0.5 + 5;
    }
    else {
        //        badgeW = 14;
        //        badgeH = badgeW;
        badgeX = CGRectGetMaxX(self.imageView.frame) - badgeW * 0.5;
        badgeY = self.imageView.frame.origin.y - badgeH * 0.5;
    }
    
    self.badgeLabel.layer.cornerRadius = badgeH * 0.5;
    
    self.badgeLabel.frame = CGRectMake(badgeX, badgeY, badgeW, badgeH);
}
@end

