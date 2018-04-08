//
//  BXHRefreshHeader.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/10.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "BXHRefreshHeader.h"

@implementation BXHRefreshHeader

- (void)setPullingPercent:(CGFloat)pullingPercent
{
    [super setPullingPercent:pullingPercent];

    self.clockView.progress = pullingPercent;
}

- (void)stateDelayAction
{
    // 如果执行完动画发现不是idle状态，就直接返回，进入其他状态
    if (self.state != MJRefreshStateIdle) return;
    [self.clockView endAnimate];
}

- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState
    
    // 根据状态做事情
    if (state == MJRefreshStateIdle)
    {
        if (oldState == MJRefreshStateRefreshing)
        {
            [self performSelector:@selector(stateDelayAction) withObject:nil afterDelay:MJRefreshSlowAnimationDuration];
        }
        else
        {
            [self.clockView endAnimate];
        }

    }
    else if (state == MJRefreshStatePulling)
    {
    }
    else if (state == MJRefreshStateRefreshing)
    {
        self.clockView.progress = 1;
        [self.clockView startAnimate];
    }
}

- (BXHClockView *)clockView
{
    if (!_clockView)
    {
        _clockView = [[BXHClockView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        [self addSubview:_clockView];
    }
    return _clockView;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.clockView.centerX = self.mj_w * 0.5;
    self.clockView.centerY = self.mj_h * 0.5;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
