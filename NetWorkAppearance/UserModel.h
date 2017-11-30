//
//  UserModel.h
//  NetWorkAppearance
//
//  Created by Chan on 2016/12/23.
//  Copyright © 2016年 Chan. All rights reserved.
//

#import "BaseModel.h"

@interface UserModel : BaseModel

@property(nonatomic,strong) NSString *userName;

+ (NSURLSessionDataTask *)loginWithUserName:(NSString *)userName
                                   passWord:(NSString *)passWord
                                     Sucess:(responseBlock)success
                                    Failure:(responseBlock)failure;

@end
