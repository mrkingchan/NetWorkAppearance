//
//  BaseModel.m
//  NetWorkAppearance
//
//  Created by Chan on 2016/12/23.
//  Copyright © 2016年 Chan. All rights reserved.
//

#import "BaseModel.h"
#import <objc/runtime.h>
@implementation BaseModel

#pragma mark #############################################################################内部方法禁止直接调用!!!!!

//编码
- (id)initWithCoder:(NSCoder *)aDecoder {
    id model = [[self class] new];
    //获取所有属性
    unsigned int count = 0;
    objc_property_t  *properties = class_copyPropertyList([self class], &count);
    for (int i = 0; i < count; i ++) {
        objc_property_t property = properties[i];
        const char *name = property_getName(property);
        NSString *key = [NSString stringWithUTF8String:name];
        //value
        id value = [aDecoder decodeObjectForKey:key];
        if (value == nil) {
            continue;
        }
        [model setValue:value forKey:key];
    }
    return model;
}

//解码
- (void)encodeWithCoder:(NSCoder *)aCoder {
    unsigned int count = 0;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    for (int i = 0; i < count; i ++) {
        const char *name = property_getName(properties[i]);
        NSString *key = [NSString stringWithUTF8String:name];
        id value = [self valueForKey:key];
        [aCoder encodeObject:value forKey:key];
    }
}

+ (NSURLSessionDataTask *)innerPostWithPath:(NSString *)path
                                Params:(NSDictionary *)params
                                target:(id)target
                                sucess:(responseBlock)success
                               Failure:(responseBlock)failure {
                            NSURLSessionDataTask *task = [kHttpClient POST:path
                                                            parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                                //统一处理成json
                                                                NSDictionary *json = [[self class] transformResponseObjectToJson:responseObject Path:path];
                                                                StatusModel *model;
                                                                if (json) {
                                                                    model = [[self class] StatusModelWithResponseObject:responseObject];
                                                                }
                                                                success(model);
                                                            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                                                StatusModel *model = [[StatusModel alloc]initWithError:error];
                                                                failure(model);
                                                            }];
                                                    //添加网络操作队列
                                                    if ([target  respondsToSelector:@selector(addNet:)]) {
                                                        [target performSelector:@selector(addNet:) withObject:task];
                                                    }
                                                    return task;
}

//class对应的是哪个类型的model 直接从responseModel.data里面提取
+ (StatusModel *)StatusModelWithResponseObject:(id)responseObject {
    return [[self class] statusModelWithjson:responseObject class:self];
}

//映射model
+ (StatusModel *)statusModelWithjson:(NSDictionary *)json class:(Class)class {
    id rs = json[@"data"];
    StatusModel *model = [StatusModel new];
    id returnObject = nil;
    //转data字段对应的值转model
    if ([rs  isKindOfClass:[NSDictionary class]]) {
        returnObject = [class mj_objectWithKeyValues:rs];
    } else if ([rs isKindOfClass:[NSArray class]]) {
        returnObject = [class mj_keyValuesArrayWithObjectArray:rs];
    } else if ([rs isKindOfClass:[NSNull class]]) {
        returnObject = nil;
    }
    model.data = returnObject;
    return model;
}

//统一处理服务器返回的数据
+ (NSDictionary *)transformResponseObjectToJson:(id)responseObject
                                           Path:(NSString *)path {
    NSDictionary *json;
    if ([responseObject isKindOfClass:[NSDictionary class]]) {
        json = responseObject;
    } else {
        NSString *jsonStr;
        if ([responseObject  isKindOfClass:[NSData class]]) {
            jsonStr = [[NSString  alloc] initWithData:responseObject
                                             encoding:NSUTF8StringEncoding];
        } else {
            jsonStr = responseObject;
        }
        NSError *error;
        NSData *jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
        json = [NSJSONSerialization JSONObjectWithData:jsonData
                                               options:NSJSONReadingMutableLeaves error:&error];
    }
    NSLog(@"-----------------_>post:%@\n%@",path,json);
    return  json;
}
@end
