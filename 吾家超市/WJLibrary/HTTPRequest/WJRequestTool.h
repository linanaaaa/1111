//
//  WJRequestTool.h
//  吾家超市
//
//  Created by iMac15 on 2016/10/24.
//  Copyright © 2016年 iMac15. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AFHTTPSessionManager.h"

typedef NS_ENUM(NSInteger, HTTPMethod){
    HTTPMethodGET,
    HTTPMethodPOST
};

@interface WJBaseRequestResult : NSObject

@property(nonatomic, copy)NSString *content;    //主要用处展示错误或警告原因
@property(nonatomic, copy)NSString *type;       //操作成功或错误或警告
@end

typedef void (^CustomSuccessAction)(WJBaseRequestResult *result, BOOL needShowMessage);

typedef BOOL (^MessageShowRuleBlock)(NSString *url, NSDictionary *param);


@interface WJRequestTool : NSObject

+ (void)setSuccessAction:(CustomSuccessAction)successAction;

+ (void)setMessageShowRule:(MessageShowRuleBlock)ruleBlock;

+ (void)get:(NSString *)url param:(id)param successBlock:(void (^)(WJBaseRequestResult *result))success failure:(void (^)(NSError *error))failure;

+ (void)post:(NSString *)url param:(id)param successBlock:(void (^)(WJBaseRequestResult *result))success failure:(void (^)(NSError *error))failure;

+ (void)get:(NSString *)url param:(id)param resultClass:(Class)resultClass successBlock:(void (^)(id result))success failure:(void (^)(NSError *error))failure;

+ (void)post:(NSString *)url param:(id)param resultClass:(Class)resultClass successBlock:(void (^)(id result))success failure:(void (^)(NSError *error))failure;

+ (void)post:(NSString *)url param:(id)param constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))formData successBlock:(void (^)(WJBaseRequestResult *result))success failure:(void (^)(NSError *error))failure;

+ (void)get:(NSString *)url param:(id)param constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))formData successBlock:(void (^)(WJBaseRequestResult *result))success failure:(void (^)(NSError *error))failure;

+ (void)post:(NSString *)url param:(id)param resultClass:(Class)resultClass constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))formData successBlock:(void (^)(id result))success failure:(void (^)(NSError *error))failure;

+ (void)get:(NSString *)url param:(id)param resultClass:(Class)resultClass constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))formData successBlock:(void (^)(id result))success failure:(void (^)(NSError *error))failure;

@end

typedef void (^SetHttpHeaderField)(AFHTTPSessionManager *manager);

@interface WJRequestManager : AFHTTPSessionManager

+ (void)setHeaderField:(SetHttpHeaderField)setHeader;
+ (instancetype)shareManager;
@end


