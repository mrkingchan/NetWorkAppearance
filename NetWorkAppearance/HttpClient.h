//
//  HttpClient.h
//  NetWorkAppearance
//
//  Created by Chan on 2016/12/8.
//  Copyright © 2016年 Chan. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

#define kHttpClient [HttpClient shareClient]

@interface HttpClient : AFHTTPSessionManager

+(HttpClient *)shareClient;

@end
