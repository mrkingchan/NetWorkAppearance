//
//  HttpClient.m
//  NetWorkAppearance
//
//  Created by Chan on 2016/12/8.
//  Copyright © 2016年 Chan. All rights reserved.
//

#import "HttpClient.h"
#define kBaseUrlStr @"http://www.baidu.com/"
@implementation HttpClient

+ (id)shareClient {
    static HttpClient *_shareClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareClient = [[HttpClient alloc]initWithBaseURL:[NSURL URLWithString:kBaseUrlStr]];
        _shareClient.requestSerializer = [AFJSONRequestSerializer serializer];
        _shareClient.responseSerializer = [AFJSONResponseSerializer serializer];
    });
    return _shareClient;
}

@end
