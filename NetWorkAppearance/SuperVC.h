//
//  SuperVC.h
//  NetWorkAppearance
//
//  Created by Chan on 2016/12/24.
//  Copyright © 2016年 Chan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SuperVC : UIViewController

@property(nonatomic,strong) NSMutableArray *networks;

- (void)addNetWork:(NSURLSessionDataTask *)task;

- (void)releaseNetWork;

@end
