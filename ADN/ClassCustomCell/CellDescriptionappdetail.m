//
//  CellDescriptionappdetail.m
//  ADN
//
//  Created by Dao Pham Hoang Duy on 11/22/13.
//  Copyright (c) 2013 Le Ngoc Duy. All rights reserved.
//

#import "CellDescriptionappdetail.h"

#define DESCRIPTION_SHORT_HEIGHT 80.0f
#define DEFAULT_HEIGH_CELL_DES 126.0f
#define MARGIN_CELL_DETAIL 8.0f

static float heightForCell;
static enumDescriptionCellStatus statusShowDes;

@implementation CellDescriptionappdetail
@synthesize delegate;

-(void)dealloc
{
    heightForCell = DEFAULT_HEIGH_CELL_DES;
    statusShowDes = enumDescriptionCellStatus_Short;
    [_webView stopLoading];
    [_webView setDelegate:nil];
    [_webView removeFromSuperview];
    _webView = nil;
    _btnMore = nil;
    delegate = nil;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

+ (CGFloat) getHeightOfCell
{
    if (statusShowDes == enumDescriptionCellStatus_Full) {
        return heightForCell;
    }
    return DEFAULT_HEIGH_CELL_DES;
}

- (IBAction)btmore:(id)sender {
    [self processTypeShowDescription];
}

- (void)processTypeShowDescription
{
    if (self.btnMore.hidden) {
        return;
    }
    if (statusShowDes == enumDescriptionCellStatus_Full)
    {
        statusShowDes = enumDescriptionCellStatus_Short;
        heightForCell = DEFAULT_HEIGH_CELL_DES;
    } else {
        statusShowDes = enumDescriptionCellStatus_Full;
        heightForCell = self.webView.scrollView.contentSize.height + self.btnMore.frame.size.height + 2*MARGIN_CELL_DETAIL;
    }
    [delegate statusChanged:statusShowDes];
}

- (void)setDescription:(NSString *)des
{
    heightForCell = DEFAULT_HEIGH_CELL_DES;
    [self loadContentForWebViewWithDesc:des];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGRect r = self.webView.frame;
    CGRect b = self.btnMore.frame;
    if (statusShowDes == enumDescriptionCellStatus_Full) {
        r.size.height = self.webView.scrollView.contentSize.height;
        [self.btnMore setImage:[UIImage imageNamed:@"up.png"] forState:UIControlStateNormal];
    } else {
        r.size.height = DESCRIPTION_SHORT_HEIGHT;
        [self.btnMore setImage:[UIImage imageNamed:@"down.png"] forState:UIControlStateNormal];
    }
    b.origin.y = r.origin.y + r.size.height + MARGIN_CELL_DETAIL/2;
    self.webView.frame = r;
    self.btnMore.frame=b;
}

-(void)loadContentForWebViewWithDesc: (NSString *) desc
{
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSURL *baseURL = [NSURL fileURLWithPath:path];
    NSString *myHTML = [NSString stringWithFormat: @"<html style='padding: 0; margin: 0; border: 0; outline: 0'><header><style>* {font-family: %@ !important; font-weight: normal !important; font-size:13px !important}</style></header><body style='padding: 0px; margin: 0px;  border: 0; outline: 0'><div style='color:#666666; text-align:justify'>%@</div></body></html>",@"Helvetica",desc];
    [_webView loadHTMLString:myHTML baseURL:baseURL];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.webView.scrollView setContentSize:CGSizeMake(self.webView.scrollView.contentSize.width, self.webView.scrollView.contentSize.height - [@"ABC" sizeWithFont:[UIFont fontWithName:@"Helvetica" size:13]].height)];
    heightForCell = self.webView.scrollView.contentSize.height + self.btnMore.frame.size.height + 2*MARGIN_CELL_DETAIL;
    self.btnMore.hidden = YES;
    if (heightForCell > DEFAULT_HEIGH_CELL_DES) {
        self.btnMore.hidden = NO;
    }
    [self.webView.scrollView setBackgroundColor:[UIColor blueColor]];
}
@end
