//
//  StatusModel.m
//  NetWorkAppearance
//
//  Created by Chan on 2016/12/8.
//  Copyright © 2016年 Chan. All rights reserved.
//

#import "StatusModel.h"

@implementation StatusModel

- (instancetype)initWithError:(NSError *)error  {
    self = [super init];
    if (self) {
        self.code = error.code;
    }
    return self;
}
@end
