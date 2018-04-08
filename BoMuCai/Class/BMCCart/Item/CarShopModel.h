//
//  CarShopModel.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/3/14.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CarGoodModel.h"
#import "ShopCouponModel.h"

@interface CarShopModel : NSObject

@property (nonatomic, copy) NSString *shopId;

@property (nonatomic, copy) NSString *shopName;

@property (nonatomic, assign) NSInteger totalYunFei;

@property (nonatomic, assign) NSInteger buyNum;

@property (nonatomic, assign) NSInteger totalPrice;

@property (nonatomic, strong) NSMutableArray *cartMdseDto;

@property (nonatomic, strong) ShopCouponModel *couponModel;

@end
