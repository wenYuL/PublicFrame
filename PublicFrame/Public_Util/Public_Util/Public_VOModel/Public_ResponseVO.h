//
//  Public_ResponseVO.h
//  Public_Util
//
//  Created by 刘文裕 on 2018/7/18.
//  Copyright © 2018年 wenYuL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Public_ResponseVO : NSObject
/**
 协议名称
 */
@property (nonatomic,copy) NSString *protocolName;
/**
 *   对象归档
 */
- (void)encodeWithCoder:(NSCoder *)aCoder;
/**
 *  对象恢复
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder;

+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper;

@end



@interface Public_ResponseResult : NSObject
/**
 返回结果 1:成功、-1:失败、0 处理中、2异常
 */
@property (nonatomic,assign) int  result;
/**
 返回码
 */
@property (nonatomic, assign) long long retCode;

/**
 返回信息
 */
@property (nonatomic, copy) NSString *args;

/**
 返回信息message
 */
@property (nonatomic,copy) NSString *message;

@end




