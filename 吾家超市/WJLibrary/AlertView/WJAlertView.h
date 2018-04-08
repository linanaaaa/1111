//
//  WJAlertView.h
//  吾家超市
//
//  Created by iMac15 on 2016/10/24.
//  Copyright © 2016年 iMac15. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void (^WJAlertViewCancelAction)();
typedef void (^WJAlertViewBtnDidClickAction)(NSInteger index);

@interface WJAlertViewStyle : NSObject
/** 弹窗背景色 */
@property(nonatomic,strong) UIColor * backColor;
/** 分割线颜色 */
@property(nonatomic,strong) UIColor * lineColor;
/** 标题颜色 */
@property(nonatomic,strong) UIColor * titleColor;
/** 消息内容颜色 */
@property(nonatomic,strong) UIColor * messageColor;
/** 按钮标题颜色 */
@property(nonatomic,strong) UIColor * btnTitleColor;
/** 取消按钮标题颜色 */
@property(nonatomic,strong) UIColor * cancelBtnTitleColor;
/** 描边颜色 */
@property(nonatomic,strong) UIColor * borderColor;
/** 描边宽度 */
@property(nonatomic,assign) CGFloat borderWidth;
/** 标题字号 */
@property(nonatomic,assign) CGFloat titleFontSize;
/** 消息内容字号 */
@property(nonatomic,assign) CGFloat messageFontSize;
/** 按钮标题字号 */
@property(nonatomic,assign) CGFloat btnTitleFontSize;

@property(nonatomic,assign) CGFloat cornerRadius;
@end

@interface WJAlertView : UIView

@property(nonatomic,strong) WJAlertViewStyle *style;

@property(nonatomic,copy) WJAlertViewBtnDidClickAction btnAction;

@property(nonatomic,copy) WJAlertViewCancelAction cancelAction;

@property(nonatomic,copy) NSString * title;
@property(nonatomic,copy) NSString * message;
@property(nonatomic,copy) NSAttributedString * attributeMessage;

// 自定义对话框试图
@property(nonatomic,weak) UIView * customView;

+ (void)setAlertViewStyle:(WJAlertViewStyle *)style;

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

- (instancetype)initWithTitle:(NSString *)title attributeMessage:(NSAttributedString *)attributeMessage cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

- (void)show;

- (void)showWithButtonClickAction:(WJAlertViewBtnDidClickAction)btnAction;
@end
