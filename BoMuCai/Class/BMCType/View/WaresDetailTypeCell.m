//
//  WaresDetailTypeCell.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/14.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "WaresDetailTypeCell.h"

@implementation WaresDetailTypeCell
+ (CGSize)cellSizeWithShowText:(NSString *)text
{
    CGSize size = [text size_With_Font:Font_sys_12 constrainedToSize:CGSizeMake(DEF_SCREENWIDTH - 52, 24) lineBreakMode:NSLineBreakByTruncatingMiddle];
    return CGSizeMake(size.width + 20, 24);
}

- (instancetype) initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = Color_White;
        self.contentView.backgroundColor = Color_White;
        
        
        [self addSubview:self.backGroundView];
        [self addSubview:self.titleLabel];
        
        [self.backGroundView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self);
        }];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self).insets(UIEdgeInsetsMake(0, 5, 0, 5));
        }];
        
    }
    return self;
}

#pragma mark - set
- (void)setWeakModel:(WaresTypeModel *)weakModel
{
    _weakModel = weakModel;
    self.titleLabel.text = _weakModel.name;
    
    if (weakModel.statue == WaresTypeNormal)
    {
        self.backGroundView.backgroundColor = Color_TextFiledBack;
        self.backGroundView.layer.borderWidth = 0;
        self.titleLabel.textColor = Color_MainText;
    }
    else if (weakModel.statue == WaresTypeSelect)
    {
        self.backGroundView.backgroundColor = Color_White;
        self.backGroundView.layer.borderWidth = 1;
        self.titleLabel.textColor = Color_MainText;
    }
    else if (weakModel.statue == WaresTypeUnenable)
    {
        self.backGroundView.backgroundColor = Color_TextFiledBack;
        self.backGroundView.layer.borderWidth = 0;
        self.titleLabel.textColor = Color_Text_LightGray;
    }
}

#pragma mark - get
- (UIView *)backGroundView
{
    if (!_backGroundView)
    {
        _backGroundView = [[UIView alloc] init];
        _backGroundView.backgroundColor = Color_TextFiledBack;
        _backGroundView.layer.cornerRadius = 8;
        _backGroundView.layer.masksToBounds = YES;
        _backGroundView.layer.borderColor = Color_Main_Dark.CGColor;
        _backGroundView.layer.borderWidth = 1;
    }
    return _backGroundView;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = Font_sys_12;
        _titleLabel.textColor = Color_MainText;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
    }
    return _titleLabel;
}

@end
