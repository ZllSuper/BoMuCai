//
//  WaresCommendSectionHeader.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/1/24.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "WaresCommendSectionHeader.h"

@implementation WaresCommendSectionHeader

+ (CGFloat)showHeight
{
    return 52;
}

- (instancetype)init
{
    if (self = [super init])
    {
        self.backgroundColor = Color_Clear;
        
        [self addSubview:self.backGroundView];
        [self addSubview:self.titleLabel];
        [self addSubview:self.leftLine];
        [self addSubview:self.rightLine];
        
        [self.backGroundView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self).insets(UIEdgeInsetsMake(8, 0, 0, 0));
        }];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.backGroundView);
            make.centerX.mas_equalTo(self);
        }];
        
        [self.leftLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.titleLabel.mas_left).offset(-5);
            make.height.mas_equalTo(1);
            make.width.mas_equalTo(40);
            make.centerY.mas_equalTo(self.titleLabel);
        }];
        
        [self.rightLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.titleLabel.mas_right).offset(5);
            make.height.mas_equalTo(1);
            make.width.mas_equalTo(40);
            make.centerY.mas_equalTo(self.titleLabel);
        }];
    }
    return self;
}

#pragma mark - get
- (UIView *)backGroundView
{
    if (!_backGroundView)
    {
        _backGroundView = [[UIView alloc] init];
        _backGroundView.backgroundColor = Color_White;
    }
    return _backGroundView;
}

- (UIView *)leftLine
{
    if (!_leftLine)
    {
        _leftLine = [[UIView alloc] init];
        _leftLine.backgroundColor = Color_MainText;
    }
    return _leftLine;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = Font_sys_14;
        _titleLabel.text = @"店家推荐";
        _titleLabel.textColor = Color_MainText;
    }
    return _titleLabel;
}

- (UIView *)rightLine
{
    if (!_rightLine)
    {
        _rightLine = [[UIView alloc] init];
        _rightLine.backgroundColor = Color_MainText;
    }
    return _rightLine;
}
    

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
