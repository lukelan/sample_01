//
//  ADNDetailViewController.h
//  ADN
//
//  Created by Dao Pham Hoang Duy on 11/22/13.
//  Copyright (c) 2013 Le Ngoc Duy. All rights reserved.
//
 
#import <UIKit/UIKit.h>
#import "CellDetailapp.h"
#import "CellBanner.h"
#import <QuartzCore/QuartzCore.h>
#import "CellDescriptionappdetail.h"
#import "Cellratingpoint.h"
#import "CellDescriptionappdetail.h"
#import "Apprecord.h"

@interface ADNDetailViewController : UIViewController<UITableViewDelegate, UITableViewDataSource,UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableViewDetail;
@property (strong, nonatomic) Apprecord *detailAppRecord;
@property (strong, nonatomic) NSString *titleNav;
@end
