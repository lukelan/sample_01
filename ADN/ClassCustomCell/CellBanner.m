//
//  CellBanner.m
//  ADN
//
//  Created by Le Ngoc Duy on 11/21/13.
//  Copyright (c) 2013 Le Ngoc Duy. All rights reserved.
//
#import "CellBanner.h"
#import "SDImageView.h"

@interface CellBanner ()<UIScrollViewDelegate>

@end

@implementation CellBanner
@synthesize bannerList;
@synthesize timeInterval = _timeInterval;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setDataSourceScrollView:(NSMutableArray *)array withKey:(NSString *)keyName
{
//    NSLog(@"-----self.myScrollView.subviews.count = %d",self.myScrollView.subviews.count);
    if (self.myScrollView.subviews.count > 0) {
        return;
    }
    CGRect frame = self.myScrollView.frame;
    for (int i = 0; i < array.count; i++)
    {
        NSDictionary *dic = [array objectAtIndex:i];
        NSString *url = (NSString *)[dic objectForKey:keyName];
        SDImageView *imgView = [[SDImageView alloc] initWithFrame:CGRectMake(frame.origin.x + i*frame.size.width, frame.origin.y, frame.size.width, frame.size.height)];
        [self.myScrollView addSubview:imgView];
        [imgView setImageWithURL:[NSURL URLWithString:url]];
    }
    self.pageControl.numberOfPages = array.count;
    self.pageControl.currentPage = 0;
    self.myScrollView.pagingEnabled = YES;
    self.myScrollView.contentSize = CGSizeMake(frame.size.width * array.count, 0);//disable scroll vertical
    [self.myScrollView setDelegate:self];
}

-(void)setTimeInterval:(int)timeInterval
{
    if (timeInterval == 0) {
        return;
    }
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    _timeInterval = timeInterval;
    [self performSelector:@selector(executeChangeBanner) withObject:Nil afterDelay:_timeInterval];
}

-(void)executeChangeBanner
{
    CGRect frame = self.myScrollView.frame;
    CGPoint contentOffset = self.myScrollView.contentOffset;
    CGFloat xMax = frame.size.width * (self.myScrollView.subviews.count - 1);
    //check next coordinate x to move
    if (contentOffset.x == xMax) {
        contentOffset.x = 0;
    }  else {
        contentOffset.x += frame.size.width;
    }
    int currentPage = contentOffset.x/frame.size.width;
    self.pageControl.currentPage = currentPage;
    [UIView animateWithDuration:0.5 animations:^{
        [self.myScrollView setContentOffset:contentOffset];
    } completion:^(BOOL finished) {
        [self performSelector:@selector(executeChangeBanner) withObject:Nil afterDelay:_timeInterval];
    }];
}

-(void)dealloc
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
}

- (void)gotoPage:(BOOL)animated
{
    NSInteger page = self.pageControl.currentPage;
    
    CGRect frame = self.myScrollView.frame;
    CGPoint contentOffset = self.myScrollView.contentOffset;
    //check next coordinate x to move
    CGFloat xNext = frame.size.width * page;
    if (contentOffset.x == xNext) {
        return;
    }
    contentOffset.x = xNext;
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [UIView animateWithDuration:0.5 animations:^{
        [self.myScrollView setContentOffset:contentOffset];
    }completion:^(BOOL finished) {
        if (_timeInterval == 0) {
            return;
        }
        [self performSelector:@selector(executeChangeBanner) withObject:Nil afterDelay:_timeInterval];
    }];
}

- (IBAction)changePage:(id)sender
{
    [self gotoPage:YES];    // YES = animate
}

#pragma mark-
#pragma mark ScrollDelegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGRect frame = self.myScrollView.frame;
    CGPoint contentOffset = self.myScrollView.contentOffset;
    int currentPage = contentOffset.x/frame.size.width;
    if (self.pageControl.currentPage == currentPage) {
        return;
    }
    self.pageControl.currentPage = currentPage;

    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    if (_timeInterval == 0) {
        return;
    }
    [self performSelector:@selector(executeChangeBanner) withObject:Nil afterDelay:_timeInterval];
}
@end
