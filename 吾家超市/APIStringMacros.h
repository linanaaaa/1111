//
//  APIStringMacros.h
//  吾家超市
//
//  Created by iMac15 on 2016/11/21.
//  Copyright © 2016年 iMac15. All rights reserved.
//

#ifndef APIStringMacros_h
#define APIStringMacros_h

/*
 *  AppStore id 应用更新
 */
#define AppStore_ID  @"1251864878"


/**
 *  微信开发者ID
 */

//微信支付商户号
#define MCH_ID  @"1482342732"   //  //1430107002 -- ios 1482342732 -- 安卓

//开户邮件中的（公众账号APPID或者应用APPID）
//#define WX_AppID @"wx60fc28fc4d4926ac"    //旧

#define WX_AppID @"wx071fd0af2e11c644"


//安全校验码（MD5）密钥，商户平台登录账户和密码登录http://pay.weixin.qq.com 平台设置的“API密钥”，为了安全，请设置为以数字和字母组成的32字符串。
#define WX_PartnerKey @"d058fb5ac331d08716c835d6f2b4a687"

//获取用户openid，可使用APPID对应的公众平台登录http://mp.weixin.qq.com 的开发者中心获取AppSecret。
#define WX_AppSecret @"bded18a6eef8c2d2437c1ce88348b43c"

/**
 *  极光推送
 */
//#define kJPushAppKey @"ba032c84fd7fd5d9cffa2a3c"
//#define kJPushChannel @"Publish channel"

//static NSString *appKey = @"ba032c84fd7fd5d9cffa2a3c";
//static NSString *channel = @"Publish channel";
//static BOOL isProduction = FALSE;


/**
 *  处理 iOS10 真机打印日志不完全
 */
#define CLog(format, ...)  NSLog(format, ## __VA_ARGS__)
#define NSLog(FORMAT, ...) printf("%s\n", [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);

/**
 *  测试服务器
 */
#ifdef DEBUG

#define WJLog(format,...) NSLog(@"\n%s--line:%d\n" format, __func__, __LINE__, ##__VA_ARGS__)

//#define kServiceUrl @"http://192.168.18.182:8080"   //王瑞Pc

//#define kServiceUrl @"http://ios.wujiaw.com"        //线上环境

//#define kServiceUrl @"http://192.168.1.103:8080/app"   //姜卓Pc   13521699952  q123456

//#define kServiceUrl @"http://b2b.wujiaw.com/app"        //58线上环境

#define kServiceUrl @"http://ios.wujiaw.com/app"        //线上环境

#else
/**
 *  线上环境
 */

#define WJLog(...)

#define kServiceUrl @"http://ios.wujiaw.com/app"        //线上环境

#endif

/** print 打印rect,size,point */
#ifdef DEBUG

#define kLogPoint(point)        NSLog(@"%s = { x:%.4f, y:%.4f }", #point, point.x, point.y)
#define kLogSize(size)          NSLog(@"%s = { w:%.4f, h:%.4f }", #size, size.width, size.height)
#define kLogRect(rect)          NSLog(@"%s = { x:%.4f, y:%.4f, w:%.4f, h:%.4f }", #rect, rect.origin.x, rect.origin.y, rect.size.width, rect.size.height)

#endif


/**
 *  url拼接
 */
#define kFullUrlPath(path) [NSString stringWithFormat:@"%@%@", kServiceUrl,path]

/**
 *  图片拼接
 */
#define kServiceN7Url @"https://img11.360buyimg.com/n7/"     //商品小图
#define kServiceN1Url @"https://img11.360buyimg.com/n1/"     //商品大图

/**
 *  自动登录
 */

//检查登录
#define kAutoCheckUrl                    kFullUrlPath(@"/login/check")

//获取公钥---自动登录-获取section
#define kAutoPublicKeyUrl                kFullUrlPath(@"/common/public_key1")


/**
 *  商城-买家注册
 */

//获取公钥
#define kPublicKeyUrl                    kFullUrlPath(@"/common/public_key1")

//买家---短信验证码
#define kSendSMSUrl                      kFullUrlPath(@"/sms/send")

//买家---短信验证码 验证
#define kValidateUrl                      kFullUrlPath(@"/sms/validate")

//买家---注册
#define kRegisterUrl                     kFullUrlPath(@"/register/submit")

//买家---注册 -- 验证手机号
#define kCheck_mobileUrl                 kFullUrlPath(@"/register/check_mobile")

//买家---注册 -- 验证用户名
#define kCheck_usernameUrl                kFullUrlPath(@"/register/check_username")

//买家---登录
#define kLoginUrl                         kFullUrlPath(@"/login/submit")

//买家---重置密码 -- 验证手机号
#define kcheckPhoneUrl                    kFullUrlPath(@"/password/checkPhone")

//买家---重置密码
#define kResetUrl                         kFullUrlPath(@"/password/reset")

//会员消费资本/余额
#define kUserMemberUrl                    kFullUrlPath(@"/login/get_member")

//使用-消费资本/余额--获取验证码
#define kGenerateCodeUrl                  kFullUrlPath(@"/member/order/generateCode")


//买家---收货地址列表
#define kAddrressListUrl                   kFullUrlPath(@"/member/receiver/list")

