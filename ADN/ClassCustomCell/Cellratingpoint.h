//
//  Cellratingpoint.h
//  ADN
//
//  Created by Dao Pham Hoang Duy on 11/22/13.
//  Copyright (c) 2013 Le Ngoc Duy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DYRateView.h"
#import "ADNDetailViewController.h"
@interface Cellratingpoint : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *uiviewrating;
@property (weak, nonatomic) IBOutlet UILabel *lbRatePoint;
@property (weak, nonatomic) IBOutlet UILabel *lbCellRate3;
@property (weak, nonatomic) IBOutlet UILabel *lbCellRate5;
@property (weak, nonatomic) IBOutlet UILabel *lbCellRate4;
@property (weak, nonatomic) IBOutlet UILabel *lbCellRate1;
@property (weak, nonatomic) IBOutlet UILabel *lbCellRate2;
@property (weak, nonatomic) IBOutlet UILabel *lbSo1;
@property (weak, nonatomic) IBOutlet UILabel *lbSo2;
@property (weak, nonatomic) IBOutlet UILabel *lbSo3;
@property (weak, nonatomic) IBOutlet UILabel *lbSo4;
@property (weak, nonatomic) IBOutlet UILabel *lbSo5;
@property (weak, nonatomic) IBOutlet UILabel *lbTotal;
-(void)getRatePoint :(NSString *)point : (NSArray *)array;
@end
