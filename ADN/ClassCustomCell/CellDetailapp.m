//
//  CellDetailapp.m
//  ADN
//
//  Created by Dao Pham Hoang Duy on 11/22/13.
//  Copyright (c) 2013 Le Ngoc Duy. All rights reserved.
//

#import "CellDetailapp.h"

@implementation CellDetailapp

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.rateView = [[DYRateView alloc] initWithFrame:CGRectMake(111, 80, 10.0f*7, 10.0f)];
        self.rateView.alignment = RateViewAlignmentLeft;
        self.rateView.starSize = 9.0f;
        [self.contentView addSubview:self.rateView];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)getDetailContent
{
    self.lbDev.text=_appRecordDetail.dev_n;
    self.lbTitle.text =_appRecordDetail.name;
    [self.btPrice setTitle:@"Free" forState:UIControlStateNormal];
    _btPrice.layer.borderWidth=1;
    _btPrice.layer.borderColor =  [(_btPrice.titleLabel.textColor) CGColor];
    
    _btPrice.layer.cornerRadius = 4;
    //Add image to list app to list app
    [self.imageViewIcon setImageWithURL:[NSURL URLWithString:_appRecordDetail.icon]];
    _imageViewIcon.clipsToBounds = YES;
    _imageViewIcon.layer.cornerRadius = 15;
    self.rateView.rate = [_appRecordDetail.rate intValue];
    self.downloadNumLbl.text = [NSString stringWithFormat:@"(%@)", _appRecordDetail.downloads];
}
-(void)prepareForReuse
{
    [super prepareForReuse];
    UIImage *placeholder = [UIImage imageNamed:@"placeholder.png"];
    _imageViewIcon.clipsToBounds = YES;
    _imageViewIcon.layer.cornerRadius = 15;
    [_imageViewIcon setImage:placeholder];
}

-(IBAction)handleUpdateVersion:(id)sender
{
    // get indexpath button
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:_appRecordDetail.official_link]];
}
@end
