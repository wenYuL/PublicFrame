//
//  NSString+Tools.h
//  Public_Util
//
//  Created by 刘文裕 on 2018/7/18.
//  Copyright © 2018年 wenYuL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Tools)

#pragma mark - SHA
- (NSString *)public_getSHA1String;

- (NSString *)public_getSHA256String;

- (NSString *)public_encodeBase64String;

- (NSString *)public_decodeBase64String;

#pragma mark -- md5加密
- (NSString *)public_format32bitMd5With:(NSString *)str;

#pragma mark -- json转dic
- (NSDictionary *)public_formatJsonStringToDicWith:(NSString *)json;

#pragma mark -- json转array
- (NSArray *)public_formatJsonStringToArrayWith:(NSString *)json;

@end
