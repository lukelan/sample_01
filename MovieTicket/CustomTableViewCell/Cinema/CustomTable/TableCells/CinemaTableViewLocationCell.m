//
//  CinemaTableViewLocationCell.m
//  123Phim
//
//  Created by Tai Truong on 12/8/13.
//  Copyright (c) 2013 Phuong. Nguyen Minh. All rights reserved.
//

#import "CinemaTableViewLocationCell.h"

@implementation CinemaTableViewLocationCell

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
        // image
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 49, 49)];
        [_imageView setImage:[UIImage imageNamed:@"location.png"]];
        [self.contentView addSubview:_imageView];
        
        // title label
        _titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(57, 2, 228, 47)];
        _titleLbl.backgroundColor = [UIColor clearColor];
        _titleLbl.font = [UIFont systemFontOfSize:17.0f];
        [self.contentView addSubview:_titleLbl];
    }
    return self;
}

#pragma mark - Public Methods

+(CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object
{
    return 50.0f;
}

-(void)setObject:(id)object
{
    [super setObject:object];
    
    CinemaTableViewLocationItem *item = object;
    _titleLbl.text = item.title;
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
}

@end
