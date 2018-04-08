//
//  WaresDetailItemCell.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/1/24.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "WaresDetailItemCell.h"

@interface  WaresDetailItemCell ()

@property (nonatomic, strong) UIView *midLine;

@property (nonatomic, strong) UIView *bottomLine;

@end

@implementation WaresDetailItemCell

+ (CGFloat)showHeight
{
    return (DEF_SCREENWIDTH / 2 - 1) * (180 / 160.0);
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        
        self.contentView.backgroundColor = Color_Clear;
        self.backgroundColor = Color_Clear;
    
        [self addSubview:self.leftItem];
        [self addSubview:self.rightItem];
        [self addSubview:self.midLine];
        [self addSubview:self.bottomLine];
        
        [self.leftItem mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self);
            make.left.mas_equalTo(self);
            make.bottom.mas_equalTo(self).offset(-1);
        }];
        
        [self.midLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.leftItem.mas_right);
            make.width.mas_equalTo(1);
            make.top.mas_equalTo(self);
            make.bottom.mas_equalTo(self);
        }];
        
        [self.rightItem mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.midLine.mas_right);
            make.top.mas_equalTo(self);
            make.bottom.mas_equalTo(self).offset(-1);
            make.right.mas_equalTo(self);
            make.width.mas_equalTo(self.leftItem);
        }];
        
        [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self);
            make.right.mas_equalTo(self);
            make.bottom.mas_equalTo(self);
            make.height.mas_equalTo(1);
        }];
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

#pragma mark - action
- (void)leftItemAction
{
    [self.delegate itemCell:self actionItem:self.leftItem];
}

- (void)rightItemAction
{
    [self.delegate itemCell:self actionItem:self.leftItem];
}

#pragma mark - get
- (WaresDetailItem *)leftItem
{
    if (!_leftItem)
    {
        _leftItem = [WaresDetailItem viewFromXIB];
        [_leftItem addTarget:self action:@selector(leftItemAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftItem;
}

- (WaresDetailItem *)rightItem
{
    if (!_rightItem)
    {
        _rightItem = [WaresDetailItem viewFromXIB];
        [_rightItem addTarget:self action:@selector(rightItemAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightItem;
}

- (UIView *)midLine
{
    if (!_midLine)
    {
        _midLine = [[UIView alloc] init];
        _midLine.backgroundColor = Color_Gray_Line;
    }
    return _midLine;
}

- (UIView *)bottomLine
{
    if (!_bottomLine)
    {
        _bottomLine = [[UIView alloc] init];
        _bottomLine.backgroundColor = Color_Gray_Line;
    }
    return _bottomLine;
}

@end
