//
//  BrandListModel.h
//  吾家超市
//
//  Created by iMac15 on 2017/1/10.
//  Copyright © 2017年 iMac15. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BrandListModel : NSObject
@property (copy, nonatomic) NSString *id;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *order;
@property (copy, nonatomic) NSString *logo;
@property (copy, nonatomic) NSString *createDate;
@property (copy, nonatomic) NSString *modifyDate;
@end

@interface BrandListResult : WJBaseRequestResult
@property (strong, nonatomic) NSArray *t;
@end
