//
//  PCOrderDetailAddressCell.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/7.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "PCOrderDetailAddressCell.h"

@implementation PCOrderDetailAddressCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = Color_White;
        
        [self addSubview:self.iconImageView];
        [self addSubview:self.nameLabel];
        [self addSubview:self.phoneLabel];
        [self addSubview:self.detailAddressLabel];
        [self addSubview:self.rightImageView];
        [self addSubview:self.tipLabel];
        
        [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(16);
            make.centerY.mas_equalTo(self).offset(-8);
            make.size.mas_equalTo(CGSizeMake(13, 16));
        }];
        
        [self.rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self).offset(-15);
            make.centerY.mas_equalTo(self).offset(-8);
            make.size.mas_equalTo(CGSizeZero);
//            make.size.mas_equalTo(CGSizeMake(7.5, 13.5));
        }];
        
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self).offset(20);
            make.left.mas_equalTo(self.iconImageView.mas_right).offset(15);
        }];
        
        [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.rightImageView.mas_left).offset(-10);
            make.top.mas_equalTo(self).offset(15);
        }];
        
        [self.detailAddressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_centerY).offset(-8);
            make.left.mas_equalTo(self.nameLabel);
            make.right.mas_equalTo(self.phoneLabel);
        }];
        
        [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.centerY.mas_equalTo(self).offset(-8);
        }];
        
        UIView *bottomLine = [self bottomLineView];
        [self addSubview:bottomLine];
        [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.and.bottom.mas_equalTo(self);
            make.height.mas_equalTo(8);
        }];
        
        
    }
    return self;
}

+ (CGFloat)cellHeight
{
    return 100;
}

#pragma mark - get

- (UIView *)bottomLineView
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = Color_Gray_bg;
    return view;
}
- (UILabel *)tipLabel
{
    if (!_tipLabel)
    {
        _tipLabel = [[UILabel alloc] init];
        _tipLabel.textColor = Color_Text_Gray;
        _tipLabel.font = Font_sys_14;
        _tipLabel.text = @"请选择收货地址";
        _tipLabel.hidden = YES;
    }
    return _tipLabel;
}

- (UIImageView *)iconImageView
{
    if (!_iconImageView)
    {
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.image = ImageWithName(@"CarAddressIcon");
    }
    return _iconImageView;
}

- (UILabel *)nameLabel
{
    if (!_nameLabel)
    {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = Font_sys_14;
        _nameLabel.textColor = Color_MainText;
    }
    return _nameLabel;
}

- (UILabel *)phoneLabel
{
    if (!_phoneLabel)
    {
        _phoneLabel = [[UILabel alloc] init];
        _phoneLabel.textAlignment = NSTextAlignmentRight;
        _phoneLabel.font = Font_sys_14;
        _phoneLabel.textColor = Color_MainText;
    }
    return _phoneLabel;
}

- (UILabel *)detailAddressLabel
{
    if (!_detailAddressLabel)
    {
        _detailAddressLabel = [[UILabel alloc] init];
        _detailAddressLabel.font = Font_sys_12;
        _detailAddressLabel.textColor = Color_Text_Gray;
        _detailAddressLabel.numberOfLines = 0;
    }
    return _detailAddressLabel;
}

- (UIImageView *)rightImageView
{
    if (!_rightImageView)
    {
        _rightImageView = [[UIImageView alloc] init];
        _rightImageView.image = ImageWithName(@"RightArrow");
    }
    return _rightImageView;
}

@end
