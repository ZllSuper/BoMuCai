//
//  PCFeedBackSelView.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/13.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "PCFeedBackSelView.h"

@implementation PCFeedBackSelView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.complaintBtn.selected = YES;
    self.experienceBtn.selected = NO;
}

- (IBAction)complaintBtnAction:(id)sender
{
    self.complaintBtn.selected = YES;
    self.experienceBtn.selected = NO;
}

- (IBAction)experienceBtnAction:(id)sender
{
    self.complaintBtn.selected = NO;
    self.experienceBtn.selected = YES;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
