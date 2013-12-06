//
//  UIViewController+CustomNavigation.m
//  ADN
//
//  Created by Le Ngoc Duy on 11/28/13.
//  Copyright (c) 2013 Le Ngoc Duy. All rights reserved.
//

#import "UIViewController+CustomNavigation.h"

@implementation UIViewController (CustomNavigation)

-(void)setCustomBarRightWithImage:(UIImage *)imageRight selector:(SEL)function context_id:(id)context_id
{
    UIButton *customButtonR = [UIButton buttonWithType:UIButtonTypeCustom];
    CGRect frame = CGRectMake(0, 0, imageRight.size.width, imageRight.size.height);
    customButtonR.frame = frame;
    [customButtonR setBackgroundImage:imageRight forState:UIControlStateNormal];
    if ([context_id respondsToSelector:function]) {
        [customButtonR addTarget:context_id action:function forControlEvents:UIControlEventTouchUpInside];
    }
    UIBarButtonItem *btnRight = [[UIBarButtonItem alloc] initWithCustomView:customButtonR];
    self.navigationItem.rightBarButtonItem = btnRight;
}

-(void)setCustomBarLeftWithImage:(UIImage *)imageLeft selector:(SEL)function context_id:(id)context_id
{
    UIButton *customButtonL = [UIButton buttonWithType:UIButtonTypeCustom];
    CGRect frame = CGRectMake(0, 0, imageLeft.size.width, imageLeft.size.height);
    customButtonL.frame = frame;
    [customButtonL setBackgroundImage:imageLeft forState:UIControlStateNormal];
    if ([context_id respondsToSelector:function]) {
        [customButtonL addTarget:context_id action:function forControlEvents:UIControlEventTouchUpInside];
    } else {
        [customButtonL addTarget:self action:@selector(popViewController) forControlEvents:UIControlEventTouchUpInside];
    }
    UIBarButtonItem *btnleft = [[UIBarButtonItem alloc] initWithCustomView:customButtonL];
    self.navigationItem.leftBarButtonItem = btnleft;
}

-(void)popViewController
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)setBackGroundImage:(NSString *) linkImage forNavigationBar:(UINavigationBar *)naviBar
{
    UIImage *img=[UIImage imageNamed:linkImage];
    if (img != nil) {
        float version=[[[UIDevice currentDevice]systemVersion]floatValue];
        if (version>=5.0) {
            [naviBar setBackgroundImage:img forBarMetrics:UIBarMetricsDefault];
        }else{
            [naviBar insertSubview:[[UIImageView alloc] initWithImage:img] atIndex:0];
        }
        naviBar.layer.shadowOffset=CGSizeMake(0, 2);
        naviBar.layer.shadowRadius=5;
        naviBar.layer.shadowOpacity=0.5;
    }
}
@end
