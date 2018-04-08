//
//  ChooseAddressVC.h
//  吾家网
//
//  Created by HuaCapf on 2017/6/17.
//  Copyright © 2017年 iMac15. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXTagsView.h"

typedef void (^ChooseEditAdd)(NSString *address, NSString *code);

@interface ChooseAddressVC : UIViewController
@property (copy, nonatomic) ChooseEditAdd chooseEditAdd;
@end
