//
//  CinemaTableViewPlaceCell.m
//  123Phim
//
//  Created by Tai Truong on 12/8/13.
//  Copyright (c) 2013 Phuong. Nguyen Minh. All rights reserved.
//

#import "CinemaTableViewPlaceCell.h"

#define kCinemaTableViewPlaceCell_ContentHeight 50.0f
#define kCinemaTableViewPlaceCell_FooterHeight 32.0f

@implementation CinemaTableViewPlaceCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //
        // content
        //
        // status image
        _statusImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 49, 49)];
        [self.contentView addSubview:_statusImgView];
        
        // title
        _titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(54, 5 , 165, 21)];
        _titleLbl.backgroundColor  = [UIColor clearColor];
        _titleLbl.textColor = [UIColor blackColor];
        _titleLbl.font = [UIFont fontWithName:@"Helvetica-Bold" size:12.0f];
        [self.contentView addSubview:_titleLbl];
        
        // address
        _addressLbl = [[UILabel alloc] initWithFrame:CGRectMake(54, 23 , 200, 21)];
        _addressLbl.textColor = [UIColor grayColor];
        _addressLbl.font = [UIFont systemFontOfSize:17.0f];
        [self.contentView addSubview:_addressLbl];
        
        // discount
        _discountImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 7, 40, 40)];
        [_discountImgView setImage:[UIImage imageNamed:@"film_sale_off_small.png"]];
        [self.contentView addSubview:_discountImgView];
        
        _discountLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 10 , 40, 20)];
        _discountLbl.textColor = [UIColor whiteColor];
        _discountLbl.font = [UIFont fontWithName:@"Helvetica-Bold" size:14.0f];
        [self.contentView addSubview:_discountLbl];
        
        //
        // footer
        //
        // image
        _footerImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, MARGIN_EDGE_TABLE_GROUP/2, 296, 22)];
        _footerImage.image = [UIImage imageNamed:@"theater_distance_time.png"];
        [self.contentView addSubview:_footerImage];
        
        // distance
        _distanceLbl = [[UILabel alloc] initWithFrame:CGRectMake(37, kCinemaTableViewPlaceCell_ContentHeight + 2 , 80, 30)];
        _distanceLbl.backgroundColor  = [UIColor clearColor];
        _distanceLbl.textColor = [UIColor grayColor];
        _distanceLbl.font = [UIFont getFontBoldSize10];
        [self.contentView addSubview:_distanceLbl];
        
        // time by bike
        _estimateTimeBikeLbl = [[UILabel alloc] initWithFrame:CGRectMake(_distanceLbl.frame.origin.x + _distanceLbl.frame.size.width + 13, kCinemaTableViewPlaceCell_ContentHeight + 2, 70, 30)];
        _estimateTimeBikeLbl.backgroundColor  = [UIColor clearColor];
        _estimateTimeBikeLbl.textColor = _distanceLbl.textColor;
        _estimateTimeBikeLbl.font = _distanceLbl.font;
        [self.contentView addSubview:_estimateTimeBikeLbl];
        
        // time by car
        _estimateTimeCarLbl = [[UILabel alloc] initWithFrame:CGRectMake(_estimateTimeBikeLbl.frame.origin.x + _estimateTimeBikeLbl.frame.size.width + 29, kCinemaTableViewPlaceCell_ContentHeight + 2, 70, 30)];
        _estimateTimeCarLbl.backgroundColor  = [UIColor clearColor];
        _estimateTimeCarLbl.textColor = _distanceLbl.textColor;
        _estimateTimeCarLbl.font = _distanceLbl.font;
        [self.contentView addSubview:_estimateTimeCarLbl];
        
        // you are here section
        _youAreHereImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, kCinemaTableViewPlaceCell_ContentHeight + 2, 56, 42)];
        [self.contentView addSubview:_youAreHereImage];
        
        _youAreHereLbl = [[UILabel alloc] initWithFrame:CGRectMake(37, kCinemaTableViewPlaceCell_ContentHeight + 2 , 250, 30)];
        _youAreHereLbl.backgroundColor  = [UIColor clearColor];
        _youAreHereLbl.textColor = [UIColor grayColor];
        _youAreHereLbl.font = [UIFont getFontBoldSize10];
        _youAreHereLbl.text = @"Bạn đang ở tại rạp này";
        [self.contentView addSubview:_youAreHereLbl];
        
        _youAreHereLbl.hidden = _youAreHereImage.hidden = YES;
    }
    return self;
}

#pragma mark - Public Methods

+(CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object
{
    return kCinemaTableViewPlaceCell_ContentHeight + kCinemaTableViewPlaceCell_FooterHeight;
}

-(void)setObject:(id)object
{
    [super setObject:object];
    
    CinemaTableViewPlaceItem *item = object;
    self.statusImgView.image = item.isOnline ? [UIImage imageNamed:@"online"] : [UIImage imageNamed:@"online_disable"];
    self.discountLbl.text = item.discount;
    self.titleLbl.text = item.title;
    self.addressLbl.text = item.address;
    _youAreHereImage.hidden = _youAreHereLbl.hidden = !item.youAreHere;
    _footerImage.hidden = self.distanceLbl.hidden = self.estimateTimeBikeLbl.hidden = self.estimateTimeCarLbl.hidden = item.youAreHere;
    if (!item.youAreHere) {
        self.distanceLbl.text = item.distance;
        self.estimateTimeBikeLbl.text = item.estimateTimeBike;
        self.estimateTimeCarLbl.text = item.estimateTimeCar;
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
}

@end
