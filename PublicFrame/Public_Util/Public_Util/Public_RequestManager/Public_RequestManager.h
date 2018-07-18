//
//  Public_RequestManager.h
//  Public_Util
//
//  Created by 刘文裕 on 2018/7/18.
//  Copyright © 2018年 wenYuL. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Public_RequestVO.h"
#import "Public_ResponseVO.h"

typedef NS_ENUM(NSInteger, Public_RequestMethod) {
    Public_Post = 1,//post请求
    Public_Get,//get请求
};

typedef void (^progressBlock)(id uploadProgress);
typedef void (^successBlock) (Public_ResponseVO *responseObject);
typedef void (^failureBlock) (NSError *error);

@interface Public_RequestManager : NSObject

/**
 *   同步请求
 */
+ (void)public_requestWithUrl:(NSString *)url request:(Public_RequestVO *)request success:(successBlock)success failure:(failureBlock)failure;

/**
 *   异步请求
 */
+ (void)public_asyncRequestWithUrl:(NSString *)url request:(Public_RequestVO *)request success:(successBlock)success failure:(failureBlock)failure;



@end
