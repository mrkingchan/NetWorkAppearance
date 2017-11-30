//
//  StatusModel.h
//  NetWorkAppearance
//
//  Created by Chan on 2016/12/8.
//  Copyright © 2016年 Chan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StatusModel : NSObject

@property(nonatomic,strong) NSString *msg;

@property(nonatomic, assign) NSInteger code;

@property(nonatomic,strong) id data;

-(instancetype)initWithError:(NSError *)error;

@end
