//
//  MyWebView.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/6/2.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "MyWebView.h"

@implementation MyWebView

- (void)layoutSubviews
{
    [super layoutSubviews];
    if (self.preHeight != self.scrollView.contentSize.height)
    {
        self.preHeight = self.scrollView.contentSize.height;
        [self.protcol webViewDidLayout:self height:self.scrollView.contentSize.height];
    }
    BXHLog(@"contentSIze = %lf",self.scrollView.contentSize.height);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
