//
//  WJGuideCell.m
//  吾家超市
//
//  Created by iMac15 on 2017/2/7.
//  Copyright © 2017年 iMac15. All rights reserved.
//

#import "WJGuideCell.h"

@implementation WJGuideCell
- (instancetype)init {
    if (self = [super init]) {
        [self initView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initView];
    }
    return self;
}

- (void)initView {
    self.layer.masksToBounds = YES;
    self.imageView = [[UIImageView alloc]initWithFrame:kScreenBounds];
    self.imageView.center = CGPointMake(kScreenW / 2, kScreenH / 2);
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    button.hidden = YES;
    [button setTitle:@"立即体验" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.layer.cornerRadius = 6.0;
    [button.layer setBorderColor:[UIColor grayColor].CGColor];
    [button.layer setBorderWidth:2.0f];
    [button setBackgroundColor:[UIColor whiteColor]];
    
    if (IS_IPHONE_5 || IS_IPHONE_4_OR_LESS) {
        [button setFrame:CGRectMake(0, kScreenH - 34, 200, 34)];
    }else if (IS_IPHONE_X){
        [button setFrame:CGRectMake(0, kScreenH - 34, 200, 54)];
    }else{
        [button setFrame:CGRectMake(0, kScreenH - 44, 200, 44)];
    }
    
    self.button = button;
    
    [self.contentView addSubview:self.imageView];
    [self.contentView addSubview:self.button];
    
    [self.button setCenter:CGPointMake(kScreenW / 2, kScreenH - 44)];
}

@end
