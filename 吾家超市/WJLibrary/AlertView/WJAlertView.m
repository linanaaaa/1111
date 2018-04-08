//
//  WJAlertView.m
//  吾家超市
//
//  Created by iMac15 on 2016/10/24.
//  Copyright © 2016年 iMac15. All rights reserved.
//

#import "WJAlertView.h"

const static CGFloat kWJAlertViewDefaultButtonHeight       = 40;

@interface WJAlertView ()
@property(nonatomic,strong) UIView * dialogView;
@property(nonatomic,strong) UIView * containerView;

@property(nonatomic,copy) NSString * cancelButtonTitle;

@property(nonatomic,strong) NSMutableArray * buttonTitles;

@property(nonatomic,weak) UIView * tempView;
@end

@implementation WJAlertView

static WJAlertViewStyle *_alertViewStyle;

+ (void)load
{
    _alertViewStyle = [[WJAlertViewStyle alloc] init];
}

+ (void)setAlertViewStyle:(WJAlertViewStyle *)style
{
    _alertViewStyle = style;
}

+ (WJAlertViewStyle *)alertViewStyle
{
    return _alertViewStyle;
}

- (WJAlertViewStyle *)style
{
    if (_style == nil) {
        _style = [WJAlertView alertViewStyle];
    }
    return _style;
}

- (NSMutableArray *)buttonTitles
{
    if (_buttonTitles == nil) {
        _buttonTitles = [NSMutableArray array];
    }
    return _buttonTitles;
}

