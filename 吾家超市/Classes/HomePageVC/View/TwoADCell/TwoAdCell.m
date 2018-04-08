//
//  TwoAdCell.m
//  吾家超市
//
//  Created by iMac15 on 2016/12/12.
//  Copyright © 2016年 iMac15. All rights reserved.
//

#import "TwoAdCell.h"

@interface TwoAdCell()
@property (strong, nonatomic) UIImageView *adTwoView;
@end

@implementation TwoAdCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.adTwoView = [self addImageViewWithImage:@""];
    }
    return self;
}

- (void)setAdTwoimageName:(NSString *)adTwoimageName
{
    _adTwoimageName = adTwoimageName;
    self.adTwoView.image = [UIImage imageNamed:adTwoimageName];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.adTwoView.frame = CGRectMake(0, 0, (kScreenW - 1)/2, 70);
}

@end
