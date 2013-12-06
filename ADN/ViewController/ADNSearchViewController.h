//
//  SearchViewController.h
//  ADN
//
//  Created by Dao Pham Hoang Duy on 11/26/13.
//  Copyright (c) 2013 Le Ngoc Duy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface ADNSearchViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSArray *dataArray;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tableViewSearch;

@end
