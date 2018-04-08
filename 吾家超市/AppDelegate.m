//
//  AppDelegate.m
//  吾家超市
//
//  Created by iMac15 on 2016/10/21.
//  Copyright © 2016年 iMac15. All rights reserved.
//

#import "AppDelegate.h"
#import "BaseNavigationController.h"
#import "TabBarController.h"

#import "WJGuideView.h"     //第一次启动 引导页
#import "WJUpdateApp.h"     //检查更新

#import "WXApi.h"           //微信支付
#import "WXApiObject.h"     //微信支付

#import <AlipaySDK/AlipaySDK.h> //支付宝支付
#import "PayOrderModel.h"

@interface AppDelegate ()<WXApiDelegate>

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    UIViewController *rootVC = [[TabBarController alloc] init];;
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:rootVC];
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    
    [WXApi registerApp:WX_AppID withDescription:@"吾家网_ios"];   //注册微信支付信息
    
    [self loadMBProgressHUD];
    
    /**
     *  启动引导页
     */
    
    NSMutableArray *images = [NSMutableArray new];  //引导页 数组图片
    
    [images addObject:[UIImage imageNamed:@"yindao_1"]];
    [images addObject:[UIImage imageNamed:@"yindao_2"]];
    [images addObject:[UIImage imageNamed:@"yindao_3"]];
    [images addObject:[UIImage imageNamed:@"yindao_4"]];
    
    WJGuideView *guideView = [WJGuideView sharedInstance];
    guideView.window = self.window;
    [guideView showGuideViewWithImages:images
                        andButtonTitle:@"立即体验"
                   andButtonTitleColor:[UIColor redColor]
                      andButtonBGColor:[UIColor clearColor]
                  andButtonBorderColor:[UIColor redColor]];
    
    [self hsUpdateApp];   //监测更新
    return YES;
}

#pragma mark -检查更新
-(void)hsUpdateApp
{
    [WJUpdateApp wj_updateWithAPPID:AppStore_ID block:^(NSString *currentVersion, NSString *storeVersion, NSString *openUrl, BOOL isUpdate)
    {
        if (isUpdate == YES) {
            
            WJAlertView *alert = [[WJAlertView alloc] initWithTitle:@"版本有更新!" message:[NSString stringWithFormat:@"检测到新版本(%@),请更新?",storeVersion] cancelButtonTitle:@"更新" otherButtonTitles:nil, nil];
            [alert show];
            [alert showWithButtonClickAction:^(NSInteger index) {
                
                [ZNGUser logout];
                if (index == 0) {
                    NSURL *url = [NSURL URLWithString:openUrl];
                    [[UIApplication sharedApplication] openURL:url];
                }
            }];
        }
    }];
}

- (void)paySuccess
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"WX_PaySuccess" object:nil];
}

// 支付宝支付
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    kWeakSelf
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            WJLog(@"-->支付宝支付回调处理结果 result = %@",resultDic);
            
            AlipaySuccess *model = [AlipaySuccess mj_objectWithKeyValues:resultDic];
            WJLog(@"-->支付宝支付回调 code: %@",model.resultStatus);
            
            if ([model.resultStatus isEqualToString:@"9000"]) {
                WJLog(@"-->支付宝支付成功");
                [weakSelf paySuccess];
            }
            else if ([model.resultStatus isEqualToString:@"8000"]){
                [MBProgressHUD showTextMessage:@"正在处理中" hideAfter:3.0];
            }
            else if ([model.resultStatus isEqualToString:@"4000"]){
                [MBProgressHUD showTextMessage:@"订单支付失败" hideAfter:3.0];
            }
            else if ([model.resultStatus isEqualToString:@"6001"]){
                [MBProgressHUD showTextMessage:@"用户中途取消" hideAfter:3.0];
            }
            else {
                [MBProgressHUD showTextMessage:@"网络连接出错" hideAfter:3.0];
            }
            
        }];
    }
    else{
        [WXApi handleOpenURL:url delegate:self];
    }
    return YES;
}

//- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
//{    //微信支付 iOS9.0之后回调API接口
//    return [WXApi handleOpenURL:url delegate:self];
//}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{    //微信支付  iOS9.0之前回调API接口
    
    return  [WXApi handleOpenURL:url delegate:self];
}

/*! @brief 发送一个sendReq后，收到微信的回应
 *
 * 收到一个来自微信的处理结果。调用一次sendReq后会收到onResp。
 * 可能收到的处理结果有SendMessageToWXResp、SendAuthResp等。
 * @param resp具体的回应内容，是自动释放的
 */

#pragma mark - WXApiDelegate

-(void)onResp:(BaseResp *)resp {
    kWeakSelf
    
    if ([resp isKindOfClass:[PayResp class]]) {
        PayResp*response=(PayResp*)resp;  // 微信终端返回给第三方的关于支付结果的结构体
        switch (response.errCode) {
            case WXSuccess:
            {// 支付成功，向后台发送消息
                WJLog(@"-->微信支付成功");
                [weakSelf paySuccess];
            }
                break;
            case WXErrCodeCommon:
            { //签名错误、未注册APPID、项目设置APPID不正确、注册的APPID与设置的不匹配、其他异常等
                [MBProgressHUD showTextMessage:@"支付失败" hideAfter:3.0];
                WJLog(@"支付失败");
            }
                break;
            case WXErrCodeUserCancel:
            { //用户点击取消并返回
                WJLog(@"取消支付");
                [MBProgressHUD showTextMessage:@"取消支付" hideAfter:3.0];
            }
                break;
            case WXErrCodeSentFail:
            { //发送失败
                WJLog(@"发送失败");
                [MBProgressHUD showTextMessage:@"发送失败" hideAfter:3.0];
            }
                break;
            case WXErrCodeUnsupport:
            { //微信不支持
                WJLog(@"微信不支持");
                [MBProgressHUD showTextMessage:@"微信不支持" hideAfter:3.0];
            }
                break;
            case WXErrCodeAuthDeny:
            { //授权失败
                WJLog(@"授权失败");
                [MBProgressHUD showTextMessage:@"授权失败" hideAfter:3.0];
            }
                break;
            default:
                break;
        }
    }
}

#pragma mark -设置不显示-MBProgressHUD
- (void)loadMBProgressHUD
{
    [WJRequestTool setMessageShowRule:^BOOL(NSString *url, NSDictionary *param) {
        WJLog(@"request: %@\nparam: %@", url, param);
        if ([param isKindOfClass:[NSString class]]) return YES;
        
        if (   [url isEqualToString:kAutoPublicKeyUrl]
            || [url isEqualToString:kLoginUrl]
            || [url isEqualToString:kAutoCheckUrl]
            || [url isEqualToString:kAdPositionIdUrl]
            || [url isEqualToString:kHotlistUrl]
            || [url isEqualToString:kCateAttributeUrl]
            || [url isEqualToString:kCartNumUrl]
            || [url isEqualToString:kPavoriteListUrl]
            || [url isEqualToString:kCarlistUrl]
            || [url isEqualToString:kOrderGoBackCartUrl]
            || [url isEqualToString:kAutoCategoryUrl]
            || [url isEqualToString:kGetAreaLimitUrl]
            || [url isEqualToString:kDetailUrl]
            )
        {
            return NO;
        }
        else {
            return YES;
        }
    }];
    
    [WJRequestTool setSuccessAction:^(WJBaseRequestResult *result, BOOL needShowMessage)
     {
         [MBProgressHUD hideHUD];
     }];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
