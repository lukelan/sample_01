//
//  CellDescriptionappdetail.h
//  ADN
//
//  Created by Dao Pham Hoang Duy on 11/22/13.
//  Copyright (c) 2013 Le Ngoc Duy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ADNDetailViewController.h"

typedef enum
{
    enumDescriptionCellStatus_Short = 0,
    enumDescriptionCellStatus_Full,
    enumDescriptionCellStatus_Num
}enumDescriptionCellStatus;

@protocol MyClassDelegate <NSObject>
// Required means if they want to use the delegate they
// have to implement it.
@required
- (void)statusChanged:(enumDescriptionCellStatus)status;
@end
@interface CellDescriptionappdetail : UITableViewCell <UIWebViewDelegate>
{
   __weak id<MyClassDelegate> delegate;
}
@property (nonatomic, weak) id delegate;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIButton *btnMore;
- (IBAction)btmore:(id)sender;

- (void)setDescription:(NSString *)des;
- (void)processTypeShowDescription;
+ (CGFloat)getHeightOfCell;
@end
