//
//  WJRequestTool.m
//  吾家超市
//
//  Created by iMac15 on 2016/10/24.
//  Copyright © 2016年 iMac15. All rights reserved.
//

#import "WJRequestTool.h"

typedef void (^FormDataBlock)(id <AFMultipartFormData> formData);
typedef void (^SuccessBlock)(NSURLSessionDataTask * task, id responseObject);
typedef void (^FailureBlock)(NSURLSessionDataTask * task, NSError * error);

@implementation WJRequestManager

static WJRequestManager *_instance;

SetHttpHeaderField _setHeader;

+ (void)setHeaderField:(SetHttpHeaderField)setHeader
{
    _setHeader = setHeader;
}

+ (instancetype)shareManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[WJRequestManager alloc] initWithBaseURL:nil];
        
        _instance.requestSerializer = [AFHTTPRequestSerializer serializer];
        _instance.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        
        NSOperationQueue *operationQueue = _instance.operationQueue;
        [_instance.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            switch (status) {
                case AFNetworkReachabilityStatusReachableViaWWAN:
                case AFNetworkReachabilityStatusReachableViaWiFi:
                    [operationQueue setSuspended:NO];
                    break;
                case AFNetworkReachabilityStatusNotReachable:
                default:
                    [MBProgressHUD hideHUD];
                    [MBProgressHUD showTextMessage:@"网络不可用!"];
                    [operationQueue setSuspended:YES];
                    break;
            }
        }];
        
        [_instance.reachabilityManager startMonitoring];
        
        _instance.requestSerializer.timeoutInterval = 10;
    });
    if (_setHeader) {
        _setHeader(_instance);
    }
    
    return _instance;
}
@end


@interface WJRequestTool ()

@end


@implementation WJRequestTool

static BOOL _showMessage;

CustomSuccessAction _successAction;
MessageShowRuleBlock _ruleBlock;

+ (void)setSuccessAction:(CustomSuccessAction)successAction
{
    _successAction = successAction;
}

+ (void)setMessageShowRule:(MessageShowRuleBlock)ruleBlock
{
    _ruleBlock = ruleBlock;
}

#pragma mark - 是否显示消息提示

+ (void)showMBProgressHUDWithParam:(NSDictionary *)param andUrl:(NSString *)url
{
    _showMessage = YES;
    if (_ruleBlock) {
        _showMessage = _ruleBlock(url, param);
    }
}

+ (void)request:(NSString *)url method:(HTTPMethod)httpMethod param:(id)param resultClass:(Class)resultClass constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))formData successBlock:(void (^)(id result))success failure:(void (^)(NSError *error))failure
{    
    NSDictionary *dictParam = [param mj_keyValues];
    
    kWeakSelf
    
    SuccessBlock successBlock = ^(NSURLSessionDataTask *task, id responseObject) {
        [weakSelf successWithResponseObj:responseObject resultClass:resultClass andSuccessBlock:success];
    };
    
    FailureBlock failureBlock = ^(NSURLSessionDataTask *task, NSError *error) {
        [weakSelf failureWithError:error andFailureBlock:failure];
    };
    
    [self showMBProgressHUDWithParam:dictParam andUrl:url];
    
    if (_showMessage) {
        [MBProgressHUD showLoadingMessage:@""];
    }
    
    WJRequestManager *manager = [WJRequestManager shareManager];
    
    if (httpMethod == HTTPMethodGET) {
        [manager GET:url parameters:dictParam progress:nil success:successBlock failure:failureBlock];
    }
    else if (httpMethod == HTTPMethodPOST) {
        if (formData) {
            FormDataBlock formDataBlock = ^(id <AFMultipartFormData> data) {
                if (formData) {
                    formData(data);
                }
            };
            [manager POST:url parameters:dictParam constructingBodyWithBlock:formDataBlock progress:nil success:successBlock failure:failureBlock];
        }
        else {
            [manager POST:url parameters:dictParam progress:nil success:successBlock failure:failureBlock];
        }
    }
}

