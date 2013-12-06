//
//  BuyingViewController.m
//  MovieTicket
//
//  Created by Phuong. Nguyen Minh on 12/6/12.
//  Copyright (c) 2012 Phuong. Nguyen Minh. All rights reserved.
//

#import "BuyingViewController.h"
#import "APIManager.h"
#import "AppDelegate.h"

@interface BuyingViewController ()

@end

@implementation BuyingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        viewName = BUYING_VIEW_NAME;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Duydph - 04/12/2013 - Add Remarketing Code
    [GoogleConversionPing pingRemarketingWithConversionId:@"983463027" label:@"jLppCIXKgAgQ8-j51AM" screenName:viewName customParameters:nil];
	// Do any additional setup after loading the view.
//    NSString* previewView = ((AppDelegate*)[[UIApplication sharedApplication] delegate]).currentView;
//    NSString* currentView = viewName;
//    [[APIManager sharedAPIManager] sendLogToSever123PhimRequestURL:currentView comeFrom:previewView withActionID:LOG_ACTION_ID_VIEW currentFilmID:[NSNumber numberWithInt:NO_FILM_ID] currentCinemaID:[NSNumber numberWithInt:NO_CINEMA_ID] returnCodeValue:0 context:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
