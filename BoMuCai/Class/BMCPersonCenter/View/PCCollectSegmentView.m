//
//  PCCollectSegmentView.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/10.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "PCCollectSegmentView.h"

@interface PCCollectSegmentView()

@property (nonatomic, strong) MASConstraint *lineLeft;

@end

@implementation PCCollectSegmentView

- (instancetype)init
{
    if (self = [super init])
    {
        self.backgroundColor = Color_White;
        
        [self addSubview:self.goodsBtn];
        [self addSubview:self.shopBtn];
        [self addSubview:self.bottomLineView];
        [self addSubview:self.selLineView];
        
        [self.goodsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self);
            make.bottom.mas_equalTo(self).offset(-1);
            make.right.mas_equalTo(self.mas_centerX);
            make.width.mas_equalTo(80);
        }];
        
        [self.shopBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self);
            make.bottom.mas_equalTo(self).offset(-1);
            make.left.mas_equalTo(self.mas_centerX);
            make.width.mas_equalTo(80);
        }];
        
        [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.and.left.and.right.mas_equalTo(self);
            make.height.mas_equalTo(0.7);
        }];
        
        [self.selLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self);
            make.width.mas_equalTo(30);
            make.height.mas_equalTo(1);
            self.lineLeft = make.left.mas_equalTo(self.goodsBtn).offset(25);
        }];
    }
    return self;
}

#pragma mark - action
- (void)btnAction:(UIButton *)sender
{
    if ([sender isEqual:self.goodsBtn])
    {
        self.goodsBtn.selected = YES;
        self.shopBtn.selected = NO;
        [UIView animateWithDuration:0.3 animations:^{
            self.lineLeft.offset(25);
            [self layoutIfNeeded];
        }];
    }
    else
    {
        self.goodsBtn.selected = NO;
        self.shopBtn.selected = YES;
        [UIView animateWithDuration:0.3 animations:^{
            self.lineLeft.offset(105);
            [self layoutIfNeeded];
        }];
    }
    
    [self.delegate segmentViewBtnAction:self];
}

#pragma mark - get
- (UIButton *)goodsBtn
{
    if (!_goodsBtn)
    {
        _goodsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_goodsBtn setTitle:@"商品" forState:UIControlStateNormal];
        [_goodsBtn setTitleColor:Color_Main_Dark forState:UIControlStateSelected];
        [_goodsBtn setTitleColor:Color_Text_Gray forState:UIControlStateNormal];
        [_goodsBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        _goodsBtn.titleLabel.font = Font_sys_14;
        _goodsBtn.selected = YES;
        
    }
    return _goodsBtn;
}

- (UIButton *)shopBtn
{
    if (!_shopBtn)
    {
        _shopBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_shopBtn setTitle:@"店铺" forState:UIControlStateNormal];
        [_shopBtn setTitleColor:Color_Main_Dark forState:UIControlStateSelected];
        [_shopBtn setTitleColor:Color_Text_Gray forState:UIControlStateNormal];
        [_shopBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        _shopBtn.titleLabel.font = Font_sys_14;
    }
    return _shopBtn;
}

- (UIView *)selLineView
{
    if (!_selLineView)
    {
        _selLineView = [[UIView alloc] init];
        _selLineView.backgroundColor = Color_Main_Dark;
    }
    return _selLineView;
}

- (UIView *)bottomLineView
{
    if (!_bottomLineView)
    {
        _bottomLineView = [[UIView alloc] init];
        _bottomLineView.backgroundColor = Color_Gray_Line;
    }
    return _bottomLineView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
