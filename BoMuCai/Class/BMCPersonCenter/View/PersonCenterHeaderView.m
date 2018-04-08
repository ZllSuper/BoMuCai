//
//  PersonCenterHeaderView.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/6.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "PersonCenterHeaderView.h"

@implementation PersonCenterHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    frame = CGRectMake(0, 0, DEF_SCREENWIDTH, DEF_SCREENWIDTH * (2.0 / 3) + (DEF_SCREENWIDTH - 32) * (150.0 / 718) / 2 + 8);
    if (self = [super initWithFrame:frame])
    {
        [self addSubview:self.iconNameView];
        [self addSubview:self.statueView];
        
        [self.iconNameView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.and.top.mas_equalTo(self);
            make.height.mas_equalTo(self.iconNameView.mas_width).multipliedBy(2.0/3);
        }];
        
        [self.statueView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.iconNameView.mas_bottom);
            make.left.mas_equalTo(self).offset(16);
            make.right.mas_equalTo(self).offset(-16);
            make.height.mas_equalTo(self.statueView.mas_width).multipliedBy(150.0 / 718);
        }];
    }
    return self;
}

#pragma mark - get
- (PersonCenterIconAndNameView *)iconNameView
{
    if (!_iconNameView)
    {
        _iconNameView = [PersonCenterIconAndNameView viewFromXIB];
    }
    return _iconNameView;
}

- (PersonCenterOrderStatueView *)statueView
{
    if (!_statueView)
    {
        _statueView = [[PersonCenterOrderStatueView alloc] init];
    }
    return _statueView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