#pragma mark - 请求失败统一回调
+ (void)failureWithError:(NSError *)error andFailureBlock:(void (^)(NSError *))failure
{
    [MBProgressHUD showTextMessage:@"网络链接异常!"];
    WJLog(@"%@", error);
    if (failure) {
        failure(error);
        [MBProgressHUD hideHUD];
    }
}

#pragma mark - 请求成功统一回调
+ (void)successWithResponseObj:(id)responseObj resultClass:(Class)resultClass andSuccessBlock:(void (^)(id responseObj))success
{
    id response = [NSJSONSerialization JSONObjectWithData:responseObj options:NSJSONReadingAllowFragments error:nil];
    WJLog(@"\n-->接口数据**请求成功\n%@\n<--*********", response);
    
    WJBaseRequestResult *result = (WJBaseRequestResult *)[resultClass mj_objectWithKeyValues:response];
    
    if (_successAction) {
        _successAction(result, _showMessage);
    }
        
    // 执行成功回调
    if (success) {
        
        if ([result.type isEqualToString:@"success"]) {
            success(result);
        }
        else if([result.type isEqualToString:@"error"]){
            if (![result.type isEqualToString:@"error"] && ![result.content isEqualToString:@"未登录"]) {
                [MBProgressHUD showTextMessage:result.content hideAfter:2.0f];
            }
            success(result);
        }
        else if([result.type isEqualToString:@"warn"]){
            [MBProgressHUD showTextMessage:result.content hideAfter:2.0f];
        }
        else{
            [MBProgressHUD showTextMessage:@"" hideAfter:1.0f];
        }
    }
}

+ (void)post:(NSString *)url param:(id)param successBlock:(void (^)(WJBaseRequestResult *result))success failure:(void (^)(NSError *error))failure
{
    [self request:url method:HTTPMethodPOST param:param resultClass:[WJBaseRequestResult class] constructingBodyWithBlock:nil successBlock:success failure:failure];
}
+ (void)get:(NSString *)url param:(id)param successBlock:(void (^)(WJBaseRequestResult *result))success failure:(void (^)(NSError *error))failure
{
    [self request:url method:HTTPMethodGET param:param resultClass:[WJBaseRequestResult class] constructingBodyWithBlock:nil successBlock:success failure:failure];
}


+ (void)post:(NSString *)url param:(id)param resultClass:(Class)resultClass successBlock:(void (^)(id result))success failure:(void (^)(NSError *error))failure
{
    [self request:url method:HTTPMethodPOST param:param resultClass:resultClass constructingBodyWithBlock:nil successBlock:success failure:failure];
}
+ (void)get:(NSString *)url param:(id)param resultClass:(Class)resultClass successBlock:(void (^)(id result))success failure:(void (^)(NSError *error))failure
{
    [self request:url method:HTTPMethodGET param:param resultClass:resultClass constructingBodyWithBlock:nil successBlock:success failure:failure];
}


+ (void)post:(NSString *)url param:(id)param constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))formData successBlock:(void (^)(WJBaseRequestResult *result))success failure:(void (^)(NSError *error))failure
{
    [self request:url method:HTTPMethodPOST param:param resultClass:[WJBaseRequestResult class] constructingBodyWithBlock:formData successBlock:success failure:failure];
}
+ (void)get:(NSString *)url param:(id)param constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))formData successBlock:(void (^)(WJBaseRequestResult *result))success failure:(void (^)(NSError *error))failure
{
    [self request:url method:HTTPMethodGET param:param resultClass:[WJBaseRequestResult class] constructingBodyWithBlock:nil successBlock:success failure:failure];
}

+ (void)post:(NSString *)url param:(id)param resultClass:(Class)resultClass constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))formData successBlock:(void (^)(id result))success failure:(void (^)(NSError *error))failure
{
    [self request:url method:HTTPMethodPOST param:param resultClass:resultClass constructingBodyWithBlock:formData successBlock:success failure:failure];
}

+ (void)get:(NSString *)url param:(id)param resultClass:(Class)resultClass constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))formData successBlock:(void (^)(id result))success failure:(void (^)(NSError *error))failure
{
    [self request:url method:HTTPMethodGET param:param resultClass:resultClass constructingBodyWithBlock:formData successBlock:success failure:failure];
}
@end

@implementation WJBaseRequestResult

@end



