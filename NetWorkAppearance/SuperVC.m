//
//  SuperVC.m
//  NetWorkAppearance
//
//  Created by Chan on 2016/12/24.
//  Copyright © 2016年 Chan. All rights reserved.
//

#import "SuperVC.h"

@interface SuperVC () <UIScrollViewDelegate> {
    UITapGestureRecognizer *_tap;  //用于点击空白处收起键盘
}

@end

@implementation SuperVC

#pragma mark --dealloc
- (void)dealloc {
    NSLog(@"%@释放了",NSStringFromClass([self class]));
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self  releaseNetWork];
}

#pragma mark --UIViewController生命周期方法
- (void)viewDidLoad {
    [super  viewDidLoad];
    _networks = [NSMutableArray new];
    self.view.backgroundColor = [UIColor whiteColor];
    //开始监控网络链接状态
    NSLog(@"-------------->netWork:%zd",[AFNetworkReachabilityManager sharedManager].networkReachabilityStatus);
    [[AFNetworkReachabilityManager sharedManager]  setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status == 0) {
            NSLog(@"------>>>Wi-Fi disConnect!");
        }
    }];
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyBoard:)];
    tap.cancelsTouchesInView = NO;
    tap.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:tap];
    for (UIScrollView *scrollView in self.view.subviews) {
        if ([scrollView isKindOfClass:[UITableView class]] || [scrollView isKindOfClass:[UICollectionView class]]) {
            [scrollView addGestureRecognizer:tap];
            scrollView.delegate = self;
        }
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
}

#pragma mark --private Method
- (void)hideKeyBoard:(UITapGestureRecognizer *)tap {
    [self.view endEditing:YES];
}

- (void)addNetWork:(NSURLSessionDataTask *)task {
    [_networks addObject:task];
}

//手动释放网络操作
- (void)releaseNetWork {
    for (NSURLSessionDataTask*task in _networks) {
        if ([task isKindOfClass:[NSURLSessionDataTask  class]]) {
            [task cancel];
        }
    }
}

#pragma mark --UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}
@end

