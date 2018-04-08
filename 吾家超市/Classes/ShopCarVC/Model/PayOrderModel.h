//
//  PayOrderModel.h
//  吾家超市
//
//  Created by iMac15 on 2017/1/19.
//  Copyright © 2017年 iMac15. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 请求成功--
 {
 content = "操作成功";
 t =     {
 appid = wx60fc28fc4d4926ac;
 body = "稻香村桃酥1000g礼盒装 糕点 零食 点心 年货糕点礼盒北京特产";
 "mch_id" = 1430107002;
 "nonce_str" = 41;
 "notify_url" = "http://ios.wujiaw.com/payment/notify/async/2017011962822.jhtml";
 "out_trade_no" = 2017011962822;
 sign = daf7911f25e6a3391d3941a74339a698;
 "spbill_create_ip" = "127.0.0.1";
 "total_fee" = "0.01";
 "trade_type" = APP;
 };
 type = success;
 }
 */

@interface PayOrderModel : NSObject
//@property (copy,   nonatomic) NSString *appid;
//@property (copy,   nonatomic) NSString *body;
//@property (copy,   nonatomic) NSString *mch_id;
//@property (copy,   nonatomic) NSString *noncestr;
//@property (copy,   nonatomic) NSString *notify_url;
//@property (copy,   nonatomic) NSString *out_trade_no;
//@property (copy,   nonatomic) NSString *sign;
//@property (copy,   nonatomic) NSString *spbill_create_ip;
//@property (copy,   nonatomic) NSString *total_fee;
//@property (copy,   nonatomic) NSString *trade_type;

@property (copy,   nonatomic) NSString *appid;
@property (copy,   nonatomic) NSString *noncestr;
@property (copy,   nonatomic) NSString *package;
@property (copy,   nonatomic) NSString *partnerid;
@property (copy,   nonatomic) NSString *prepayid;
@property (copy,   nonatomic) NSString *sign;
@property (copy,   nonatomic) NSString *timestamp;

@end

@interface PayOrderResult : WJBaseRequestResult
@property (strong, nonatomic) PayOrderModel *t;
@end

@interface AlipayOrderModel : NSObject
@property (copy,   nonatomic) NSString *orderStr;
@property (copy,   nonatomic) NSString *private;
@end

@interface AlipayOrderResult : WJBaseRequestResult
@property (strong, nonatomic) AlipayOrderModel *t;
@end


/*
 *  支付宝回调
 */

/*
result = {
 memo = "";
 result = "{
 \"alipay_trade_app_pay_response\":{
    \"code\":\"10000\",
    \"msg\":\"Success\",
    \"app_id\":\"2017061207475931\",
    \"auth_app_id\":\"2017061207475931\",
    \"charset\":\"utf-8\",
 \"timestamp\":\"2017-06-14 10:05:03\",
 \"total_amount\":\"0.01\",
 \"trade_no\":\"2017061421001004240276970270\",
 \"seller_id\":\"2088011591391813\",
 \"out_trade_no\":\"20170614001233\"
 },
 \"sign\":\"ar0TAcr5B7GZ5HZMyk5TvwbX5peHCokealUAWnyNGUaF0nXhFMbm6iT4Dl1kuvr7zIjewHefwOk4nbFry8Nt8pTBZQ1+IUZAOHK6JiSIqZOZFsPTNIA0+4Rzp/K3+snzco76IjLaEl/PbflSl59RiKGtfN6FoEF6AlGiqkAgY4PsOSPiSg16i2ub97WsTiVRt6icJcGMz3sFndFMEySB6KpLpmZHUS54W4hn5hlFWK52kUabH32XDNeRycor2Z0g5o0c65c8zn0SRxZO1H/A4t5mAIKkn1qdu0hIFouVbIefyxa4I0NTjfoBLnDJBIat5YYaSmG/whYsIiTUkzkdog==\",
 \"sign_type\":
 \"RSA2\"
 }";
 resultStatus = 9000;
 }
 */

@interface AlipaySuccessModel : NSObject
@property (copy,   nonatomic) NSString *code;
@property (copy,   nonatomic) NSString *msg;
@property (copy,   nonatomic) NSString *app_id;
@property (copy,   nonatomic) NSString *auth_app_id;
@property (copy,   nonatomic) NSString *charset;
@property (copy,   nonatomic) NSString *timestamp;
@property (copy,   nonatomic) NSString *total_amount;
@property (copy,   nonatomic) NSString *trade_no;
@property (copy,   nonatomic) NSString *seller_id;
@property (copy,   nonatomic) NSString *out_trade_no;

@property (copy,   nonatomic) NSString *sub_code;
@property (copy,   nonatomic) NSString *sub_msg;
@end

@interface AlipaySuccessResult : NSObject
@property (strong, nonatomic) AlipaySuccessModel *alipay_trade_app_pay_response;
@property (copy,   nonatomic) NSString *sign;
@property (copy,   nonatomic) NSString *sign_type;
@end

@interface AlipaySuccess: NSObject
@property (strong, nonatomic) AlipaySuccessResult *result;
@property (copy,   nonatomic) NSString *memo;
@property (copy,   nonatomic) NSString *resultStatus;
@end


/**
 *  获取支付单号
 */
@interface PayOrderPayment : NSObject
@property (copy, nonatomic) NSString *orderSns;
@end

@interface PayOrderPaymentResult : WJBaseRequestResult
@property (strong, nonatomic) PayOrderPayment *t;
@end


