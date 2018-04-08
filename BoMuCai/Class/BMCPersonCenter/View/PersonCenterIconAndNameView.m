//
//  PersonCenterIconAndNameView.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/6.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "PersonCenterIconAndNameView.h"

@implementation PersonCenterIconAndNameView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.headerImageView.layer.cornerRadius = 40;
    self.headerImageView.layer.masksToBounds = YES;
//    self.progressView.transform = CGAffineTransformMakeScale(2, 2);
    [self.progressView setProgressImage:ImageWithResizableImage(@"PCProgressTopImage", UIEdgeInsetsMake(3, 5, 3, 5))];
    [self.progressView setTrackImage:ImageWithResizableImage(@"PCProgressBackImage", UIEdgeInsetsMake(3, 10, 3, 10))];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
