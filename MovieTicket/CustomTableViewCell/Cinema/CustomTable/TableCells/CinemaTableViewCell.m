//
//  CinemaTableViewCell.m
//  123Phim
//
//  Created by Tai Truong on 12/8/13.
//  Copyright (c) 2013 Phuong. Nguyen Minh. All rights reserved.
//

#import "CinemaTableViewCell.h"

@implementation CinemaTableViewCell
@synthesize object = __object;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        // Initialization code
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didSelect)];
        [self addGestureRecognizer:tapGesture];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (CGFloat)tableView:(UITableView*)tableView rowHeightForObject:(id)object {
    return 0;
}

- (id)object {
    return __object;
}

- (void)setObject:(id)object {
    __object = object;
}

-(void)didSelect
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(vkTableViewCell:didSelect:atIndex:)]) {
        [self.delegate vkTableViewCell:self didSelect:self.object atIndex:0];
    }
}

@end
