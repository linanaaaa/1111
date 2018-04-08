//
//  UIView+SplitLine.m
//  吾家超市
//
//  Created by iMac15 on 2016/10/24.
//  Copyright © 2016年 iMac15. All rights reserved.
//

#import "UIView+SplitLine.h"

@implementation UIView (SplitLine)
+ (UIView *)line
{
    UIView *splitLine = UIView.new;
    splitLine.backgroundColor = kGlobalLineColor;
    return splitLine;
}

+ (UIView *)contentViewWithFrame:(CGRect)frame
{
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = [UIColor whiteColor];
    [view addTopSplitLine];
    [view addBottomSplitLine];
    return view;
}

- (void)addTopSplitLine
{
    [self addSplitLineWithFrame:CGRectMake(0, 0, self.frame.size.width, kSplitLineHeight)];
}

- (void)addBottomSplitLine
{
    [self addSplitLineWithFrame:CGRectMake(0, self.frame.size.height - kSplitLineHeight, self.frame.size.width, kSplitLineHeight)];
}

- (void)addLeftBottomSplitLine
{
    [self addSplitLineWithFrame:CGRectMake(10, self.frame.size.height - kSplitLineHeight, self.frame.size.width - 10, kSplitLineHeight)];
}


- (void)addSplitLineAtBottomWith:(UIView *)view
{
    [self addSplitLineWithFrame:CGRectMake(0, CGRectGetMaxY(view.frame) - kSplitLineHeight, self.frame.size.width, kSplitLineHeight)];
}

- (void)addSplitLineWithFrame:(CGRect)frame;
{
    UIView *splitLine = [UIView line];
    [self addSubview:splitLine];
    
    splitLine.frame = frame;
}

+ (UIView *)contentViewWithSplitLine
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    [UIView topSplitLineWithSuperView:view];
    
    [UIView bottomSplitLineWithSuperView:view];
    return view;
}

+ (UIView *)topSplitLineWithSuperView:(UIView *)superView
{
    UIView *splitLine = [UIView line];
    splitLine.frame = CGRectMake(0, 0, kScreenW, kSplitLineHeight);
    [superView addSubview:splitLine];
    
    return splitLine;
}

+ (UIView *)bottomSplitLineWithSuperView:(UIView *)superView
{
    UIView *splitLine = [UIView line];
    splitLine.frame = CGRectMake(0, CGRectGetMaxY(superView.frame) - kSplitLineHeight, kScreenW, kSplitLineHeight);
    [superView addSubview:splitLine];
    
    return splitLine;
}

+ (UIView *)splitLineWithLastView:(UIView *)lastView inSuperView:(UIView *)superView
{
    UIView *splitLine = [UIView line];
    splitLine.frame = CGRectMake(0, CGRectGetMaxY(lastView.frame) - kSplitLineHeight, kScreenW, kSplitLineHeight);
    [superView addSubview:splitLine];
    
    return splitLine;
}

+ (UIView *)splitCenterLineWithLastView:(UIView *)lastView inSuperView:(UIView *)superView
{
    UIView *splitLine = [UIView line];
    splitLine.frame = CGRectMake(10, CGRectGetMaxY(lastView.frame) - kSplitLineHeight, kScreenW - 20, kSplitLineHeight);
    [superView addSubview:splitLine];
    
    return splitLine;
}


- (void)addSplitLineWithLastView:(UIView *)lastView
{
    UIView *splitLine = [UIView line];
    splitLine.frame = CGRectMake(0, CGRectGetMaxY(lastView.frame) - kSplitLineHeight, kScreenW, kSplitLineHeight);
    
    [self addSubview:splitLine];
}
@end
