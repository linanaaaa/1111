//
//  WJUpdateApp.h
//  吾家网
//
//  Created by iMac15 on 2017/6/23.
//  Copyright © 2017年 iMac15. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WJUpdateApp : NSObject

+(void)wj_updateWithAPPID:(NSString *)appid block:(void(^)(NSString *currentVersion,NSString *storeVersion, NSString *openUrl,BOOL isUpdate))block;

@end
