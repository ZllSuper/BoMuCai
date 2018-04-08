//
//  SearchCollectionCell.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/1/18.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "SearchCollectionCell.h"

@implementation SearchCollectionCell

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
- (void)setWeakModel:(SearchModel *)weakModel
{
    _weakModel = weakModel;
    self.titleLabel.text = weakModel.name;
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
