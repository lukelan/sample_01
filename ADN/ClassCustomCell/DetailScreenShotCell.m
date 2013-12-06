//
//  DetailScreenShotCell.m
//  ADN
//
//  Created by Tai Truong on 11/24/13.
//  Copyright (c) 2013 Le Ngoc Duy. All rights reserved.
//

#import "DetailScreenShotCell.h"
#import "SDImageView.h"
#import "Apprecord.h"

#define SCREENSHOT_WIDTH 200
#define SCREENSHOT_HEIGHT 350
#define SCREENSHOT_PADDING 14

@implementation DetailScreenShotCell
{
    CGFloat baseOffset;
}
@synthesize object = __object;

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

#pragma mark - Public Methods

+(CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object
{
    return 400;
}

-(id)object
{
    return __object;
}

-(void)setObject:(id)object
{
    __object = object;

    // remove all current image
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    Apprecord *detailRecord = object;
    // add new screen shot
    NSArray *arrImages = detailRecord.images;
    CGFloat x = SCREENSHOT_PADDING;
    for (NSDictionary *dic in arrImages) {
        NSString *imageURL = dic[@"f"];
        SDImageView *imageView = [[ SDImageView alloc] initWithFrame:CGRectMake(x, 0, SCREENSHOT_WIDTH, SCREENSHOT_HEIGHT)];
        __weak SDImageView *tempImgView = imageView;
        [imageView setImageWithURL:[NSURL URLWithString:imageURL] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
            // rotate image if needed
            if (!error) {
                CGSize imgSize = image.size;
                if (imgSize.width > imgSize.height) {
                    tempImgView.image = [[UIImage alloc] initWithCGImage: image.CGImage
                                                                         scale: 1.0
                                                                   orientation: UIImageOrientationLeft];
                }
            }
        }];
        [self.scrollView addSubview:imageView];
        
        // increase x position
        x += SCREENSHOT_WIDTH + SCREENSHOT_PADDING;
        
    }
    
    if (arrImages) {
        CGSize contentSize = CGSizeMake(arrImages.count * (SCREENSHOT_WIDTH + SCREENSHOT_PADDING) + 14, 0);
        [self.scrollView setContentSize:contentSize];
    }
    
    NSString *downloadStr = [self stringForNumberDownload:detailRecord.downloads];
    NSString *dateStr = [self dateStringForDate:detailRecord.date_add];
    // info
    self.infoLbl.text = [NSString stringWithFormat:@"Lượt tải: %@ | %@ | %@",downloadStr, dateStr, detailRecord.size];
}

#pragma mark - Helper
-(NSString*)stringForNumberDownload:(NSString*)downloadNumberStr
{
    NSInteger numDownload = [downloadNumberStr integerValue];
    NSString *result = @"";
    if (numDownload < 1000) {
        result = downloadNumberStr;
    }
    else {
        NSInteger i = numDownload / 1000;
        NSInteger j = numDownload % 1000;
        result = j == 0? [NSString stringWithFormat:@"%dk", i] : [NSString stringWithFormat:@"%dk+", i];
        
    }
    return result;
}

-(NSString*)dateStringForDate:(NSString*)dateStr
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *date = [formatter dateFromString:dateStr];
    formatter.dateFormat = @"dd/mm/yyyy";
    return [formatter stringFromDate:date];
}

#pragma mark - UIScrollViewDelegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(screenShotCell:didScroll:)]) {
        [self.delegate screenShotCell:self didScroll:scrollView];
    }
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
     baseOffset = scrollView.contentOffset.x;
}
-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    CGFloat maxOffset = scrollView.contentSize.width - scrollView.bounds.size.width;
    CGFloat minOffset = targetContentOffset->x < (SCREENSHOT_WIDTH/2 + 14.0) ? 0 : 7;
    
    CGFloat offsetStep = SCREENSHOT_WIDTH + 14;
    
    if (targetContentOffset->x == 0) {
        return;
    }
    
    CGFloat targetX = MAX(minOffset,MIN(maxOffset, targetContentOffset->x));
    NSInteger numpage = (targetX - minOffset)/offsetStep;
    
    if (velocity.x == 0) {
        
        CGFloat delta = targetX - offsetStep * numpage;
        
        if (ABS(delta) > offsetStep/2) {
            baseOffset = MIN(maxOffset, offsetStep * (numpage + 1) + 7);
        }
        else {
            baseOffset = MAX(minOffset, offsetStep * numpage + 7);
        }
        
    } else {
        if (velocity.x > 0) {
            baseOffset = MIN(maxOffset, offsetStep * (numpage + 1) + 7);
        } else {
            baseOffset = MAX(minOffset, offsetStep * numpage + 7);
        }
    }
    
    targetContentOffset->x = baseOffset;
}

@end
