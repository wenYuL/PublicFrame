//
//  Public_RequestManager.m
//  Public_Util
//
//  Created by 刘文裕 on 2018/7/18.
//  Copyright © 2018年 wenYuL. All rights reserved.
//

#import "Public_RequestManager.h"

#import <AFNetworking.h>
#import <YYModel/YYModel.h>

@implementation Public_RequestManager

/**
 *   同步请求
 */
+ (void)public_requestWithUrl:(NSString *)url request:(Public_RequestVO *)request success:(successBlock)success failure:(failureBlock)failure {
    [self until_syncRequestWithType:Public_Post url:url request:request success:success failure:failure];
}

/**
 *   异步请求
 */
+ (void)public_asyncRequestWithUrl:(NSString *)url request:(Public_RequestVO *)request success:(successBlock)success failure:(failureBlock)failure {
    [self until_asyncRequestWithType:Public_Post url:url request:request success:success failure:failure];
}


#pragma mark - RequestBaseActions
/**
 Json get/post无SSL证书验证数据请求 (同步)
 */
+ (void)until_syncRequestWithType:(Public_RequestMethod)type url:(NSString *)url  request:(Public_RequestVO *)request success:(successBlock)success failure:(failureBlock)failure {
    //1.配置请求
    AFHTTPSessionManager *manager = [self until_getRequestManagerMethodWithSSL:NO];
    
    //2.加载请求
    if (type == Public_Get) {
        [self until_getRequestWithManager:manager url:url request:request progress:nil success:^(id responseObject) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (success) {
                    success(responseObject);
                }
            });
        } failure:^(NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (failure) {
                    failure(error);
                }
            });
        }];
    }else{
        [self until_postRequestWithManager:manager url:url request:request progress:nil success:^(id responseObject) {
            if (success) {
                success(responseObject);
            }
        } failure:^(NSError *error) {
            if (failure) {
                failure(error);
            }
        }];
    }
}

/**
 Json get/post无SSL证书验证数据请求 (异步)
 */
+ (void)until_asyncRequestWithType:(Public_RequestMethod)type url:(NSString *)url  request:(Public_RequestVO *)request success:(successBlock)success failure:(failureBlock)failure {
    //1.配置请求
    AFHTTPSessionManager *manager = [self until_getRequestManagerMethodWithSSL:NO];
    
    //2.加载请求
    if (type == Public_Get) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [self until_getRequestWithManager:manager url:url request:request progress:nil success:^(id responseObject) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (success) {
                        success(responseObject);
                    }
                });
            } failure:^(NSError *error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (failure) {
                        failure(error);
                    }
                });
            }];
        });
    }else{
        
        [self until_postRequestWithManager:manager url:url request:request progress:nil success:^(id responseObject) {
            
            if (success) {
                
                success(responseObject);
            }
            
        } failure:^(NSError *error) {
            
            if (failure) {
                failure(error);
            }
            
        }];
        
    }
}

#pragma mark - other Methods
+ (AFHTTPSessionManager *)until_getRequestManagerMethodWithSSL:(BOOL)ssl {
    //1.创建管理者对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer  = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/html",@"index.jsp", @"text/json", @"text/plain", @"text/javascript", @"text/xml", @"image/*", nil];//兼容后台的@"text/html"数据格式
    manager.requestSerializer.timeoutInterval = 25;//设置请求超时时间
    
//        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    //需要证书验证
    if (ssl) {
//        1.获取证书data
//                NSString *cerPath = [[NSBundle mainBundle] pathForResource:YLSSLCerName ofType:@"cer"];
//                NSData   *cerData = [NSData dataWithContentsOfFile:cerPath];
//
//                //2.支持https（校验证书，不可以抓包)
//                AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];//使用证书验证模式
//                securityPolicy.allowInvalidCertificates = YES;
//                securityPolicy.validatesDomainName      = NO;
//                securityPolicy.pinnedCertificates       = [NSSet setWithObject:cerData];
//                manager.securityPolicy = securityPolicy;
    }
    
    return manager;
}


/**
 *   GET请求
 */
+ (void)until_getRequestWithManager:(AFHTTPSessionManager *)manager url:(NSString *)url request:(Public_RequestVO *)request progress:(progressBlock)progress success:(successBlock)success failure:(failureBlock)failure{
    
    NSString *baseURL = url;
    [manager GET:baseURL parameters:request progress:^(NSProgress * _Nonnull uploadProgress){
        if (progress) {
            progress(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            
            Public_ResponseVO *responseVO = [[request getResponseClass] yy_modelWithJSON:responseObject];
            success(responseVO);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}


+ (void)until_postRequestWithManager:(AFHTTPSessionManager *)manager url:(NSString *)url request:(Public_RequestVO *)request progress:(progressBlock)progress success:(successBlock)success failure:(failureBlock)failure{

    
    NSDictionary*dic = [NSJSONSerialization JSONObjectWithData:request.yy_modelToJSONData options:NSJSONReadingMutableContainers error:nil];

    NSString *baseURL = url;
    [manager POST:baseURL parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            
            NSString *result = responseObject[@"RETURNRESULT"][@"RESULT"];
            if (result.longLongValue > 0) {
                Public_ResponseVO *responseVO = [[request getResponseClass] yy_modelWithJSON:responseObject];
                success(responseVO);
            }else {//其它数据状态

                Public_ResponseVO *responseVO = [[request getResponseClass] yy_modelWithJSON:responseObject];
                success(responseVO);
                /*
                Public_ResponseVO *responseVO = [[request getResponseClass] yy_modelWithJSON:responseObject];
                Public_ResponseResult *result = nil;
                if ([[request getResponseClass] instancesRespondToSelector:@selector(returnResult)]) {
                    result = [responseVO valueForKeyPath:@"returnResult"];
                }
                if ([[request getResponseClass] instancesRespondToSelector:@selector(result)]) {
                    result = [responseVO valueForKeyPath:@"result"];
                }

                success(responseVO);
                */
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}














@end
