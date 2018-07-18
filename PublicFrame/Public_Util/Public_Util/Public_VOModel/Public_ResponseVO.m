//
//  Public_ResponseVO.m
//  Public_Util
//
//  Created by 刘文裕 on 2018/7/18.
//  Copyright © 2018年 wenYuL. All rights reserved.
//

#import "Public_ResponseVO.h"
#import <YYModel/YYModel.h>

@implementation Public_ResponseVO

+(NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{
             @"protocolName":@"PTN",
             @"retCode":@"RETURNRESULT"};
}
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [self yy_modelEncodeWithCoder:aCoder];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    return [self yy_modelInitWithCoder:aDecoder];
}

- (NSString*)description{
    return [self yy_modelToJSONString];
}

@end

@interface Public_ResponseResult()<YYModel>


@end


@implementation Public_ResponseResult
+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{
             @"result":@"RESULT",
             @"retCode":@"RETCODE",
             @"args":@"ARGS"};
}

- (NSString*)description{
    return [self yy_modelToJSONString];
}

@end




