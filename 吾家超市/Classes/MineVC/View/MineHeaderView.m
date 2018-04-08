//
//  MineHeaderView.m
//  吾家超市
//
//  Created by iMac15 on 2016/10/26.
//  Copyright © 2016年 iMac15. All rights reserved.
//

#import "MineHeaderView.h"

@interface MineHeaderView()
@property (strong, nonatomic) UILabel * nameLabel;

@property (strong, nonatomic) UILabel * balanceLabel;
@property (strong, nonatomic) UILabel * integralLabel;
@property (strong, nonatomic) UIButton *loginBtn;
@end

@implementation MineHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _headerImage = [[UIImageView alloc] init];
        _headerImage.image = [UIImage imageNamed:@"header"];
        _headerImage.layer.cornerRadius = 40;
        _headerImage.layer.masksToBounds = YES;
        [_headerImage setUserInteractionEnabled:YES];
        [_headerImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(loginBtnClick)]];
        [self addSubview:_headerImage];
        
        _loginBtn = [self addButtonWithTitle:@"登录/注册" target:self action:@selector(loginBtnClick)];
        [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _loginBtn.hidden = YES;
        
        _nameLabel = [self addLabelWithText:@""];
        _nameLabel.textColor = [UIColor whiteColor];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.hidden = YES;
        
        _balanceLabel = [self addLabelWithText:@"贡献值: --"];
        _balanceLabel.textAlignment = NSTextAlignmentCenter;
        _balanceLabel.textColor = [UIColor whiteColor];
        
        _integralLabel = [self addLabelWithText:@"回馈值: --"];
        _integralLabel.textAlignment = NSTextAlignmentCenter;
        _integralLabel.textColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setLoginNameStr:(NSString *)loginNameStr
{
    _loginNameStr = loginNameStr;
    if (!kStringIsEmpty(loginNameStr)) {
        self.nameLabel.text = loginNameStr;
    }
}

- (void)setBalanceMineStr:(NSString *)balanceMineStr
{
    _balanceMineStr = balanceMineStr;
    if (!kStringIsEmpty(balanceMineStr)) {
        self.balanceLabel.text = [NSString stringWithFormat:@"贡献值: %@",balanceMineStr];
    }
}

- (void)setCatibalMineStr:(NSString *)catibalMineStr
{
    _catibalMineStr = catibalMineStr;
    if (!kStringIsEmpty(catibalMineStr)) {
        self.integralLabel.text = [NSString stringWithFormat:@"回馈值: %@",catibalMineStr];
    }
}

#pragma mark -登录注册
- (void)loginBtnClick
{
    if (self.loginClik) {
        self.loginClik();
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.headerImage.frame = CGRectMake((kScreenW - 80)/2, 40, 80, 80);
    self.balanceLabel.frame = CGRectMake(10, CGRectGetMaxY(self.headerImage.frame) + 25, (kScreenW - 20)/2, 25);
    self.integralLabel.frame = CGRectMake(CGRectGetMaxX(self.balanceLabel.frame), CGRectGetMaxY(self.headerImage.frame) + 25, (kScreenW - 20)/2, 25);
    
    if ([ZNGUser userInfo].isOnline) {
        self.headerImage.userInteractionEnabled = NO;
        self.loginBtn.hidden = YES;
        
        self.nameLabel.hidden = NO;
        self.nameLabel.frame = CGRectMake((kScreenW - 120)/2, CGRectGetMaxY(self.headerImage.frame), 120, 25);
    }
    else{
        self.nameLabel.hidden = YES;
        self.headerImage.userInteractionEnabled = YES;

        self.loginBtn.hidden = NO;
        self.loginBtn.frame = CGRectMake((kScreenW - 80)/2, CGRectGetMaxY(self.headerImage.frame), 80, 30);
    }
}

@end

