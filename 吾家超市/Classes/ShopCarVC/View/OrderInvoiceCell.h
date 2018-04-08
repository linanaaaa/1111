//
//  OrderInvoiceCell.h
//  吾家网
//
//  Created by iMac15 on 2017/6/22.
//  Copyright © 2017年 iMac15. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderInvoiceCell : UITableViewCell<UITextViewDelegate>

+ (instancetype)OrderInvoiceCellWithTableView:(UITableView *)tableView;
@property (strong, nonatomic) UITextView *textView;

@end
