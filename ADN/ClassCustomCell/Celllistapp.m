//
//  Celllistapp.m
//  ADN
//
//  Created by Dao Pham Hoang Duy on 11/19/13.
//  Copyright (c) 2013 Le Ngoc Duy. All rights reserved.
//

#import "Celllistapp.h"

#define PADDING 3

@implementation Celllistapp
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.rateView = [[DYRateView alloc] initWithFrame:CGRectZero];
        self.rateView.alignment = RateViewAlignmentLeft;
        self.rateView.starSize = 9.0f;
        [self.contentView addSubview:self.rateView];
        heighOneRowTitle = 0;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//customCell listapp
-(void)customCell: (NSString *) number 
{
    if (heighOneRowTitle == 0) {
        heighOneRowTitle = [@"ABC" sizeWithFont:self.title.font].height;
    }
    //NSLog("%@",Apprecord.title);
     //Add label Number to list app
    
    // Get old Title font size
    CGSize oldTitleSize = [self.title.text sizeWithFont:self.title.font constrainedToSize:CGSizeMake(self.title.frame.size.width, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
    
//    NSLog(@"-OLD----%f--%f",oldTitleSize.width,oldTitleSize.height);

    int numberOldTitleLine = self.rateView.frame.size.width == 0?0:1;
    if (oldTitleSize.height > heighOneRowTitle) {
        numberOldTitleLine = 2;
    }
    
    //Add label title
    [self.title setText:_appRecord.name];
    
    // Get Title size
    CGSize titleSize = [self.title.text sizeWithFont:self.title.font constrainedToSize:CGSizeMake(self.title.frame.size.width, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
    
//    NSLog(@"--New---%f--%f",titleSize.width,titleSize.height);
    
    // Adjust Title, Category, Stars based on Title number of line
    int numberTitleLine = 1;
    if (titleSize.height > heighOneRowTitle) {
        numberTitleLine = 2;
    }
    
    if (numberTitleLine == numberOldTitleLine) {
        // Do nothing due to reused cell had the same size with old cell
    } else {
        if (numberTitleLine == 1) {
            self.title.frame = CGRectMake(self.title.frame.origin.x, 18, self.title.frame.size.width, titleSize.height);
        } else {
            self.title.frame = CGRectMake(self.title.frame.origin.x, 9, self.title.frame.size.width, 2*17.0f);
        }
        self.categoryApp.frame = CGRectMake(self.categoryApp.frame.origin.x, self.title.frame.origin.y + self.title.frame.size.height + PADDING, self.categoryApp.frame.size.width, 15);
        
    }
    if (numberTitleLine != numberOldTitleLine || self.rateView.frame.size.width == 0)
    {
        self.downloadNumLbl.frame = CGRectMake(self.downloadNumLbl.frame.origin.x, self.categoryApp.frame.origin.y + self.categoryApp.frame.size.height, self.downloadNumLbl.frame.size.width, 15);
        self.rateView.frame = CGRectMake(self.categoryApp.frame.origin.x, self.categoryApp.frame.origin.y + self.categoryApp.frame.size.height + PADDING, 14.0f*7, 14.0f);
    }
    
    [self.number setText:number];
    
    //Add label category to list app
    NSString *categoryName = _appRecord.cat_n;
    if (!categoryName) categoryName = _appRecord.cat_name;
    [self.categoryApp setText:categoryName];
    //Add Button Price to list app
   // [self.Rate setText:_apprecord.rate];
     [self.btPrice setTitle:@"Free" forState:UIControlStateNormal];
    //Add image to list app to list app
    [self.imageViewListApp setImageWithURL:[NSURL URLWithString:_appRecord.icon] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    self.rateView.rate = [_appRecord.rate intValue];
    self.downloadNumLbl.text = [NSString stringWithFormat:@"(%@)", _appRecord.downloads];
    if (_btPrice.layer.borderColor != _btPrice.titleLabel.textColor.CGColor)
    {
        _btPrice.layer.borderWidth=1;
        _btPrice.layer.borderColor = _btPrice.titleLabel.textColor.CGColor;
        _btPrice.layer.cornerRadius = 4;
        _imageViewListApp.clipsToBounds = YES;
        _imageViewListApp.layer.cornerRadius = 15;
    }
}

- (IBAction)handleUpdateVersion:(id)sender
{
    // get indexpath button
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:_appRecord.official_link]];
}
@end