- (instancetype)init
{
    if (self = [super init]) {
        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        self.backgroundColor = kGlobalTextColor;
        [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...
{
    if (self = [super init]) {
        self.backgroundColor = kGlobalTextColor;
        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        self.cancelButtonTitle = cancelButtonTitle;
        self.title = title;
        
        self.message = message;
        
        self.attributeMessage = nil;
        
        if (cancelButtonTitle) {
            [self.buttonTitles addObject:cancelButtonTitle];
        }
        
        if (otherButtonTitles) {
            [self.buttonTitles addObject:otherButtonTitles];
            
            NSString * buttonTitle = nil;
            va_list argumentList;
            va_start(argumentList, otherButtonTitles);
            
            while ((buttonTitle = (__bridge NSString *)va_arg(argumentList, void *))) {
                [self.buttonTitles addObject:buttonTitle];
            }
            
            va_end(argumentList);
        }
        
        if (self.buttonTitles.count > 2 && cancelButtonTitle) {
            [self.buttonTitles removeObjectAtIndex:0];
            [self.buttonTitles addObject:cancelButtonTitle];
        }
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title attributeMessage:(NSAttributedString *)attributeMessage cancelButtonTitle:(nullable NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...
{
    if (self = [super init]) {
        self.backgroundColor = kGlobalTextColor;
        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        self.cancelButtonTitle = cancelButtonTitle;
        self.title = title;
        
        self.message = nil;
        
        self.attributeMessage = attributeMessage;
        
        if (cancelButtonTitle) {
            [self.buttonTitles addObject:cancelButtonTitle];
        }
        
        if (otherButtonTitles) {
            [self.buttonTitles addObject:otherButtonTitles];
            
            id buttonTitle = nil;
            va_list argumentList;
            va_start(argumentList, otherButtonTitles);
            
            while ((buttonTitle=(__bridge NSString *)va_arg(argumentList, void *))) {
                [self.buttonTitles addObject:buttonTitle];
            }
            
            va_end(argumentList);
        }
        
        if (self.buttonTitles.count > 2 && cancelButtonTitle) {
            [self.buttonTitles removeObjectAtIndex:0];
            [self.buttonTitles addObject:cancelButtonTitle];
        }
        
    }
    return self;
}

- (UIView *)containerViewWithTitle:(NSString *)title message:(NSString *)message attributedMessage:(NSAttributedString *)attributedMessage
{
    CGFloat containerW = 280;
    CGFloat containerH = 0;
    
    CGFloat margin = 20;
    CGFloat titleW = containerW - 2 * margin;
    CGSize titleSize = title.length > 0 ? [title boundingRectWithSize:CGSizeMake(titleW, MAXFLOAT) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:self.style.titleFontSize]} context:nil].size : CGSizeZero;
    
    UIView *containerView = [[UIView alloc] init];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(margin, margin, titleW, titleSize.height)];
    titleLabel.text = title;
    titleLabel.numberOfLines = 0;
    titleLabel.textColor = self.style.titleColor;
    titleLabel.font = [UIFont systemFontOfSize:self.style.titleFontSize];
    [containerView addSubview:titleLabel];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    
    UILabel *messageLabel = [[UILabel alloc] init];
    messageLabel.numberOfLines = 0;
    messageLabel.textColor = self.style.messageColor;
    messageLabel.font = [UIFont systemFontOfSize:self.style.messageFontSize];
    
    if (attributedMessage) {
        
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithAttributedString:attributedMessage];
        
        NSRange range = NSMakeRange(0, str.length);
        
        [str addAttributes:@{
                             NSForegroundColorAttributeName : self.style.messageColor,
                             NSFontAttributeName : [UIFont systemFontOfSize:self.style.messageFontSize]
                             }
                     range:NSMakeRange(0, str.length)];
        
        [attributedMessage enumerateAttributesInRange:range options:NSAttributedStringEnumerationReverse usingBlock:^(NSDictionary<NSString *,id> * _Nonnull attrs, NSRange range, BOOL * _Nonnull stop) {
            if (attrs.allKeys > 0) {
                [str addAttributes:attrs range:range];
            }
        }];
        
        messageLabel.attributedText = str;
        
        
    } else {
        messageLabel.text = message;
    }
    
    
    CGFloat messageX = margin;
    CGFloat messageY = title.length == 0 ? margin : CGRectGetMaxY(titleLabel.frame) + 10;
    CGFloat messageW = titleW;
    
    CGSize messageSize;
    if (attributedMessage) {
        messageSize = [attributedMessage length] > 0 ? [messageLabel.attributedText boundingRectWithSize: CGSizeMake(messageW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size : CGSizeZero;
    }
    else {
        
        messageSize = message.length > 0 ? [message boundingRectWithSize:CGSizeMake(messageW, MAXFLOAT) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:self.style.messageFontSize]} context:nil].size : CGSizeZero;
        
    }
    CGFloat messageH = messageSize.height;
    
    messageLabel.frame = CGRectMake(messageX, messageY, messageW, messageH);
    
    [containerView addSubview:messageLabel];
    
    if (message.length > 0 || attributedMessage.length > 0) {
        containerH = CGRectGetMaxY(messageLabel.frame) + margin;
    }
    else if (title.length > 0) {
        containerH = CGRectGetMaxY(titleLabel.frame) + margin;
    }
    
    
    containerView.frame = CGRectMake(0, 0, containerW,containerH);
    
    return containerView;
}


- (UIView *)createContainerView
{
    if (self.customView) {
        self.containerView = self.customView;
    }
    else {
        self.containerView = [self containerViewWithTitle:self.title message:self.message attributedMessage:self.attributeMessage];
    }
    
    CGFloat x = (self.frame.size.width - self.containerView.frame.size.width) * 0.5;
    CGFloat w = self.containerView.frame.size.width;
    CGFloat h = 0;
    if (self.buttonTitles.count > 2) {
        h = self.containerView.frame.size.height + self.buttonTitles.count * kWJAlertViewDefaultButtonHeight;
    }
    else {
        h = self.containerView.frame.size.height + (self.buttonTitles.count > 0 ? kWJAlertViewDefaultButtonHeight : 0);
    }
    
    if (h > [UIScreen mainScreen].bounds.size.height - 40) {
        h = [UIScreen mainScreen].bounds.size.height - 40;
    }
    
    CGFloat y = (self.frame.size.height - h) * 0.5;
    
    UIView *dialogContainer = [[UIView alloc] init];

    dialogContainer.frame = CGRectMake(x, y, w, h);
    dialogContainer.backgroundColor = self.style.backColor;
    
    CGFloat cornerRadius = self.style.cornerRadius;
    
    dialogContainer.layer.cornerRadius = cornerRadius;
    
    dialogContainer.layer.borderColor = self.style.borderColor.CGColor;
    dialogContainer.layer.borderWidth = kSplitLineHeight;
    
    dialogContainer.layer.shadowRadius = cornerRadius + 5;
    dialogContainer.layer.shadowOpacity = 0.1f;
    dialogContainer.layer.shadowOffset = CGSizeMake(0 - (cornerRadius + 5)/2, 0 - (cornerRadius + 5)/2);
    dialogContainer.layer.shadowColor = kGlobalTextColor.CGColor;
    dialogContainer.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:dialogContainer.bounds cornerRadius:dialogContainer.layer.cornerRadius].CGPath;
    
    if (self.buttonTitles.count > 0 && self.buttonTitles.count <= 2) {
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, dialogContainer.bounds.size.height - kWJAlertViewDefaultButtonHeight - kSplitLineHeight, dialogContainer.bounds.size.width, kSplitLineHeight)];
        lineView.backgroundColor = [self.style.lineColor colorWithAlphaComponent:0.5];
        [dialogContainer addSubview:lineView];
    }
    
    [dialogContainer addSubview:self.containerView];
    
    [self addButtonsToView:dialogContainer];

    return dialogContainer;
}

