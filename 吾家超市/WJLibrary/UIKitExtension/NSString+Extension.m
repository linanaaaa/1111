//
//  NSString+Extension.m
//  吾家超市
//
//  Created by iMac15 on 2016/10/24.
//  Copyright © 2016年 iMac15. All rights reserved.
//

#import "NSString+Extension.h"
#import "RSA.h"

@implementation NSString (Extension)

+ (NSString *)transformToPinyinWithString:(NSString *)string {
    NSMutableString *mutableString = [NSMutableString stringWithString:string];
    
    CFStringTransform((CFMutableStringRef)mutableString, NULL, kCFStringTransformToLatin, false);
    
    mutableString = (NSMutableString *)[mutableString stringByFoldingWithOptions:NSDiacriticInsensitiveSearch locale:[NSLocale currentLocale]];
    return mutableString;
}

- (NSString *)firstLetter
{
    return [[self substringToIndex:1] lowercaseString];
}

- (NSInteger)stringLenght
{
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSData* da = [self dataUsingEncoding:enc];
    return da.length;
}

//+ (NSString *)encryptString:(NSString *)string
//{
//    NSString *publicKey = @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDAMjG7ZtGL+Mr43zcQCnPo/VVrD9iEhdr2l6/c4fUmgsiWQ1nQ18oPFLB2R26lY7wM3BdHSPlTejtKIvfp4f+GS7NEzL/TruM2s3G6JwSUH+D6EwHH1Co+4qR6JbUJdzkVmXbuSZdTsiViLO9vC6SdJN8cMmBRZj93YojXjk+T2wIDAQAB";
//    
//    NSString *ret = [RSA encryptString:string publicKey:publicKey];
//    WJLog(@"encrypted: %@", ret);
//    
//    return ret;
//}

@end
