//
//  SearchCollectionReusableView.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/1/18.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "SearchCollectionReusableView.h"

@implementation SearchCollectionReusableView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self addSubview:self.sectionTitleLabel];
        
        [self.sectionTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self);
            make.centerY.mas_equalTo(self);
        }];
    }
    return self;
}

#pragma mark - get
- (UILabel *)sectionTitleLabel
{
    if (!_sectionTitleLabel)
    {
        _sectionTitleLabel = [[UILabel alloc] init];
        _sectionTitleLabel.textColor = Color_MainText;
        _sectionTitleLabel.font = Font_sys_14;
    }
    return _sectionTitleLabel;
}

@end
