//
//  FourAdCell.m
//  吾家超市
//
//  Created by iMac15 on 2016/12/13.
//  Copyright © 2016年 iMac15. All rights reserved.
//

#import "FourAdCell.h"

@interface FourAdCell()
@property (strong, nonatomic) UIImageView *adFourimage;
@end

@implementation FourAdCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.adFourimage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fourAd"]];
        [self.adFourimage setContentMode:UIViewContentModeScaleToFill];
        self.adFourimage.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.adFourimage];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.adFourimage.frame = CGRectMake(0, 0, kScreenW, 60);
}

@end
