//
//  WaresDetailBottomView.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/3.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "WaresDetailBottomView.h"

@implementation WaresDetailBottomView

- (instancetype)init
{
    if (self = [super init])
    {
        self.backgroundColor = Color_White;
        
        [self addSubview:self.carBtn];
        [self addSubview:self.contactBtn];
        [self addSubview:self.buyBtn];
        [self addSubview:self.addCarBtn];
        
        [self.carBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(44);
            make.top.mas_equalTo(self);
            make.left.mas_equalTo(self);
            make.bottom.mas_equalTo(self);
        }];
        
        [self.contactBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.carBtn.mas_right);
            make.top.mas_equalTo(self);
            make.bottom.mas_equalTo(self);
            make.right.mas_equalTo(self.mas_left).offset(DEF_SCREENWIDTH * 0.45);
        }];
        
        [self.buyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contactBtn.mas_right);
            make.top.mas_equalTo(self);
            make.bottom.mas_equalTo(self);
        }];
        
        [self.addCarBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.buyBtn.mas_right);
            make.top.mas_equalTo(self);
            make.bottom.mas_equalTo(self);
            make.right.mas_equalTo(self);
            make.width.mas_equalTo(self.buyBtn);
        }];
    }
    return self;
}

#pragma mark - get
- (UIButton *)carBtn
{
    if (!_carBtn)
    {
        _carBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_carBtn setImage:ImageWithName(@"WaresCarIcon") forState:UIControlStateNormal];
    }
    return _carBtn;
}

- (UIButton *)contactBtn
{
    if (!_contactBtn)
    {
        _contactBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_contactBtn setImage:ImageWithName(@"WaresContactIcon") forState:UIControlStateNormal];
        [_contactBtn setTitle:@"联系卖家" forState:UIControlStateNormal];
        [_contactBtn setTitleColor:Color_MainText forState:UIControlStateNormal];
        _contactBtn.titleLabel.font = Font_sys_14;
        _contactBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    }
    return _contactBtn;
}

- (UIButton *)buyBtn
{
    if (!_buyBtn)
    {
        _buyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_buyBtn setTitle:@"立即购买" forState:UIControlStateNormal];
        [_buyBtn setBackgroundImage:ImageWithColor(UIColorFromRGB(0xDFBC40)) forState:UIControlStateNormal];
        [_buyBtn setTitleColor:Color_White forState:UIControlStateNormal];
        _buyBtn.titleLabel.font = Font_sys_14;
//        [_buyBtn addTarget:self action:@selector(buyBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _buyBtn;
}

- (UIButton *)addCarBtn
{
    if (!_addCarBtn)
    {
        _addCarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addCarBtn setTitle:@"加入购物车" forState:UIControlStateNormal];
        [_addCarBtn setBackgroundImage:ImageWithColor(Color_Main_Dark) forState:UIControlStateNormal];
        [_addCarBtn setTitleColor:Color_White forState:UIControlStateNormal];
        _addCarBtn.titleLabel.font = Font_sys_14;
//        [_addCarBtn addTarget:self action:@selector(addCarBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addCarBtn;
}

- (JSBadgeView *)badgeView
{
    if (!_badgeView)
    {
        _badgeView = [[JSBadgeView alloc] initWithParentView:self.carBtn alignment:JSBadgeViewAlignmentTopRight];
        _badgeView.badgePositionAdjustment = CGPointMake(-10, 12);
        //1、背景色
        _badgeView.badgeBackgroundColor = [UIColor redColor];
        //2、没有反光面
        _badgeView.badgeOverlayColor = [UIColor clearColor];
        //3、外圈的颜色，默认是白色
        _badgeView.badgeStrokeColor = [UIColor redColor];

    }
    return _badgeView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
