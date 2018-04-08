//
//  CarOrderInputAddressView.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/4.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "CarOrderInputAddressView.h"

@implementation CarOrderInputAddressView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = Color_White;

        [self addSubview:self.iconImageView];
        [self addSubview:self.nameLabel];
        [self addSubview:self.phoneLabel];
        [self addSubview:self.detailAddressLabel];
        [self addSubview:self.rightImageView];
        [self addSubview:self.tipLabel];
        
        [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(16);
            make.top.mas_equalTo(self).offset(20);
            make.size.mas_equalTo(CGSizeMake(13, 16));
        }];
        
        [self.rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self).offset(-15);
            make.centerY.mas_equalTo(self).offset(-4);
            make.size.mas_equalTo(CGSizeMake(7.5, 13.5));
        }];
        
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self).offset(20);
            make.left.mas_equalTo(self.iconImageView.mas_right).offset(15);
        }];
        
        [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.rightImageView.mas_left).offset(-10);
            make.top.mas_equalTo(self).offset(20);
        }];
        
        [self.detailAddressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(5);
            make.left.mas_equalTo(self.nameLabel);
            make.right.mas_equalTo(self.phoneLabel);
        }];
        
        [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.centerY.mas_equalTo(self).offset(-4);
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

#pragma mark - get / set
- (void)reloadAddressWithModel:(PCAddressModel *)addressModel
{
    self.addressModel = addressModel;
    if (addressModel)
    {
        self.nameLabel.hidden = NO;
        self.phoneLabel.hidden = NO;
        self.detailAddressLabel.hidden = NO;
        self.tipLabel.hidden = YES;
        
        self.nameLabel.text = [NSString stringWithFormat:@"收货人：%@",addressModel.name];
        self.phoneLabel.text = addressModel.phone;
        self.detailAddressLabel.text = [NSString stringWithFormat:@"地址：%@%@%@%@",addressModel.province,addressModel.city,addressModel.area,addressModel.address];
        CGFloat height = [self.detailAddressLabel.text size_With_Font:Font_sys_12 constrainedToSize:CGSizeMake(DEF_SCREENWIDTH - 62, MAXFLOAT)].height;
        self.height = 55 + 8 + height;
    }
    else
    {
        self.nameLabel.hidden = YES;
        self.phoneLabel.hidden = YES;
        self.detailAddressLabel.hidden = YES;
        self.tipLabel.hidden = NO;
        self.height = 60;
    }
   
}

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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
