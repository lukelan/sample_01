//
//  UIViewController+CustomNavigation.h
//  ADN
//
//  Created by Le Ngoc Duy on 11/28/13.
//  Copyright (c) 2013 Le Ngoc Duy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (CustomNavigation)
-(void)setCustomBarRightWithImage:(UIImage *)imageRight selector:(SEL)function context_id:(id)context_id;
-(void)setCustomBarLeftWithImage:(UIImage *)img selector:(SEL)function context_id:(id)context_id;
-(void)setBackGroundImage:(NSString *) linkImage forNavigationBar:(UINavigationBar *)naviBar;
@end
