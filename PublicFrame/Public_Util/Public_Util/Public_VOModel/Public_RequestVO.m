//
//  Public_RequestVO.m
//  Public_Util
//
//  Created by 刘文裕 on 2018/7/18.
//  Copyright © 2018年 wenYuL. All rights reserved.
//

#import "Public_RequestVO.h"
#import <YYModel/YYModel.h>

@implementation Public_RequestVO

- (Class)getResponseClass {
    return nil;
}

- (NSString *)description {
    return [self yy_modelToJSONString];
}

+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"protocolName":@"PTN"};
}

@end
