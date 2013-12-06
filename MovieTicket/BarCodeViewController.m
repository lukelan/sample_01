//
//  BarCodeViewController.m
//  123Phim
//
//  Created by phuonnm on 6/14/13.
//  Copyright (c) 2013 Phuong. Nguyen Minh. All rights reserved.
//

#import "BarCodeViewController.h"
#import "BarCodeGenerator.h"
#import "AppDelegate.h"
#import "DefineString.h"

@interface BarCodeViewController ()

@end

@implementation BarCodeViewController
@synthesize encodeString = _encodeString;

-(void) dealloc
{
    _encodeString = nil;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.tabBarDisplayType = YES;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Duydph - 04/12/2013 - Add Remarketing Code
    [GoogleConversionPing pingRemarketingWithConversionId:@"983463027" label:@"jLppCIXKgAgQ8-j51AM" screenName:viewName customParameters:nil];
    
    self.view.backgroundColor = [UIFont colorBackGroundApp];
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [app setCustomBackButtonForNavigationItem:self.navigationItem];
    [app setTitleLabelForNavigationController:self withTitle:TICKET_BAR_CODE_VIEW_TITLE];
    CGRect f = self.view.frame;
    NSInteger width = 240;
    NSInteger heigh = 120;
    
    f.origin.y = 0;
    self.view.frame = f;
    CGFloat total = width + heigh;
    CGFloat seperator = (f.size.height - NAVIGATION_BAR_HEIGHT - total ) / 3;
    if (!_encodeString || _encodeString.length == 0) {
        return;
    }
    BarCodeGenerator *encoder = [[BarCodeGenerator alloc] init];
    [encoder setupOneDimBarcode:_encodeString type:CODE_128];
    UIImage *imageBarCode = encoder.oneDimBarcode;
    [encoder setupQRCode:_encodeString];
    UIImage *imageQRCode = encoder.qRBarcode;
    UIImageView *imageViewQR = [[UIImageView alloc] initWithImage:imageQRCode];
    UIImageView *imageViewBar = [[UIImageView alloc] initWithImage:imageBarCode];
//    qr
    f = imageViewQR.frame;
    f.origin.x = (self.view.frame .size.width - width) / 2;
    f.origin.y = seperator;
    f.size.width = width;
    f.size.height = width;
    imageViewQR.frame = f;
//    bar
    f = imageViewBar.frame;
    f.origin.x = (self.view.frame .size.width - width) / 2;
    f.origin.y = width + (seperator * 2);
    f.size.width = width;
    f.size.height = heigh;
    imageViewBar.frame = f;
    
    imageViewQR.layer.borderColor = [[UIColor darkGrayColor] CGColor];
    imageViewQR.backgroundColor = [UIColor whiteColor];
    imageViewBar.layer.borderColor = [[UIColor darkGrayColor] CGColor];
    imageViewBar.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:imageViewQR];
    [self.view addSubview:imageViewBar];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
