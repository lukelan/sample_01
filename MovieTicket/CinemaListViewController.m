//
//  CinemaListViewController.m
//  123Phim
//
//  Created by Nhan Mai on 7/3/13.
//  Copyright (c) 2013 Phuong. Nguyen Minh. All rights reserved.
//

#import "CinemaListViewController.h"
#import "Cinema.h"
#import "CinemaFilmViewController.h"
#import "AppDelegate.h"

@interface CinemaListViewController ()

@end

@implementation CinemaListViewController

@synthesize user;

-(void) dealloc
{
    user = nil;
}
- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Duydph - 04/12/2013 - Add Remarketing Code
    [GoogleConversionPing pingRemarketingWithConversionId:@"983463027" label:@"jLppCIXKgAgQ8-j51AM" screenName:viewName customParameters:nil];
	// Do any additional setup after loading the view.
    
    // set navigation
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate setCustomBackButtonForNavigationItem:self.navigationItem];
    [appDelegate setTitleLabelForNavigationController:self withTitle:self.naviTitle];
    
    //get list favorite cinema
//    [[APIManager sharedAPIManager] getListCinemaLikeOfUser:self.user.user_id context: self];
    
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LOG_123PHIM(@"data list: %@", self.dataList.description);
    Cinema* cinema = [self.dataList objectAtIndex:indexPath.row];
    static NSString* cellID = @"cellID";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
        cell.textLabel.font = [UIFont getFontBoldSize13];
        cell.detailTextLabel.font = [UIFont getFontNormalSize13];
    }    
    cell.textLabel.text = cinema.cinema_name;
    cell.detailTextLabel.text = cinema.cinema_address;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
