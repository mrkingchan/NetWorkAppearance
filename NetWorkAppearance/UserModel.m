//
//  UserModel.m
//  NetWorkAppearance
//
//  Created by Chan on 2016/12/23.
//  Copyright © 2016年 Chan. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

+(NSURLSessionDataTask *)loginWithUserName:(NSString *)userName
                                  passWord:(NSString *)passWord
                                    Sucess:(responseBlock)success Failure:(responseBlock)failure {
    NSMutableDictionary *params = [NSMutableDictionary new];
    [params setValue:userName forKey:@""];
    [params setValue:params forKey:@""];
    return [[self class] innerPostWithPath:@"login/" Params:params
                                    target:self sucess:success Failure:failure];
}

@end
