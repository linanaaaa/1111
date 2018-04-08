//
//  ScreenModelVC.h
//  吾家超市
//
//  Created by iMac15 on 2017/1/13.
//  Copyright © 2017年 iMac15. All rights reserved.
//

#import "BaseVC.h"

@interface ScreenModelVC : BaseVC
@property (strong, nonatomic) NSString *screenId;
@property (copy, nonatomic) void (^screenModelClick)(NSString *brandIdStr,NSString *startPrice, NSString *endPrice);
@end