- (void)addButtonsToView: (UIView *)container
{
    if (self.buttonTitles == nil) {
        return;
    }
    
    CGFloat y = self.containerView.frame.size.height;
    
    CGFloat h = container.bounds.size.height - y;
    
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = CGRectMake(0, y, container.frame.size.width, h);
    [container addSubview:scrollView];
    
    scrollView.contentSize  = CGSizeMake(scrollView.frame.size.width, self.buttonTitles.count > 2 ? kWJAlertViewDefaultButtonHeight * self.buttonTitles.count : kWJAlertViewDefaultButtonHeight);
    CGFloat buttonWidth = 0;
    
    
    if (self.buttonTitles.count > 2) {
        buttonWidth = container.bounds.size.width;
    }
    else {
        buttonWidth = container.bounds.size.width / self.buttonTitles.count;
    }
    
    
    for (int i=0; i<self.buttonTitles.count; i++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        if (self.buttonTitles.count > 2) {
            button.frame = CGRectMake(0, i * kWJAlertViewDefaultButtonHeight, buttonWidth, kWJAlertViewDefaultButtonHeight);
        }
        else {
            button.frame = CGRectMake(i * buttonWidth, 0, buttonWidth, kWJAlertViewDefaultButtonHeight);
        }
        
        [button addTarget:self action:@selector(btnDidClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [button setTitle:self.buttonTitles[i] forState:UIControlStateNormal];
        
        
        if (self.buttonTitles.count > 2) {
            button.tag = i + 1;
            if ([button.currentTitle isEqualToString:self.cancelButtonTitle]) {
                button.tag = 0;
            }
        }
        else {
            button.tag = i;
        }
        
        button.titleLabel.font = [UIFont systemFontOfSize:self.style.btnTitleFontSize];
        
        if ([button.currentTitle isEqualToString:self.cancelButtonTitle]) {
            [button setTitleColor:self.style.cancelBtnTitleColor forState:UIControlStateNormal];
        } else {
            [button setTitleColor:self.style.btnTitleColor forState:UIControlStateNormal];
        }
        
        [scrollView addSubview:button];
        
        if (self.buttonTitles.count > 2) {
            UIView * line = [[UIView alloc] init];
            line.backgroundColor = [self.style.lineColor colorWithAlphaComponent:0.5];
            line.frame  = CGRectMake(0, button.frame.origin.y, buttonWidth, kSplitLineHeight);
            [scrollView addSubview:line];
        } else if (i != self.buttonTitles.count - 1) {
            UIView * line = [[UIView alloc] init];
            line.backgroundColor = [self.style.lineColor colorWithAlphaComponent:kSplitLineHeight];
            line.frame  = CGRectMake(CGRectGetMaxX(button.frame) - kSplitLineHeight, button.frame.origin.y, kSplitLineHeight, kWJAlertViewDefaultButtonHeight);
            [scrollView addSubview:line];
        }
    }
}

- (void)btnDidClick:(UIButton *)button
{
    if ([button.currentTitle isEqualToString:self.cancelButtonTitle] && self.cancelAction) {
        self.cancelAction();
    }
    else if (self.btnAction) {
        self.btnAction(button.tag);
    }
    [self close];
}

- (void)showWithButtonClickAction:(WJAlertViewBtnDidClickAction)btnAction
{
    self.btnAction = btnAction;
    [self show];
}

- (void)show
{
    if (self.dialogView == nil) {
        self.dialogView = [self createContainerView];
    }
    
    self.dialogView.layer.shouldRasterize = YES;
    self.dialogView.layer.rasterizationScale = [[UIScreen mainScreen] scale];
    
    self.layer.shouldRasterize = YES;
    self.layer.rasterizationScale = [[UIScreen mainScreen] scale];
    
    self.backgroundColor = [self.backgroundColor colorWithAlphaComponent:0];
    
    [self addSubview:self.dialogView];
    
    CGFloat x = (self.frame.size.width - self.dialogView.frame.size.width) * 0.5;
    CGFloat y = (self.frame.size.height - self.dialogView.frame.size.height) * 0.5;
    
    self.dialogView.frame = CGRectMake(x, y, self.dialogView.frame.size.width, self.dialogView.frame.size.height);
    
//    [[[[UIApplication sharedApplication] windows] firstObject] addSubview:self];
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    self.dialogView.layer.opacity = 0.5f;
    self.dialogView.layer.transform = CATransform3DMakeScale(1.3f, 1.3f, 1.0);
    
    [UIView animateWithDuration:0.2f delay:0.0 options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.backgroundColor = [self.backgroundColor colorWithAlphaComponent:0.4];
                         self.dialogView.layer.opacity = 1.0f;
                         self.dialogView.layer.transform = CATransform3DMakeScale(1, 1, 1);
                     }
                     completion:NULL
     ];
}


- (void)close
{
    CATransform3D currentTransform = self.dialogView.layer.transform;
    
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_7_1) {
        CGFloat startRotation = [[self.dialogView valueForKeyPath:@"layer.transform.rotation.z"] floatValue];
        CATransform3D rotation = CATransform3DMakeRotation(-startRotation + M_PI * 270.0 / 180.0, 0.0f, 0.0f, 0.0f);
        
        self.dialogView.layer.transform = CATransform3DConcat(rotation, CATransform3DMakeScale(1, 1, 1));
    }
    
    self.dialogView.layer.opacity = 1.0f;
    
    [UIView animateWithDuration:0.2f delay:0.0 options:UIViewAnimationOptionTransitionNone
                     animations:^{
                         self.backgroundColor = [self.backgroundColor colorWithAlphaComponent:0];
                         self.dialogView.layer.transform = CATransform3DConcat(currentTransform, CATransform3DMakeScale(0.6f, 0.6f, 1.0));
                         self.dialogView.layer.opacity = 0.0f;
                     }
                     completion:^(BOOL finished) {
                         for (UIView *v in [self subviews]) {
                             [v removeFromSuperview];
                         }
                         [self removeFromSuperview];
                     }
     ];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (self.buttonTitles.count == 0) {
        [self close];
    }
}
@end

