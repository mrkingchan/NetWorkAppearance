//
//  BaseModel.h
//  NetWorkAppearance
//
//  Created by Chan on 2016/12/23.
//  Copyright © 2016年 Chan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StatusModel.h"
#import "HttpClient.h"

typedef void(^responseBlock)(StatusModel *model);

@interface BaseModel : NSObject <NSCoding>

+ (NSURLSessionDataTask *)innerPostWithPath:(NSString *)path
                                     Params:(NSDictionary *)params
                                     target:(id)target
                                     sucess:(responseBlock)success
                                    Failure:(responseBlock)failure;



@end
