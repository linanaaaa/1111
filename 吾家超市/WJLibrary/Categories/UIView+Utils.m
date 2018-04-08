//
//  UIView+Utils.m
//  SanLianOrdering
//
//  Created by guojiang on 14-10-10.
//  Copyright (c) 2014年 DaCheng. All rights reserved.
//

#import "UIView+Utils.h"
#import "UIView+Toaset.h"

#define ACTIVITYTAG 9999

@implementation UIView (Utils)


#pragma mark -View 添加 UIImageView

//当前view添加UIImage
-(UIImage *)imageWithName:(NSString *)name
{
    UIImage *image = [UIImage imageNamed:name];
    return image;
}

//当前view添加UIImageView，自定义图片
-(UIImageView *)addImageViewWithImage:(NSString *)image
{
    UIImage *ima = [self imageWithName:image];
    
    UIImageView *imageView = [UIImageView new];
    imageView.translatesAutoresizingMaskIntoConstraints = NO;

    [imageView setContentMode:UIViewContentModeScaleAspectFit];
    [imageView setBackgroundColor:[UIColor whiteColor]];
    
    if (!image && image.length > 0) {
        imageView.image = ima;
    }
    [self addSubview:imageView];
    
    return imageView;
}


#pragma mark -- 添加 UILabel

//当前view添加label,系统字体，系统颜色
-(UILabel *)addLabelWithText:(NSString *)text
{
    return [self addLabelWithText:text font:kTextFont color:nil];
}

//当前view添加label,指定字体，系统颜色
-(UILabel *)addLabelWithText:(NSString *)text font:(UIFont *)font
{
    return [self addLabelWithText:text font:font color:nil];
}

//当前view添加label,系统字体，指定颜色
-(UILabel *)addLabelWithText:(NSString *)text color:(UIColor *)color
{
    return [self addLabelWithText:text font:nil color:color];
}

//当前view添加label,指定字体，指定颜色
-(UILabel *)addLabelWithText:(NSString *)text font:(UIFont *)font color:(UIColor *)color
{
    UILabel *label=[[UILabel alloc] init];
    label.translatesAutoresizingMaskIntoConstraints = NO;
    label.backgroundColor = [UIColor clearColor];
    
    if (color) {
        label.textColor = color;
    }
    if (font) {
        label.font = font;
    }
    
    label.text = text;
    label.textAlignment = NSTextAlignmentLeft;
    [self addSubview:label];
    
    return label;
}



#pragma mark -- UITextField

//当前view添加UITextField,指定delegate,指定placeholder
-(UITextField *)addTextFieldWithPlaceholder:(NSString *)placeholder delegate:(id)delegate target:(id)target action:(SEL)action
{
    UITextField *textField = [[UITextField alloc]init];
    textField.translatesAutoresizingMaskIntoConstraints = NO;
    textField.delegate = delegate;
    textField.borderStyle = UITextBorderStyleNone;
    textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    textField.font = kTextFont;
    textField.placeholder = placeholder;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.backgroundColor = [UIColor whiteColor];
    [textField addTarget:target action:action forControlEvents:UIControlEventEditingChanged];
    [self addSubview:textField];
    
    return textField;
}

//当前view添加UITextField,指定delegate,指定字体大小
-(UITextField *)addTextFieldWithDelegate:(id)delegate fontSize:(CGFloat)fontSize
{
    return [self addTextFieldWithDelegate:delegate font:[UIFont systemFontOfSize:fontSize]];
}

//当前view添加UITextField,指定delegate,指定字体
-(UITextField *)addTextFieldWithDelegate:(id)delegate font:(UIFont *)font
{
    UITextField *textField = [[UITextField alloc]init];
    textField.translatesAutoresizingMaskIntoConstraints = NO;
    textField.delegate = delegate;
    textField.borderStyle = UITextBorderStyleNone;
    textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    textField.font = font;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.backgroundColor = [UIColor whiteColor];
    [self addSubview:textField];
    
    return textField;
}

#pragma mark -- UIButton

//当前view添加UIButton,指定target,指定action
-(UIButton *)addButtonWithTitle:(NSString *)title target:(id)target action:(SEL)action
{
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.translatesAutoresizingMaskIntoConstraints = NO;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:kGlobalTextColor forState:UIControlStateNormal];
    btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btn.titleLabel setFont:kTextFont];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    
    return btn;
}

//当前view设置图片 UIButton,指定target,指定action
-(UIButton *)addButtonSetImage:(NSString *)image highlighted:(NSString *)highlight target:(id)target action:(SEL)action
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.translatesAutoresizingMaskIntoConstraints = NO;
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:highlight] forState:UIControlStateHighlighted];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    
    return btn;
}

