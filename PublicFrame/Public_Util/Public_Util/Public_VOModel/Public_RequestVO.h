//
//  Public_RequestVO.h
//  Public_Util
//
//  Created by 刘文裕 on 2018/7/18.
//  Copyright © 2018年 wenYuL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Public_RequestVO : NSObject
/**
 *   协议名字
 */
@property(nonatomic,copy)NSString *protocolName;
/**
 *   前置机地址
 */
@property(nonatomic,copy)NSString *baseURL;

/**
 *   获取请求包协议名
 */
- (Class)getResponseClass;

@end
