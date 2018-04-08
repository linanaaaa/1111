//
//  WJInputTextField.m
//  吾家超市
//
//  Created by iMac15 on 2016/10/25.
//  Copyright © 2016年 iMac15. All rights reserved.
//

#import "WJInputTextField.h"

@interface WJInputTextField()
@property(nonatomic, strong)UILabel *titleLabel;
@property(nonatomic, copy)NSString *title;
@property(nonatomic, copy)NSAttributedString *attrTitle;
@end

@implementation WJInputTextField

+ (instancetype)inputTextFieldWithTitle:(NSString *)title andPlaceholderText:(NSString *)placeholder delegate:(id)delegate
{
    WJInputTextField *input = [[self alloc] init];
    input.title = title;
    input.delegate = delegate;
    
    input.placeholder = placeholder;
    return input;
}

+ (instancetype)inputTextFieldWithAttributedString:(NSAttributedString *)attrStr andPlaceholderText:(NSString *)placeholder
{
    WJInputTextField *input = [[self alloc] init];
    input.attrTitle = attrStr;
    
    input.placeholder = placeholder;
    
    return input;
}

- (instancetype)init
{
    if (self = [super init]) {
        self.font = kTextFont;
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.font = kTextFont;
        
        self.leftView = self.titleLabel;
        self.leftViewMode = UITextFieldViewModeAlways;
    }
    return self;
}

- (void)setAttrTitle:(NSAttributedString *)attrTitle
{
    _attrTitle = attrTitle;
    
    self.titleLabel.attributedText = attrTitle;
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    
    self.titleLabel.text = title;
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGSize size;
    if (self.title) {
        size = [self.title boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : kTextFont} context:nil].size;
    }
    else {
        size = [self.attrTitle boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    }
    
    self.titleLabel.frame = CGRectMake(0, 0, size.width, self.frame.size.height);
    
}


@end
