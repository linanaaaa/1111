//
//  OrderInvoiceCell.m
//  吾家网
//
//  Created by iMac15 on 2017/6/22.
//  Copyright © 2017年 iMac15. All rights reserved.
//

#import "OrderInvoiceCell.h"

@interface OrderInvoiceCell()
@property (strong, nonatomic) UILabel *title;
@end

@implementation OrderInvoiceCell

+ (instancetype)OrderInvoiceCellWithTableView:(UITableView *)tableView
{
    NSString *indentifier = @"OrderInvoiceCell";
    OrderInvoiceCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (cell == nil) {
        cell = [[OrderInvoiceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        
        self.title = [self addLabelWithText:@"发票抬头信息:"];
        
        self.textView = [self addTextViewWithDelegate:self fontSize:14];
        self.textView.layer.backgroundColor = [[UIColor clearColor] CGColor];
        self.textView.layer.borderColor = [[UIColor lightGrayColor]CGColor];
        self.textView.layer.borderWidth = 1.0;
        [ self.textView.layer setMasksToBounds:YES];
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.title.frame = CGRectMake(15, 10, kScreenW - 30, 20);
    self.textView.frame = CGRectMake(15, CGRectGetMaxY(self.title.frame) + 10, kScreenW - 30, 60);
}

@end