@implementation WJAlertViewStyle
- (UIColor *)backColor
{
    if (_backColor == nil) {
        _backColor = [UIColor whiteColor];
    }
    return _backColor;
}

- (UIColor *)lineColor
{
    if (_lineColor == nil) {
        _lineColor = [UIColor lightGrayColor];
    }
    return _lineColor;
}

- (UIColor *)titleColor
{
    if (_titleColor == nil) {
        _titleColor = kGlobalTextColor;
    }
    return _titleColor;
}

- (UIColor *)messageColor
{
    if (_messageColor == nil) {
        _messageColor = kGlobalTextColor;
    }
    return _messageColor;
}

- (UIColor *)btnTitleColor
{
    if (_btnTitleColor == nil) {
        _btnTitleColor = [UIColor colorWithRed:246/255.0 green:114/255.0 blue:46/255.0 alpha:1.0];
    }
    return _btnTitleColor;
}

- (UIColor *)cancelBtnTitleColor
{
    if (_cancelBtnTitleColor == nil) {
        _cancelBtnTitleColor = self.btnTitleColor;
    }
    return _cancelBtnTitleColor;
}

- (UIColor *)borderColor
{
    if (_borderColor == nil) {
        _borderColor = kGlobalLineColor;
    }
    return _borderColor;
}

- (CGFloat)borderWidth
{
    if (_borderWidth == 0) {
        _borderWidth = kSplitLineHeight;
    }
    return _borderWidth;
}

- (CGFloat)titleFontSize
{
    if (_titleFontSize == 0) {
        _titleFontSize = 16;
    }
    return _titleFontSize;
}

- (CGFloat)messageFontSize
{
    if (_messageFontSize == 0) {
        _messageFontSize = 14;
    }
    return _messageFontSize;
}

- (CGFloat)btnTitleFontSize
{
    if (_btnTitleFontSize == 0) {
        _btnTitleFontSize = self.titleFontSize;
    }
    return _btnTitleFontSize;
}
@end
