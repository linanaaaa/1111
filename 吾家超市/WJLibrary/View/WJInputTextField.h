//
//  WJInputTextField.h
//  吾家超市
//
//  Created by iMac15 on 2016/10/25.
//  Copyright © 2016年 iMac15. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WJInputTextField : UITextField

+ (instancetype)inputTextFieldWithTitle:(NSString *)title andPlaceholderText:(NSString *)placeholder delegate:(id)delegate;

+ (instancetype)inputTextFieldWithAttributedString:(NSAttributedString *)attrStr andPlaceholderText:(NSString *)placeholder;
@end
