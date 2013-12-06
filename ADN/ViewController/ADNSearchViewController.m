//
//  SearchViewController.m
//  ADN
//
//  Created by Dao Pham Hoang Duy on 11/26/13.
//  Copyright (c) 2013 Le Ngoc Duy. All rights reserved.
//

#import "ADNSearchViewController.h"
#import "Celllistapp.h"
#import "ADNDetailViewController.h"
#import "ADN_APIManager.h"
#import "ADN_DefineConstant.h"
#import "UIViewController+CustomNavigation.h"

#define  MINIMUM_SEARCH_CHARS 3
#define  MINIMUM_MILISECONDS  400.0


@interface ADNSearchViewController ()<UISearchBarDelegate, RKManagerDelegate>
@property (strong, nonatomic) NSMutableArray *searchResults;
@property (nonatomic, assign) BOOL isFilterSearch;
@property (nonatomic, assign) BOOL isSearchFound;
@end

@implementation ADNSearchViewController {
    double      startTime;
    NSDate      *date;
    NSString    *searchString;
    NSTimer     *timerMain;
}

-(void)dealloc {
    date = nil;
    searchString = nil;
    timerMain = nil;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
	  
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    date = [NSDate date];
    startTime = [date timeIntervalSinceNow] * -1000.0;
    searchString = @"";
    
    [[self tableViewSearch]setDelegate:self];
    [[self tableViewSearch]setDataSource:self];
    self.navigationController.navigationBar.topItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"ADN" style:UIBarButtonItemStylePlain target:nil action:nil];
   [self.searchBar becomeFirstResponder];
    _isFilterSearch = NO;
    [self setCustomBarLeftWithImage:[UIImage imageNamed:@"ios-back.png"] selector:nil context_id:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)filterContentForSearchText: (NSString *) searchText
{
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"SELF.name CONTAINS[cd] %@", searchText];
    NSArray *temArr = [self.dataArray filteredArrayUsingPredicate:resultPredicate];
    _isSearchFound = NO;
    if (temArr.count != 0) {
        if(self.searchResults)
        {
            [_searchResults removeAllObjects];
        }
        _searchResults = [NSMutableArray arrayWithArray:temArr];
        _isSearchFound = YES;
    }
    _isFilterSearch = YES;
}

- (void)searchAction
{
    [self filterContentForSearchText:searchString];[self.searchBar becomeFirstResponder];
    if (!_isSearchFound) {
        [[ADN_APIManager sharedAPIManager] RK_RequestApiGetListAppBySearchKey:searchString withContext:self];
    } else {
        [self.tableViewSearch reloadData];
    }
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_isFilterSearch) {
        return [_searchResults count];
    }
    return [_dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier  = @"Cellsearch";
   Celllistapp *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell)
    {
        cell = (Celllistapp *) [[[NSBundle mainBundle] loadNibNamed:@"CellListApp" owner:self options:nil] lastObject];
    };
    NSString *indexrow = [NSString stringWithFormat:@"%d",(int)indexPath.row + 1];
    if (cell)
    {
        if (_isFilterSearch)
        {
            [cell setAppRecord:[self.searchResults objectAtIndex:indexPath.row]];
        }
        else
        {
            [cell setAppRecord:[self.dataArray objectAtIndex:indexPath.row]];
        }
        [cell customCell:indexrow];
        [cell setAccessoryType:UITableViewCellAccessoryNone];
        [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
    }
    return cell;
}

#pragma mark - TableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 84;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_searchBar resignFirstResponder];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ADNDetailViewController *detail = [[ADNDetailViewController alloc] initWithNibName:[[ADNDetailViewController class] description] bundle:nil];
    Apprecord *temp = [self.dataArray objectAtIndex:indexPath.row];
    
    if (_isFilterSearch)
    {
        temp = [self.searchResults objectAtIndex:indexPath.row];
    }
    [detail setDetailAppRecord:temp];
    [self.navigationController pushViewController:detail animated:YES];
}

#pragma mark -
#pragma mark UISearchBarDelegate method
#pragma mark -
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    searchString = searchText;
    
    // Trongvm - 11/27: Only Call API search as rules
    //  Rule 1 - Only search with at least 3 characters
    //  Rule 2 - Only search if user stop typing @ while 400 milisecond
    
    
    // Rule 1
    if (searchText.length < MINIMUM_SEARCH_CHARS) {
        return;
    }

    // Rule 2
    double endtime = [date timeIntervalSinceNow] * -1000.0;
    NSLog(@"starttime %f endtime %f",startTime,endtime);
    double diff = endtime - startTime;
    NSLog(@"Diff - %f", diff);
    startTime = endtime;
    [timerMain invalidate];
    if (diff <= MINIMUM_MILISECONDS) {
        timerMain = [NSTimer scheduledTimerWithTimeInterval:MINIMUM_MILISECONDS/1000.0 target:self selector:@selector(searchAction) userInfo:nil repeats:NO];
        return;
    }
    
    [self searchAction];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar;
{
    [self searchAction];
    [_searchBar resignFirstResponder];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [_searchBar resignFirstResponder];
}

#pragma mark -
#pragma mark RKManageDelegate method
- (void)processResultResponseArray:(NSArray *)array requestId:(int)request_id
{
    if (request_id == ID_REQUEST_GET_LIST_APP_BY_SEARCH_KEY)
    {
        _searchResults = [NSMutableArray arrayWithArray:array];
    }
    [_tableViewSearch reloadData];
}

-(void)processFailedRequestId:(int)request_id
{
    if (request_id == ID_REQUEST_GET_LIST_APP_BY_SEARCH_KEY)
    {
        if(self.searchResults)
        {
           [_searchResults removeAllObjects];
        }
    }
    [_tableViewSearch reloadData];
}
@end
