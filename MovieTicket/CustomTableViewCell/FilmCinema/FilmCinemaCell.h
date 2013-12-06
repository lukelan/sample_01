//
//  FilmCinemaCell.h
//  123Phim
//
//  Created by Le Ngoc Duy on 8/20/13.
//  Copyright (c) 2013 Phuong. Nguyen Minh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "DefineConstant.h"
@interface FilmCinemaCell : UITableViewCell
{
    __weak id<CinemaSessionDelegate> _sessionDelegate;
    int curIndexSelect;
}
@property (nonatomic, weak) id<CinemaSessionDelegate> sessionDelegate;
@property (nonatomic, weak) IBOutlet UIImageView* ivOnline;
@property (nonatomic, weak) IBOutlet UIImageView* ivOffline;
@property (nonatomic, weak) IBOutlet UILabel* cinemaName;
@property (nonatomic, weak) IBOutlet UILabel* cinemaAddress;
@property (strong, nonatomic) IBOutlet UIView *viewLayout;
@property (nonatomic, weak) IBOutlet UILabel* distanceTo;
@property (weak, nonatomic) IBOutlet UILabel *lblType;
@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicatorLoading;
@property (strong, nonatomic) IBOutlet UILabel *lbDiscount;
@property (strong, nonatomic) IBOutlet UIImageView *imageDiscount;
@property (strong, nonatomic) IBOutlet UIView *viewDiscount;
- (void) configLayout;
//define method
-(void)loadDataWithOnline: (BOOL)isOnline cinemaName: (NSString*)_cinmeName film2D3D:(int)film2D3D cinemaAddress:(NSString*)_cinameAddress distance:(CGFloat)_distance withMargin:(int)margin_film_left isVNeseVoice:(BOOL)is_VNese_voice withHeight:(CGFloat)heighCell;
- (void) layoutCellSession: (NSMutableArray *)arraySessions currentRow:(int)curSelect;
@end
