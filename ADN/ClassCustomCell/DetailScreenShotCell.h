//
//  DetailScreenShotCell.h
//  ADN
//
//  Created by Tai Truong on 11/24/13.
//  Copyright (c) 2013 Le Ngoc Duy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailScreenShotCell;

@protocol DetailScreenShotCellProtocol <NSObject>

-(void)screenShotCell:(DetailScreenShotCell*)cell didScroll:(UIScrollView *)scrollView;

@end

@interface DetailScreenShotCell : UITableViewCell <UIScrollViewDelegate>

@property (weak, nonatomic) id<DetailScreenShotCellProtocol> delegate;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *infoLbl;
@property (nonatomic, weak) id object;

+ (CGFloat)tableView:(UITableView*)tableView rowHeightForObject:(id)object;
@end
