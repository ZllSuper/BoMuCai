//
//  WaresTypeCell.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/1/24.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "WaresTypeCell.h"

@implementation WaresTypeCell

+ (CGFloat)showHeight
{
    return 44;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.rightLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(16);
            make.centerY.mas_equalTo(self.contentView);
            make.width.mas_equalTo(@80);
        }];
        
        [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.contentView).offset(-5);
            make.centerY.mas_equalTo(self.contentView);
            make.left.mas_equalTo(self.titleLabel.mas_right).offset(10);
        }];
    }
    return self;
}

- (void)awakeFromNib
{
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
        _titleLabel.text = @"选择型号";
    }
    return _titleLabel;
}

- (UILabel *)rightLabel
{
    if (!_rightLabel)
    {
         _rightLabel = [[UILabel alloc] init];
        _rightLabel.font = Font_sys_14;
        _rightLabel.textColor = Color_MainText;
        _rightLabel.textAlignment = NSTextAlignmentRight;
    }
    return _rightLabel;
}

@end
