//
//  MD5.m
//  hygys
//
//  Created by admin on 15/9/9.
//  Copyright (c) 2015年 BBKJ. All rights reserved.
//

#import "MD5.h"
#import <CommonCrypto/CommonDigest.h>

@implementation MD5


//小写验证码
+ (NSString *)md5HexDigest:(NSString*)input
{
    const char* str = [input UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (CC_LONG)strlen(str), result);
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH];
    
    for (int i=0; i<CC_MD5_DIGEST_LENGTH; i++) {
        //        [ret appendFormat:@"%02x",result[i]];
        [ret appendFormat:@"%02x",result[i]];
    }
    
    return ret;
}

//大写验证码
+ (NSString *)MD5HexDigest:(NSString*)input
{
    const char* str = [input UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (CC_LONG)strlen(str), result);
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH];
    
    for (int i=0; i<CC_MD5_DIGEST_LENGTH; i++) {
        //        [ret appendFormat:@"%02x",result[i]];
        [ret appendFormat:@"%02X",result[i]];
    }
    
    return ret;
}



@end
