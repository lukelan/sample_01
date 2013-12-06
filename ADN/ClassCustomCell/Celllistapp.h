//
//  Celllistapp.h
//  ADN
//
//  Created by Dao Pham Hoang Duy on 11/19/13.
//  Copyright (c) 2013 Le Ngoc Duy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DYRateView.h"
#import "Apprecord.h"
#import "SDImageView.h"
#import "DYRateView.h"

@interface Celllistapp : UITableViewCell
{
    float heighOneRowTitle;
}
@property (weak, nonatomic) IBOutlet SDImageView *imageViewListApp;
@property (weak, nonatomic) IBOutlet UIButton *btPrice;
@property (weak, nonatomic) IBOutlet UILabel *number;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *categoryApp;
@property (strong, nonatomic) Apprecord *appRecord;
@property (weak, nonatomic) IBOutlet UILabel *downloadNumLbl;
@property (strong, nonatomic) DYRateView *rateView;

-(void)customCell: (NSString *) number;
- (IBAction)handleUpdateVersion:(id)sender;
@end
