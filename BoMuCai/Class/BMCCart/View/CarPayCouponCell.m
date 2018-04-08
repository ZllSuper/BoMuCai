//
//  CarPayCouponCell.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/5.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "CarPayCouponCell.h"

@implementation CarPayCouponCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.rigthLabel];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(16);
            make.centerY.mas_equalTo(self.contentView);
        }];
        
        [self.rigthLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.contentView);
            make.centerY.mas_equalTo(self.contentView);
        }];
    }
    return self;;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - get
- (UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = Font_sys_14;
        _titleLabel.textColor = Color_MainText;
        _titleLabel.text = @"优惠券";
    }
    return _titleLabel;
}

- (UILabel *)rigthLabel
{
    if (!_rigthLabel)
    {
        _rigthLabel = [[UILabel alloc] init];
        _rigthLabel.font = Font_sys_14;
        _rigthLabel.textColor = Color_Text_Gray;
    }
    return _rigthLabel;
}

@end
