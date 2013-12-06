//
//  UIViewController+TabBarAnimation.h
//  ADN
//
//  Created by Le Ngoc Duy on 11/28/13.
//  Copyright (c) 2013 Le Ngoc Duy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (TabBarAnimation)

- (void)performShowTabBar;
- (void)performHideTabBar;

- (void)performHideNavigatorBar;
- (void)performShowNavigatorBar;

@end
