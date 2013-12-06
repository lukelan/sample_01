//
//  DefineConstant.h
//  MovieTicket
//
//  Created by Le Ngoc Duy on 12/10/12.
//  Copyright (c) 2012 Phuong. Nguyen Minh. All rights reserved.
//

#ifndef MovieTicket_DefineConstant_h
#define MovieTicket_DefineConstant_h
#define SAFE_RELEASE(p) {if (p){[p release]; p = nil;}}
//show / hide remember info
#define IS_ENABLE_REMEMBER_FUNCTION 0
// Debug
#define IS_DEBUG_LOG_MEM 0
#define USING_LOCAL_TESTING 0

#define IS_NEED_OVERRIDE_DATABASE 1//define value to override database(1:need Override, 0: nothing)
#define IS_GA_ENABLE 1

#ifdef DEBUG
#define GA_TRACKING_ID @"UA-39785275-1"// @"UA-39765806-1"
#define LOG_123PHIM(s...) {NSLog(@"%@",[NSString stringWithFormat:@"123Phim_LOG: %@",[NSString stringWithFormat:s]]);}
#else
#define GA_TRACKING_ID @"UA-38927740-1"
#define LOG_123PHIM(s...) ;
#endif

#define FONT_NAME @"Helvetica"
#define FONT_BOLD_NAME @"Helvetica-Bold"


//define default contant for height of component of ihpne
#define TITLE_BAR_HEIGHT 20 //[UIApplication sharedApplication].statusBarFrame.size.height)
#define NAVIGATION_BAR_HEIGHT 44
#define TAB_BAR_HEIGHT 44
#define TOOL_BAR_HEIGHT 40

#define IS_RETINA ([[UIScreen mainScreen] scale] > 1.0 )

#define CACHE_IMAGE_PATH ([NSString stringWithFormat:@"%@/images/",NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0]])

#define HOME_TABLE_CELL_HEIGHT 84
#endif