//当前view勾选 UIButton,指定target,指定action
-(UIButton *)addButtonSelectedSetImage:(NSString *)image selected:(NSString *)selected target:(id)target action:(SEL)action
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.translatesAutoresizingMaskIntoConstraints = NO;
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:selected] forState:UIControlStateSelected];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    
    return btn;
}

//当前view添加 红底圆角 UIButton,指定target,指定action
-(UIButton *)addButtonFilletWithTitle:(NSString *)title target:(id)target action:(SEL)action
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.translatesAutoresizingMaskIntoConstraints = NO;
    [btn setTitle:title forState:UIControlStateNormal];
    
    btn.layer.cornerRadius = 4;
    btn.layer.masksToBounds = YES;
    btn.titleLabel.font = kFontSize(15.0);
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [btn setBackgroundImage:[UIImage imageWithColor:kGlobalRedColor] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageWithColor:kBtnHighlightedColor] forState:UIControlStateHighlighted];
    [btn setBackgroundImage:[UIImage imageWithColor:kBtnDisabledColor] forState:UIControlStateDisabled];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    
    return btn;
}

//当前view添加 边线圆角 UIButton,指定target,指定action
-(UIButton *)addButtonLineWithTitle:(NSString *)title target:(id)target action:(SEL)action
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.translatesAutoresizingMaskIntoConstraints = NO;
    [btn setTitle:title forState:UIControlStateNormal];
    
    btn.layer.cornerRadius = 4;
    btn.layer.masksToBounds = YES;
    btn.layer.borderWidth = kSplitLineHeight;
    btn.layer.borderColor = kGlobalBackColor.CGColor;

    btn.titleLabel.font = kTextFont;
    [btn setTitleColor:kGlobalTextColor forState:UIControlStateNormal];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    
    return btn;
}

//当前view添加 左边图片 右边文字 UIButton,指定target,指定action
-(UIButton *)addButtonLeftWithImage:(NSString *)iamge rightWithTitle:(NSString *)title  target:(id)target action:(SEL)action
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.translatesAutoresizingMaskIntoConstraints = NO;
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = kTextFont;
    [btn setTitleColor:kGlobalTextColor forState:UIControlStateNormal];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    [btn setImage:[UIImage imageNamed:iamge] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:iamge] forState:UIControlStateHighlighted];
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    btn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    [self addSubview:btn];
    
    return btn;
}

//当前view添加 上边图片 下边文字 UIButton,指定target,指定action
-(UIButton *)addButtonTopWithImage:(NSString *)iamge bottomWithTitle:(NSString *)title  target:(id)target action:(SEL)action
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor blackColor];
    btn.translatesAutoresizingMaskIntoConstraints = NO;
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = kTextFont;
    [btn setTitleColor:kGlobalTextColor forState:UIControlStateNormal];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    [btn setImage:[UIImage imageNamed:iamge] forState:UIControlStateNormal];

    
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;//使图片和文字水平居中显示
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(btn.imageView.frame.size.height ,-btn.imageView.frame.size.width, 0.0,0.0)];//文字距离上边框的距离增加imageView的高度，距离左边框减少imageView的宽度，距离下边框和右边框距离不变
    [btn setImageEdgeInsets:UIEdgeInsetsMake(0.0, 0.0,0.0, -btn.titleLabel.bounds.size.width)];//图片距离右边框距离减少图片的宽度，其它不边
    

    [self addSubview:btn];
    
    return btn;
}


#pragma mark -- UITextView

//当前view添加UITextView,指定delegate,指定字体大小
-(UITextView *)addTextViewWithDelegate:(id)delegate fontSize:(CGFloat)fontSize
{
    return [self addTextViewWithDelegate:delegate font:[UIFont systemFontOfSize:fontSize]];
}

//当前view添加UITextView,指定delegate,指定字体
-(UITextView *)addTextViewWithDelegate:(id)delegate font:(UIFont *)font
{
    UITextView *textView = [[UITextView alloc]init];
    textView.translatesAutoresizingMaskIntoConstraints = NO;
    textView.delegate = delegate;
    textView.font = font;
    textView.clearsContextBeforeDrawing = YES;
    textView.backgroundColor = [UIColor whiteColor];
    [self addSubview:textView];
    
    return textView;
}


#pragma mark -View 添加 UITableView

