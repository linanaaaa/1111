//
//  MessageModel.h
//  吾家超市
//
//  Created by iMac15 on 2016/12/12.
//  Copyright © 2016年 iMac15. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageModel : NSObject
@property (copy, nonatomic) NSString *content;      //我的消息
@property (copy, nonatomic) NSString *createDate;
@property (copy, nonatomic) NSString *id;
@property (copy, nonatomic) NSString *modifyDate;
@property (copy, nonatomic) NSString *title;
@end

@interface MessageResult : WJBaseRequestResult
@property (strong, nonatomic) NSArray *t;
@end
