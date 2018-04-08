//
//  UIView+SplitLine.h
//  吾家超市
//
//  Created by iMac15 on 2016/10/24.
//  Copyright © 2016年 iMac15. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (SplitLine)

+ (UIView *)contentViewWithSplitLine;

+ (UIView *)topSplitLineWithSuperView:(UIView *)superView;

+ (UIView *)bottomSplitLineWithSuperView:(UIView *)superView;

+ (UIView *)splitLineWithLastView:(UIView *)lastView inSuperView:(UIView *)superView ;

+ (UIView *)splitCenterLineWithLastView:(UIView *)lastView inSuperView:(UIView *)superView ;

+ (UIView *)line;

+ (UIView *)contentViewWithFrame:(CGRect)frame;



- (void)addTopSplitLine;
- (void)addBottomSplitLine;
- (void)addSplitLineWithFrame:(CGRect)frame;
- (void)addSplitLineAtBottomWith:(UIView *)view;

- (void)addSplitLineWithLastView:(UIView *)lastView;
- (void)addLeftBottomSplitLine;

@end
