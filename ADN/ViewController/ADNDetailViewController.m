//
//  ADNDetailViewController.m
//  ADN
//
//  Created by Dao Pham Hoang Duy on 11/22/13.
//  Copyright (c) 2013 Le Ngoc Duy. All rights reserved.
//

#import "ADNDetailViewController.h"
#import "DetailScreenShotCell.h"
#import "ADN_APIManager.h"
#import "UIViewController+CustomNavigation.h"

@interface ADNDetailViewController()<RKManagerDelegate, DetailScreenShotCellProtocol>
{

}

@end

@implementation ADNDetailViewController
@synthesize titleNav;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableViewDetail.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 10)];
    
    self.navigationController.navigationBar.topItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:titleNav style:UIBarButtonItemStylePlain target:nil action:nil];
    [[self tableViewDetail]setDelegate:self];
    [[self tableViewDetail]setDataSource:self];
    if (![_detailAppRecord.des isKindOfClass:[NSString class]] || _detailAppRecord.des.length == 0) {
        [[ADN_APIManager sharedAPIManager] RK_RequestApiGetAppDetail:self.detailAppRecord.package appID:self.detailAppRecord.app_id withContext:self];
    }
    [self setCustomBarLeftWithImage:[UIImage imageNamed:@"ios-back.png"] selector:nil context_id:nil];
}

-(NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section
{
    //return 0;
    int numRow = 4;
    if ([_detailAppRecord.rate_c integerValue] == 0) {
        numRow--;
    }
    if (![_detailAppRecord.des isKindOfClass:[NSString class]] || _detailAppRecord.des.length < 30) {
        numRow--;
    }
    return numRow;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row==0)
    {
    //        Storyboard
       NSString *CellIdentifier   = CellIdentifier = @"Celldetail";
        CellDetailapp *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if(!cell)
        {
           cell = (CellDetailapp *) [[[NSBundle mainBundle] loadNibNamed:@"CellDetailApp" owner:self options:nil] lastObject];
        }
        
        if (cell)
        {
            [cell setAppRecordDetail:_detailAppRecord];
            [cell getDetailContent];
        }
        return cell;        
    }
    else if (indexPath.row==1) // cell show app's screenshots
    {
        NSString *CellIdentifier   = [[DetailScreenShotCell class] description];
        DetailScreenShotCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if(!cell)
        {
            cell = (DetailScreenShotCell *) [[[NSBundle mainBundle] loadNibNamed:@"DetailScreenShotCell" owner:self options:nil] lastObject];
        };
        cell.delegate = self;
        [cell setObject:_detailAppRecord];
        return cell;
    }
    else if (indexPath.row==2)
    {
        NSString *CellIdentifier =@"CellDescriptionappdetail";
        CellDescriptionappdetail *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if(!cell)
        {
            cell = (CellDescriptionappdetail *) [[[NSBundle mainBundle] loadNibNamed:@"CellDescriptionAppDetail" owner:self options:nil] lastObject];
            [cell setDescription:_detailAppRecord.des];
            cell.delegate=self;
        };
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
    }
    else if (indexPath.row==3)
    {
        //Stroyboard
        NSString *CellIdentifier  =  @"Cellratingpoint";
        Cellratingpoint *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if(!cell)
        {
            cell = (Cellratingpoint *) [[[NSBundle mainBundle] loadNibNamed:@"CellRatingPoint" owner:self options:nil] lastObject];
        }
        if (cell)
        {
            [cell getRatePoint:_detailAppRecord.rate :_detailAppRecord.ratings];
        }
        return cell;
    }
    return nil;
}

#pragma mark
#pragma TableViewDelegate
#pragma mark TableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 120;
    }
    else if (indexPath.row == 1)
    {
        return [DetailScreenShotCell tableView:tableView rowHeightForObject:_detailAppRecord];
    }
    else if (indexPath.row == 2)
    {
        return [CellDescriptionappdetail getHeightOfCell];
    }
    return 157;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   if (indexPath.row == 2) {
       // A case was selected, so push into the CellDescriptionappdetail
       [(CellDescriptionappdetail *)[tableView cellForRowAtIndexPath:indexPath] processTypeShowDescription];
    }
}

- (void)statusChanged:(enumDescriptionCellStatus)status
{
    [_tableViewDetail reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:2 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
}

-(NSString *)convertHTML:(NSString *)html
{
    NSScanner *myScanner;
    NSString *text = nil;
    myScanner = [NSScanner scannerWithString:html];
    
    while ([myScanner isAtEnd] == NO) {
        
        [myScanner scanUpToString:@"<" intoString:NULL] ;
        
        [myScanner scanUpToString:@">" intoString:&text] ;
        
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>", text] withString:@""];
    }
    //
    html = [html stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    return html;
}


#pragma mark - DetailScreenShotCellProtocol
-(void)screenShotCell:(DetailScreenShotCell *)cell didScroll:(UIScrollView *)scrollView
{
    // move screenshot cell to center of screen
    CGFloat cellHeight = [self heightToScrollTable:_tableViewDetail inRow:1];
    [UIView animateWithDuration:0.3 animations:^{
        self.tableViewDetail.contentOffset = CGPointMake(0, cellHeight);
    }];
}

-(CGFloat)heightToScrollTable:(UITableView *)myTable inRow:(int)section
{
    if (myTable == nil || section == 0) {
        return 0;
    }
    
    NSInteger height = 0;
    for (int i = 0; i < section; i++) {
        height += [self tableView:myTable heightForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
    }
    return height;
}

#pragma mark -
#pragma mark RKManageDelegate callback method
-(void)processResultResponseDictionaryMapping:(DictionaryMapping *)dictionary requestId:(int)request_id
{
    if (request_id == ID_REQUEST_GET_APP_DETAIL) {
        if (dictionary.curDictionary) {
            [self.detailAppRecord setTrailer:[dictionary.curDictionary objectForKey:@"trailer"]];
            [self.detailAppRecord setDes:[dictionary.curDictionary objectForKey:@"des"]];
            [self.detailAppRecord setImages:[dictionary.curDictionary objectForKey:@"images"]];
            [self.detailAppRecord setRatings:[dictionary.curDictionary objectForKey:@"ratings"]];
        }
    }
    [self.tableViewDetail reloadData];
}

@end
