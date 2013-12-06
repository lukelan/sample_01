//
//  CellBanner.h
//  ADN
//
//  Created by Le Ngoc Duy on 11/21/13.
//  Copyright (c) 2013 Le Ngoc Duy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CellBanner : UITableViewCell
@property (nonatomic, strong) NSMutableArray *bannerList;
@property (weak, nonatomic) IBOutlet UIScrollView *myScrollView;
@property (nonatomic, assign) int timeInterval;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
- (IBAction)changePage:(id)sender;

-(void)setDataSourceScrollView:(NSMutableArray *)array withKey:(NSString *)keyName;
@end
