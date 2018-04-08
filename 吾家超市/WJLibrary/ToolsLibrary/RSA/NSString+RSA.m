//
//  NSString+Extension.m
//  吾家超市
//
//  Created by iMac15 on 2017/1/13.
//  Copyright © 2017年 iMac15. All rights reserved.
//

#import "NSString+RSA.h"
#import "RSA.h"

@implementation NSString (RSA)

+ (NSString *)encryptString:(NSString *)string
{
    // 加密时使用的公钥
    NSString *publicKey = @"********";
    
    NSString *ret = [RSA encryptString:string publicKey:publicKey];
    
    return ret;
}

+ (NSString *)encryptString:(NSString *)string andPublicKey:(NSString *)publicKey
{
    NSString *ret = [RSA encryptString:string publicKey:publicKey];
    
    return ret;
}

//base64加密
+ (NSString *)encodeBase64String:(NSString *)string
{
    NSData *dataEn = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSData *dataEnRes = [GTMBase64 encodeData:dataEn];
    
    NSString *ret = [[NSString alloc] initWithData:dataEnRes encoding:NSUTF8StringEncoding];
    
    return ret;
}

//base64解密
+ (NSString *)decodeBase64String:(NSString *)string
{
    NSData *dataEn = [string dataUsingEncoding:NSUTF8StringEncoding];
    
    NSData *resDeBase64 = [GTMBase64 decodeData:dataEn];
    NSString *ret = [[NSString alloc] initWithData:resDeBase64 encoding:NSUTF8StringEncoding];
    
    return ret;
}



+ (BOOL)passwordIsValid:(NSString *)text
{
    NSString *regex = @"^.{6,30}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:text];
}

@end
