//
//  ShopDetailHeaderView.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/1/20.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "ShopDetailHeaderView.h"

@implementation ShopDetailHeaderView

- (instancetype) initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self addSubview:self.iconNameView];
        [self addSubview:self.couponView];
        [self.iconNameView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self);
            make.left.mas_equalTo(self);
            make.right.mas_equalTo(self);
            make.height.mas_equalTo(self.iconNameView.mas_width).multipliedBy(2 / 3.0);
        }];
        
        [self.couponView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(16);
            make.right.mas_equalTo(self).offset(-16);
            make.height.mas_equalTo(ItemHeight + 20);
            make.centerY.mas_equalTo(self.iconNameView.mas_bottom);
        }];
    }
    return self;
}

#pragma mark - couponDelegate
- (void)showView:(ShopCouponShowView *)showView couponBtnAction:(ShopCouponBtn *)btn
{
    [self.protcol headerView:self couponBtnAction:btn];
}

+ (CGSize)sizeForHeader
{
    return CGSizeMake(DEF_SCREENWIDTH, (ItemHeight + 20) / 2 + 10 + DEF_SCREENWIDTH  * (2 / 3.0));
}

- (void)setShopModel:(BMCShopModel *)shopModel
{
    _shopModel = shopModel;
    [self.iconNameView.headerImageView sd_setImageWithURL:[NSURL encodeURLWithString:shopModel.image] placeholderImage:ImagePlaceHolder];
    self.iconNameView.levelLabel.text = shopModel.shopLevel;
    self.iconNameView.authIcon.hidden = [shopModel.auditingStatus isEqualToString:@"00100002"];
    self.iconNameView.nameLabel.text = shopModel.name;
    self.iconNameView.careNumLabel.text = [NSString stringWithFormat:@"关注：%@",shopModel.careNum];
}

- (void)setCouponAry:(NSArray *)couponAry
{
    self.couponView.shopCouponModelAry = couponAry;
}

- (NSArray *)couponAry
{
    return self.couponView.shopCouponModelAry;
}

#pragma mark - get
- (ShopCouponShowView *)couponView
{
    if (!_couponView)
    {
        _couponView = [[ShopCouponShowView alloc] init];
        _couponView.protcol = self;
    }
    return _couponView;
}

- (ShopIconAndNameView *)iconNameView
{
    if (!_iconNameView)
    {
        _iconNameView = [ShopIconAndNameView viewFromXIB];
    }
    return _iconNameView;
}

@end
