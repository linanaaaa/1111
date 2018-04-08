//
//  HomeHeaderViewCell.m
//  吾家超市
//
//  Created by iMac15 on 2016/12/12.
//  Copyright © 2016年 iMac15. All rights reserved.
//

#import "HomeHeaderViewCell.h"

@interface HomeHeaderViewCell()
@property (strong, nonatomic) UIImageView *iconView;
@property (strong, nonatomic) UILabel *titleLabel;
@end

@implementation HomeHeaderViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        self.iconView = [self addImageViewWithImage:@""];
        
        self.titleLabel = [self addLabelWithText:@""];
        [self.titleLabel setTextAlignment:NSTextAlignmentCenter];
        self.titleLabel.textColor = [UIColor blackColor];
    }
    return self;
}

- (void)setImageName:(NSString *)imageName {
    _imageName = imageName;
    self.iconView.image = [UIImage imageNamed:imageName];
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLabel.text = title;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.iconView.frame = CGRectMake(15, 5, self.frame.size.width - 30, self.frame.size.height - 30);
    self.titleLabel.frame = CGRectMake(0, CGRectGetMaxY(self.iconView.frame), self.frame.size.width, 21);
}

@end
