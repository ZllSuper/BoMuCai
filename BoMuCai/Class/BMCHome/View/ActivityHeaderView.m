//
//  ActivityHeaderView.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/1/19.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "ActivityHeaderView.h"

@implementation ActivityHeaderView

- (instancetype) initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self addSubview:self.imageView];
        [self addSubview:self.tipView];
        [self addSubview:self.timeView];
        
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self);
            make.right.mas_equalTo(self);
            make.top.mas_equalTo(self);
            make.height.mas_equalTo(self.imageView.mas_width).multipliedBy(12 / 25.0);
        }];
        
        [self.timeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self);
            make.right.mas_equalTo(self);
            make.top.mas_equalTo(self.imageView.mas_bottom);
            make.height.mas_equalTo(@90);
        }];
        
        [self.tipView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self);
            make.right.mas_equalTo(self);
            make.height.mas_equalTo(@40);
            make.top.mas_equalTo(self.timeView.mas_bottom);
        }];
    }
    return self;
}

+ (CGSize)sizeForHeader
{
    return CGSizeMake(DEF_SCREENWIDTH, 90 + 40 + DEF_SCREENWIDTH * (12 / 25.0));
}

#pragma mark - get
- (UIImageView *)imageView
{
    if (!_imageView)
    {
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.image = ImagePlaceHolder;
    }
    return _imageView;
}

- (ActivityTimeDownView *)timeView
{
    if (!_timeView)
    {
        _timeView = [ActivityTimeDownView viewFromXIB];
    }
    return _timeView;
}

- (ActivityMidTipView *)tipView
{
    if (!_tipView)
    {
        _tipView = [ActivityMidTipView viewFromXIB];
    }
    return _tipView;
}

@end
