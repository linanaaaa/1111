//
//  UITableViewCell+Extension.m
//  吾家超市
//
//  Created by iMac15 on 2016/10/24.
//  Copyright © 2016年 iMac15. All rights reserved.
//

#import "UITableViewCell+Extension.h"

@implementation UITableViewCell (Extension)

+ (instancetype)cellWithTableView:(UITableView *)tableView reuseIdentifier:(NSString *)identifier
{
    id cell = [tableView dequeueReusableCellWithIdentifier:identifier];

    if  (cell == nil) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    return cell;
}
@end
