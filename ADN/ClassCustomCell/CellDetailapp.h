//
//  CellDetailapp.h
//  ADN
//
//  Created by Dao Pham Hoang Duy on 11/22/13.
//  Copyright (c) 2013 Le Ngoc Duy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ADNDetailViewController.h"
#import "Apprecord.h"
#import "SDImageView.h"
#import "DYRateView.h"

@interface CellDetailapp : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UIButton *btPrice;
@property (weak, nonatomic) IBOutlet SDImageView *imageViewIcon;
@property (weak, nonatomic) IBOutlet UILabel *downloadNumLbl;
@property (strong, nonatomic) DYRateView *rateView;
@property (strong, nonatomic) Apprecord *appRecordDetail;
@property (weak, nonatomic) IBOutlet UILabel *lbDev;
-(void)getDetailContent;
-(IBAction)handleUpdateVersion:(id)sender;
@end
