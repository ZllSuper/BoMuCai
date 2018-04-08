//
//  MessageCenterHeaderView.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/1/17.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "MessageCenterHeaderView.h"

@implementation MessageCenterHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = Color_White;
        
        [self addSubview:self.headerImageView];
        [self addSubview:self.nameLabel];
        [self addSubview:self.subTitleLabel];
        
        [self.headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(60, 60));
            make.centerY.mas_equalTo(self);
            make.left.mas_equalTo(self).offset(16);
        }];
        
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.headerImageView.mas_centerY).offset(-2);
            make.left.mas_equalTo(self.headerImageView.mas_right).offset(15);
            make.right.mas_equalTo(self).offset(-16);
        }];
        
        [self.subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.headerImageView.mas_centerY).offset(2);
            make.left.mas_equalTo(self.nameLabel);
            make.right.mas_equalTo(self).offset(-16);
        }];
    }
    return self;
}


#pragma mark - get
- (UIImageView *)headerImageView
{
    if (!_headerImageView)
    {
        _headerImageView = [[UIImageView alloc] init];
        _headerImageView.image = ImageWithName(@"SysMessageIcon");
        _headerImageView.layer.cornerRadius = 30;
        _headerImageView.clipsToBounds = YES;
        _headerImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _headerImageView;
}

- (UILabel *)nameLabel
{
    if (!_nameLabel)
    {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = Font_sys_14;
        _nameLabel.textColor = Color_MainText;
        _nameLabel.text = @"系统消息";
    }
    return _nameLabel;
}

- (UILabel *)subTitleLabel
{
    if (!_subTitleLabel)
    {
        _subTitleLabel = [[UILabel alloc] init];
        _subTitleLabel.textColor = Color_Text_LightGray;
        _subTitleLabel.font = Font_sys_12;
    }
    return _subTitleLabel;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
