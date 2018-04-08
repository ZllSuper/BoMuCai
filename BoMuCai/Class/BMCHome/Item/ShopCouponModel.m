//
//  ShopCouponModel.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/1/22.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "ShopCouponModel.h"

@implementation ShopCouponModel

- (NSDictionary *)bxhReplaceKeyFormPropertyNames
{
    return @{@"couponId" : @"id"};
}

- (NSArray *)bxhIgnoredPropertyNames
{
    return @[@"enable",@"select"];
}

@end
