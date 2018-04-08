//
//  ShopCouponShowView.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/1/22.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "ShopCouponShowView.h"

@implementation ShopCouponShowView

- (instancetype)init
{
    if (self = [super init])
    {
        self.backgroundColor = Color_White;
        
    }
    return self;
}

#pragma mark - action
- (void)shopCouponBtnAction:(ShopCouponBtn *)sender
{
    [self.protcol showView:self couponBtnAction:sender];
}

- (void)loadCouponItem
{
    [self removeAllSubviews];
    ShopCouponBtn *topBtn = nil;
    for (ShopCouponModel *model in self.shopCouponModelAry)
    {
        BOOL end = ([self.shopCouponModelAry indexOfObject:model] == self.shopCouponModelAry.count - 1);
        topBtn = [self creatCouponBtnWithModel:model topBtn:topBtn atEnd:end];
    }
}

- (ShopCouponBtn *)creatCouponBtnWithModel:(ShopCouponModel *)model topBtn:(ShopCouponBtn *)topBtn atEnd:(BOOL)end
{
    ShopCouponBtn *btn = [[ShopCouponBtn alloc] init];
    [btn addTarget:self action:@selector(shopCouponBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    btn.weakModel = model;
    [self addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        if (!topBtn)
        {
            make.left.mas_equalTo(self).offset(10);
        }
        else
        {
            make.left.mas_equalTo(topBtn.mas_right).offset(16);
        }
        
        if (end)
        {
            make.right.mas_equalTo(self).offset(-10);
        }
        
        make.top.mas_equalTo(self).offset(10);
        make.size.mas_equalTo(CGSizeMake(ItemWidth, ItemHeight));
    }];
    return btn;
}

#pragma mark - get
- (void)setShopCouponModelAry:(NSArray *)shopCouponModelAry
{
    _shopCouponModelAry = shopCouponModelAry;
    [self loadCouponItem];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
