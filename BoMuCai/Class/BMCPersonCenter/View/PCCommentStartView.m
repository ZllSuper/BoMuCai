//
//  PCCommentStartView.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/7.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "PCCommentStartView.h"

@implementation PCCommentStartView

- (instancetype)init
{
    if (self = [super init])
    {
        self.backgroundColor = Color_White;
        [self addSubview:self.iconImageView];
        [self addSubview:self.titleLabel];
        [self addSubview:self.rateView];
        
        [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(16);
            make.centerY.mas_equalTo(self);
            make.size.mas_equalTo(CGSizeMake(60, 60));
        }];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.iconImageView.mas_centerY).offset(-5);
            make.left.mas_equalTo(self.iconImageView.mas_right).offset(10);
        }];
        
        [self.rateView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.iconImageView.mas_centerY);
            make.left.mas_equalTo(self.iconImageView.mas_right).offset(10);
            make.size.mas_equalTo(CGSizeMake(120, 20));
        }];
    }
    return self;
}

#pragma mark - get
- (UIImageView *)iconImageView
{
    if (!_iconImageView)
    {
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.image = ImagePlaceHolder;
        _iconImageView.clipsToBounds = YES;
        _iconImageView.contentMode = UIViewContentModeScaleAspectFill;
        _iconImageView.layer.borderColor = Color_Gray_Line.CGColor;
        _iconImageView.layer.borderWidth = 1;
    }
    return _iconImageView;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = Font_sys_14;
        _titleLabel.textColor = Color_MainText;
        _titleLabel.text = @"评分：";
    }
    return _titleLabel;
}

- (CWStarRateView *)rateView
{
    if (!_rateView)
    {
        _rateView = [[CWStarRateView alloc] initWithFrame:CGRectMake(0, 0, 120, 20) numberOfStars:5];
        _rateView.scorePercent = 0.2;
    }
    return _rateView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
