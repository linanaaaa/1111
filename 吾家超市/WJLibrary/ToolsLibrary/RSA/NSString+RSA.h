//
//  NSString+Extension.h
//  吾家超市
//
//  Created by iMac15 on 2017/1/13.
//  Copyright © 2017年 iMac15. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "GTMBase64.h"

@interface NSString (RSA)
/**
 *  字符串进行RSA加密
 *
 *  @param string 需要进行加密的字符串
 *
 *  @return 加密后的字符串
 */
+ (NSString *)encryptString:(NSString *)string;

/**
 *  字符串进行RSA加密
 *
 *  @param string 需要进行加密的字符串
 *
 *  @param publicKey 公钥
 *
 *  @return 加密后的字符串
 */
+ (NSString *)encryptString:(NSString *)string andPublicKey:(NSString *)publicKey;




/**
 *  base64 加密
 *
 *  @param string 需要进行加密的字符串
 */
+ (NSString *)encodeBase64String:(NSString *)string;

/**
 *  base64 解密
 *
 *  @param string 需要进行解密的字符串
 */
+ (NSString *)decodeBase64String:(NSString *)string;



/**
 *  判断字符串 不少于6个字符
 */
+ (BOOL)passwordIsValid:(NSString *)text;

@end
