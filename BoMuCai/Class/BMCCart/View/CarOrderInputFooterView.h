//
//  CarOrderInputFooterView.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/4.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopCouponModel.h"
#import "CarShopModel.h"

@interface OrderInputCouponFooter : UIControl

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *couponLabel;

@property (nonatomic, assign) BOOL showCoupon;

@end

@class CarOrderInputFooterView;
@protocol CarOrderInputFooterViewProtcol <NSObject>

- (void)footerViewCouponAction:(CarOrderInputFooterView *)footerView;

@end

@interface CarOrderInputFooterView : UITableViewHeaderFooterView

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *frePriceLabel;

@property (nonatomic, strong) UILabel *countLabel;

@property (nonatomic, strong) UILabel *totalPriceLabel;

@property (nonatomic, strong) UILabel *tipLabel;

@property (nonatomic, strong) UILabel *frePriceSecLabel;

@property (nonatomic, strong) OrderInputCouponFooter *couponView;

@property (nonatomic, weak) CarShopModel *shopModel;

@property (nonatomic, weak) id <CarOrderInputFooterViewProtcol>actionProtcol;

@end
