//
//  UIView+Utils.h
//  SanLianOrdering
//
//  Created by guojiang on 14-10-10.
//  Copyright (c) 2014年 DaCheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WJInputTextField.h"

@interface UIView (Utils)

#pragma mark -View 添加 UIView;

#pragma mark -View 添加 UIImageView

//当前view添加UIImage
-(UIImage *)imageWithName:(NSString *)name;

//当前view添加UIImageView，自定义图片
-(UIImageView *)addImageViewWithImage:(NSString *)image;


#pragma mark -View 添加 UILabel

//当前view添加label,系统字体，系统颜色
-(UILabel *)addLabelWithText:(NSString *)text;

//当前view添加label,指定字体，系统颜色
-(UILabel *)addLabelWithText:(NSString *)text font:(UIFont *)font;

//当前view添加label,系统字体，指定颜色
-(UILabel *)addLabelWithText:(NSString *)text color:(UIColor *)color;

//当前view添加label,指定字体，指定颜色
-(UILabel *)addLabelWithText:(NSString *)text font:(UIFont *)font color:(UIColor *)color;


#pragma mark -View 添加 UITextField

//当前view添加UITextField,指定delegate,指定placeholder
-(UITextField *)addTextFieldWithPlaceholder:(NSString *)placeholder delegate:(id)delegate target:(id)target action:(SEL)action;

//当前view添加UITextField,指定delegate,指定字体大小
-(UITextField *)addTextFieldWithDelegate:(id)delegate fontSize:(CGFloat)fontSize;

//当前view添加UITextField,指定delegate,指定字体
-(UITextField *)addTextFieldWithDelegate:(id)delegate font:(UIFont *)font;


#pragma mark -View 添加 UIButton

//当前view添加UIButton,指定target,指定action
-(UIButton *)addButtonWithTitle:(NSString *)title target:(id)target action:(SEL)action;

//当前view设置图片 UIButton,指定target,指定action
-(UIButton *)addButtonSetImage:(NSString *)image highlighted:(NSString *)highlight target:(id)target action:(SEL)action;

//当前view勾选 UIButton,指定target,指定action
-(UIButton *)addButtonSelectedSetImage:(NSString *)image selected:(NSString *)selected target:(id)target action:(SEL)action;

//当前view添加 红底圆角 UIButton,指定target,指定action
-(UIButton *)addButtonFilletWithTitle:(NSString *)title target:(id)target action:(SEL)action;

//当前view添加 边线圆角 UIButton,指定target,指定action
-(UIButton *)addButtonLineWithTitle:(NSString *)title target:(id)target action:(SEL)action;

//当前view添加 左边图片 右边文字 UIButton,指定target,指定action
-(UIButton *)addButtonLeftWithImage:(NSString *)iamge rightWithTitle:(NSString *)title  target:(id)target action:(SEL)action;

//当前view添加 上边图片 下边文字 UIButton,指定target,指定action
-(UIButton *)addButtonTopWithImage:(NSString *)iamge bottomWithTitle:(NSString *)title  target:(id)target action:(SEL)action;



#pragma mark -View 添加 UITextView

//当前view添加UITextView,指定delegate,指定字体大小
-(UITextView *)addTextViewWithDelegate:(id)delegate fontSize:(CGFloat)fontSize;

//当前view添加UITextView,指定delegate,指定字体
-(UITextView *)addTextViewWithDelegate:(id)delegate font:(UIFont *)font;


#pragma mark -View 添加 UITableView

//当前view添加UITableView,指定delegate,指定dataSouce
-(UITableView *)addTableViewWithDelegate:(id)delegate dataSource:(id)dataSouce;



#pragma mark -View 添加 InputTextField 

//当前view添加UITextFielf,左名称:提示文字,指定delegate,指定dataSouce,指定action
- (WJInputTextField *)addInputTextFieldWithTitle:(NSString *)title placeHolder:(NSString *)text delegate:(id)delegate target:(id)target action:(SEL)action;

#pragma mark -View 添加

//多view水平居中对齐（参考顶部）
- (void) distributeSpacingHorizontallyWith:(NSArray*)views;

//多view垂直居中对齐（参考顶部）
- (void) distributeSpacingVerticallyWith:(NSArray*)views;

/*
#pragma mark -View 添加 显示加载提示

//显示加载提示
- (void)showActivityView:(NSString *)labelText;

//隐藏加载提示
- (void)hiddenActivityView;

//显示加载提示,指定时间(秒数)自动消失
- (void)showActivityView:(NSString *)labelText hideAfterDelay:(NSTimeInterval)delay;

 */

#pragma mark -View 添加 显示toast文字

//显示toast文字
- (void)showToastText:(NSString *)text;

//显示toast文字与指定时间消失
- (void)showToastText:(NSString *)text duration:(CGFloat)duration;

//显示toast文字，指定向上偏移
- (void)showToastText:(NSString *)text topOffset:(CGFloat) topOffset;

//显示toast文字，指定向上偏移与定时消失
- (void)showToastText:(NSString *)text topOffset:(CGFloat) topOffset duration:(CGFloat) duration;

//显示toast文字，指定向下偏移
- (void)showToastText:(NSString *)text bottomOffset:(CGFloat) bottomOffset;

//显示toast文字，指定向下偏移与定时消失
- (void)showToastText:(NSString *)text bottomOffset:(CGFloat) bottomOffset duration:(CGFloat) duration;










@end

