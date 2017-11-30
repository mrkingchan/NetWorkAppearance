//
//  TabbarVC.m
//  NetWorkAppearance
//
//  Created by Chan on 2016/12/24.
//  Copyright © 2016年 Chan. All rights reserved.
//

#import "TabbarVC.h"

@interface TabbarVC () <UITabBarControllerDelegate>

@end

@implementation TabbarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController  {
    for (UIScrollView *scrollView in viewController.view.subviews) {
        if ([scrollView isKindOfClass:[UITableView class]] || [scrollView isKindOfClass:[UICollectionView class]]) {
            //滑到最顶部
        }
    }
}
@end
