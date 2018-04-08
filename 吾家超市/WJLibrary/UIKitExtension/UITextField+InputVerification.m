//
//  UITextField+InputVerification.m
//  吾家超市
//
//  Created by iMac15 on 2016/10/24.
//  Copyright © 2016年 iMac15. All rights reserved.
//

#import "UITextField+InputVerification.h"

@implementation UITextField (InputVerification)

- (BOOL)verifyMobilePhone
{
    NSString *regex = @"^[1][0-9]{10}$";
    NSPredicate * mobilePhone = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    return [mobilePhone evaluateWithObject:self.text];
}

- (void)textLenghtWithLimit:(NSUInteger)lenght
{
    //获取高亮部分
    UITextRange *selectedRange = self.markedTextRange;
    UITextPosition *position = [self positionFromPosition:selectedRange.start offset:0];
    
    // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
    if (!position && !selectedRange.empty)
    {
        if (self.text.length > lenght)
        {
            NSRange rangeIndex = [self.text rangeOfComposedCharacterSequenceAtIndex:lenght];
            if (rangeIndex.length == 1)
            {
                self.text = [self.text substringToIndex:lenght];
            }
            else
            {
                NSRange rangeRange = [self.text rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, lenght)];
                self.text = [self.text substringWithRange:rangeRange];
            }
        }
    }
}
@end
