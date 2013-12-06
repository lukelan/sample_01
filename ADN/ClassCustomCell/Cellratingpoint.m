//
//  Cellratingpoint.m
//  ADN
//
//  Created by Dao Pham Hoang Duy on 11/22/13.
//  Copyright (c) 2013 Le Ngoc Duy. All rights reserved.
//

#import "Cellratingpoint.h"

@implementation Cellratingpoint

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
-(void)getRatePoint :(NSString *)point : (NSArray *)array
{
    _lbRatePoint.text=point;
    DYRateView *rateView = [[DYRateView alloc] initWithFrame:CGRectMake(-10, 5, 100, 20)];
    rateView.rate = [point intValue];
    rateView.alignment = RateViewAlignmentRight;
    [self.uiviewrating addSubview:rateView];
//rong 118
//dai 12
    
    _lbSo1.text= [[array objectAtIndex:0] stringValue];
    _lbSo2.text= [[array objectAtIndex:1] stringValue];
    _lbSo3.text= [[array objectAtIndex:2] stringValue];
    _lbSo4.text= [[array objectAtIndex:3] stringValue];
    _lbSo5.text= [[array objectAtIndex:4] stringValue];
    int so1 = [[array objectAtIndex:0] intValue];
    int so2 = [[array objectAtIndex:1] intValue];
    int so3 = [[array objectAtIndex:2] intValue];
    int so4 = [[array objectAtIndex:3] intValue];
    int so5 = [[array objectAtIndex:4] intValue];
    int total = so1+so2+so3+so4+so5;
     _lbTotal.text = [NSString stringWithFormat:@"%d", total];
    if (total ==0)
    {
        _lbCellRate1.frame = CGRectMake(165, 21, 0, 12);
       
       
        _lbCellRate2.frame = CGRectMake(165, 48, 0, 12);
      
        _lbCellRate3.frame = CGRectMake(165, 73, 0, 12);
      
        _lbCellRate4.frame = CGRectMake(165,100,0, 12);
     
       _lbCellRate5.frame = CGRectMake(165, 127, 0, 12);
        return;
    }
    else
    {
      float kqSo1 = (float)so1/total;
        int kqLabel = ((kqSo1*110));
     _lbCellRate1.frame = CGRectMake(_lbCellRate1.frame.origin.x,_lbCellRate1.frame.origin.y , kqLabel, _lbCellRate1.frame.size.height);
        float kqSo2 = (float)so2/total;
        int kqLabel2 = ((kqSo2*110));
        _lbCellRate2.frame = CGRectMake(_lbCellRate2.frame.origin.x, _lbCellRate2.frame.origin.y , kqLabel2, _lbCellRate1.frame.size.height);
        float kqSo3 = (float)so3/total;
        int kqLabel3 = ((kqSo3*110));
        _lbCellRate3.frame = CGRectMake(_lbCellRate3.frame.origin.x, _lbCellRate3.frame.origin.y , kqLabel3, _lbCellRate1.frame.size.height);
       float kqSo4 = (float)so4/total;
        int kqLabel4 = ((kqSo4*110));
        _lbCellRate4.frame = CGRectMake(_lbCellRate4.frame.origin.x,_lbCellRate4.frame.origin.y , kqLabel4, _lbCellRate1.frame.size.height);
        float kqSo5 = (float)so5/total;
        int kqlabel5 = ((kqSo5*110));
        _lbCellRate5.frame = CGRectMake(_lbCellRate5.frame.origin.x, _lbCellRate5.frame.origin.y , kqlabel5, _lbCellRate1.frame.size.height);
    }
}
@end
