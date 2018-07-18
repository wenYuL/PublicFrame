//
//  NSString+Tools.m
//  Public_Util
//
//  Created by 刘文裕 on 2018/7/18.
//  Copyright © 2018年 wenYuL. All rights reserved.
//

#import "NSString+Tools.h"

#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>

#import "NSString+Base64.h"

@implementation NSString (Tools)
#pragma mark - SHA
- (NSString *)public_getSHA1String {
    const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:self.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, (CC_LONG)data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}

- (NSString *)public_getSHA256String {
    const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:self.length];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH];
    
    CC_SHA256(data.bytes, (CC_LONG)data.length, digest);
    
    NSMutableString* result = [NSMutableString stringWithCapacity:CC_SHA256_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA256_DIGEST_LENGTH; i++) {
        [result appendFormat:@"%02x", digest[i]];
    }
    
    return [result substringWithRange:NSMakeRange(0, 16)];
}

- (NSString *)public_encodeBase64String {
    return [self base64EncodedString];
}

- (NSString *)public_decodeBase64String {
    return [self base64DecodedString];
}

#pragma mark -- md5加密
- (NSString *)public_format32bitMd5With:(NSString *)str {
    const char *cStr = [str UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (CC_LONG)strlen(cStr),digest );
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++){
        [result appendFormat:@"%02x", digest[i]];
    }
    
    return result;
}

#pragma mark -- json转dic
- (NSDictionary *)public_formatJsonStringToDicWith:(NSString *)json {
    if (json == nil) {
        return nil;
    }
    
    NSError *err;
    NSData *jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    if(err) {
        return nil;
    }
    
    return dic;
}

#pragma mark -- json转array
- (NSArray *)public_formatJsonStringToArrayWith:(NSString *)json {
    if (json == nil) {
        return nil;
    }
    
    NSError *err;
    NSData *jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *array = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    if(err) {
        return nil;
    }
    
    return array;
}



@end
