//
//  WaresShopCell.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/1/23.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "WaresShopCell.h"

@implementation WaresShopCell

+ (CGFloat)showHeight
{
    return 60;
}

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self addSubview:self.shopIconImageView];
        [self addSubview:self.shopNameLabel];
        [self addSubview:self.goinBtn];
        
        [self.goinBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self).offset(-16);
            make.centerY.mas_equalTo(self);
            make.size.mas_equalTo(CGSizeMake(70, 30));
        }];
        
        [self.shopIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(16);
            make.centerY.mas_equalTo(self);
            make.top.mas_equalTo(self).offset(10);
            make.bottom.mas_equalTo(self).offset(-10);
            make.width.mas_equalTo(self.shopIconImageView.mas_height);
        }];
        
        [self.shopNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.shopIconImageView.mas_right).offset(10);
            make.centerY.mas_equalTo(self.shopIconImageView);
            make.right.mas_equalTo(self.goinBtn.mas_left).offset(-10);
        }];
        
        self.shopNameLabel.text = @"衡水建材";
    }
    return self;
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
- (UIImageView *)shopIconImageView
{
    if (!_shopIconImageView)
    {
        _shopIconImageView = [[UIImageView alloc] init];
        _shopIconImageView.image = ImagePlaceHolder;
        _shopIconImageView.contentMode = UIViewContentModeScaleAspectFill;
        _shopIconImageView.clipsToBounds = YES;
        _shopIconImageView.layer.borderColor = Color_Gray_Line.CGColor;
        _shopIconImageView.layer.borderWidth = 1;
    }
    return _shopIconImageView;
}

- (UILabel *)shopNameLabel
{
    if (!_shopNameLabel)
    {
        _shopNameLabel = [[UILabel alloc] init];
        _shopNameLabel.textColor = Color_MainText;
        _shopNameLabel.font = Font_sys_14;
    }
    return _shopNameLabel;
}

- (UIButton *)goinBtn
{
    if (!_goinBtn)
    {
        _goinBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _goinBtn.layer.cornerRadius = 4;
        _goinBtn.layer.borderColor = Color_Main_Dark.CGColor;
        _goinBtn.layer.borderWidth = 1;
        _goinBtn.clipsToBounds = YES;
        [_goinBtn setTitle:@"进店逛逛" forState:UIControlStateNormal];
        [_goinBtn setTitleColor:Color_Main_Dark forState:UIControlStateNormal];
        _goinBtn.titleLabel.font = Font_sys_14;
        _goinBtn.userInteractionEnabled = NO;
    }
    return _goinBtn;
}

@end