//当前view添加UITableView,指定delegate,指定dataSouce
-(UITableView *)addTableViewWithDelegate:(id)delegate dataSource:(id)dataSouce
{
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableView.backgroundColor = kGrayBackgroundColor;
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    tableView.tableFooterView = [UIView new];
    tableView.delegate = delegate;
    tableView.dataSource = dataSouce;
    [self addSubview:tableView];
    
    return tableView;
}


#pragma mark -View 添加 InputTextField

- (WJInputTextField *)addInputTextFieldWithTitle:(NSString *)title placeHolder:(NSString *)text delegate:(id)delegate target:(id)target action:(SEL)action
{
    WJInputTextField *input = [WJInputTextField inputTextFieldWithTitle:title andPlaceholderText:text delegate:delegate];
    [input addTarget:target action:action forControlEvents:UIControlEventEditingChanged];
    [self addSubview:input];
    
    return input;
}


#pragma mark -- 多view水平分布
- (void) distributeSpacingHorizontallyWith:(NSArray*)views
{
    NSMutableArray *spaces = [NSMutableArray arrayWithCapacity:views.count+1];
    
    for ( int i = 0 ; i < views.count+1 ; ++i )
    {
        UIView *v = [UIView new];
        [spaces addObject:v];
        [self addSubview:v];
        
        [v mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(v.mas_height);
        }];
    }
    
    UIView *v0 = spaces[0];
    
    __weak __typeof(&*self)ws = self;
    
    [v0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.mas_left);
        make.centerY.equalTo(((UIView*)views[0]).mas_centerY);
    }];
    
    UIView *lastSpace = v0;
    for ( int i = 0 ; i < views.count; ++i )
    {
        UIView *obj = views[i];
        UIView *space = spaces[i+1];
        
        [obj mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(lastSpace.mas_right);
        }];
        
        [space mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(obj.mas_right);
            make.centerY.equalTo(obj.mas_centerY);
            make.width.equalTo(v0);
        }];
        
        lastSpace = space;
    }
    
    [lastSpace mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(ws.mas_right);
    }];
    
}

#pragma mark -- 多view垂直分布
- (void) distributeSpacingVerticallyWith:(NSArray*)views
{
    NSMutableArray *spaces = [NSMutableArray arrayWithCapacity:views.count+1];
    
    for ( int i = 0 ; i < views.count+1 ; ++i )
    {
        UIView *v = [UIView new];
        [spaces addObject:v];
        [self addSubview:v];
        
        [v mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(v.mas_height);
        }];
    }
    
    
    UIView *v0 = spaces[0];
    
    __weak __typeof(&*self)ws = self;
    
    [v0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.mas_top);
        make.centerX.equalTo(((UIView*)views[0]).mas_centerX);
    }];
    
    UIView *lastSpace = v0;
    for ( int i = 0 ; i < views.count; ++i )
    {
        UIView *obj = views[i];
        UIView *space = spaces[i+1];
        
        [obj mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lastSpace.mas_bottom);
        }];
        
        [space mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(obj.mas_bottom);
            make.centerX.equalTo(obj.mas_centerX);
            make.height.equalTo(v0);
        }];
        
        lastSpace = space;
    }
    
    [lastSpace mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(ws.mas_bottom);
    }];
}

#pragma mark - 显示Toast
//显示toast文字
- (void)showToastText:(NSString *)text
{
    [self showToastText:text duration:DEFAULT_DISPLAY_DURATION];
}

//显示toast文字与指定时间消失
- (void)showToastText:(NSString *)text duration:(CGFloat)duration
{
    [UIView_Toaset showWithText:text inView:self duration:duration];
}

//显示toast文字，指定向上偏移
- (void)showToastText:(NSString *)text topOffset:(CGFloat) topOffset
{
    [self showToastText:text topOffset:topOffset duration:DEFAULT_DISPLAY_DURATION];
}

//显示toast文字，指定向上偏移与定时消失
- (void)showToastText:(NSString *)text topOffset:(CGFloat) topOffset duration:(CGFloat) duration
{
    [UIView_Toaset showWithText:text inView:self topOffset:topOffset duration:duration];
}

//显示toast文字，指定向下偏移
- (void)showToastText:(NSString *)text bottomOffset:(CGFloat) bottomOffset
{
    [self showToastText:text bottomOffset:bottomOffset duration:DEFAULT_DISPLAY_DURATION];
}

//显示toast文字，指定向下偏移与定时消失
- (void)showToastText:(NSString *)text bottomOffset:(CGFloat) bottomOffset duration:(CGFloat) duration
{
    [UIView_Toaset showWithText:text inView:self bottomOffset:bottomOffset duration:duration];
}

@end