//买家---添加收货地址
#define kGreatAddressUrl                   kFullUrlPath(@"/member/receiver/save")

//买家---修改收货地址
#define kUpdateAdrressUrl                  kFullUrlPath(@"/member/receiver/update")

//买家---删除收货地址
#define kDeleteAdrressUrl                   kFullUrlPath(@"/member/receiver/delete")

//买家---获取地址
#define kAreaaAdrressUrl                   kFullUrlPath(@"/common/area_mobile")



/**
 *  首页
 */

//广告位
#define kAdPositionIdUrl                   kFullUrlPath(@"/adPosition/index")

//热门优质/商品
#define kHotlistUrl                        kFullUrlPath(@"/product/listProduct")

//商品列表
#define kHoteGoodsUrl                      kFullUrlPath(@"/product/index_page")

//首页 分类数据
#define kHomeGoodsUrl                      kFullUrlPath(@"/product/index")

//搜索
#define kSearchUrl                          kFullUrlPath(@"/product/search")

//商品详情
#define kDetailUrl                          kFullUrlPath(@"/product/detail")

//分类
#define kCategoryUrl                        kFullUrlPath(@"/product_category/index")
#define kAutoCategoryUrl                    kFullUrlPath(@"/product_category/index")


//分类列表
#define kCatePageUrl                        kFullUrlPath(@"/product/page")

//分类下级品牌
#define kCateBrandUrl                       kFullUrlPath(@"/brand/list")

//分类 筛选 类型
#define kCateAttributeUrl                   kFullUrlPath(@"/brand/attribute")


/**
 *  购物车
 */

//购物车商品数
#define kCartNumUrl                        kFullUrlPath(@"/cart/cartNum")

//添加购物车
#define kAddCarUrl                         kFullUrlPath(@"/cart/add")

//购物车列表
#define kCarlistUrl                        kFullUrlPath(@"/cart/list")

//修改购物车
#define kCarEditUrl                        kFullUrlPath(@"/cart/edit")

//删除单个商品
#define kCarDeleteUrl                      kFullUrlPath(@"/cart/delete")

//一键删除商品
#define kCarAllDeleteUrl                   kFullUrlPath(@"/cart/clear")

//勾选商品
#define kCarCheckUrl                       kFullUrlPath(@"/cart/check")

//立即购买商品
#define kCarBuyNowCheckUrl                 kFullUrlPath(@"/cart/buyNowCheck")

//立即购买商品--查看是否可售
#define kGetAreaLimitUrl                   kFullUrlPath(@"/product/getAreaLimit")



/**
 *  订单
 */

//显示购物车数据
#define kOrderInfoUrl                       kFullUrlPath(@"/member/order/info")

//生成订单
#define kOrderCreateUrl                     kFullUrlPath(@"/member/order/create")

//计算预定单
#define kCalculateUrl                       kFullUrlPath(@"/member/order/calculate")

//计算预定单--商品是否可售
#define kOrderGetAreaLimitUrl               kFullUrlPath(@"/member/order/getAreaLimit")

//计算预定单--不可售-返回购物车
#define kOrderGoBackCartUrl                 kFullUrlPath(@"/cart/goBackCart")

//验证优惠码
#define kCouponinfoUrl                      kFullUrlPath(@"/member/order/coupon_info")

//订单列表
#define kOrderListUrl                       kFullUrlPath(@"/member/order/list")

//订单详情
#define kOrderViewUrl                       kFullUrlPath(@"/member/order/view")

//订单跟踪 京东-物流
#define kOrderTrackUrl                      kFullUrlPath(@"/member/order/orderTrack")

//取消订单
#define kCancelOrderUrl                     kFullUrlPath(@"/member/order/cancel")

//获取支付订单号
#define kPaymentUrl                         kFullUrlPath(@"/member/order/payment")

//微信支付
#define kWeiSubmitUrl                       kFullUrlPath(@"/payment")

//支付宝支付
#define kBaoSubmitUrl                       kFullUrlPath(@"/payment")

//微信支付验证
#define kiosValidateUrl                     kFullUrlPath(@"/payment/validate")



/**
 *  退换货
 */

//商品退换货 申请
#define kSalesSaveUrl                       kFullUrlPath(@"/member/return_product/save")

//商品退换货 列表
#define kSalesListUrl                       kFullUrlPath(@"/member/return_product/list")

//商品退换货 变更
#define kSalesEidtUrl                       kFullUrlPath(@"/member/return_product/update")

//商品退换货 详情
#define kSalesDetailsUrl                    kFullUrlPath(@"/member/return_product/view")




/**
 *  我的
 */

//消息
#define kMessageListUrl                      kFullUrlPath(@"/member/message/list")

//添加收藏
#define kAddFavoriteUrl                      kFullUrlPath(@"/member/favorite/add")

//删除收藏
#define kDeleteFavoriteUrl                   kFullUrlPath(@"/member/favorite/delete")

//收藏列表
#define kPavoriteListUrl                     kFullUrlPath(@"/member/favorite/list")

//我的优惠券列表
#define kCouponCodeUrl                       kFullUrlPath(@"/member/coupon_code/list")

//我的优惠券-使用的商品
#define kCouponGoodsUrl                      kFullUrlPath(@"/product/coupon")



#endif /* APIStringMacros_h */
