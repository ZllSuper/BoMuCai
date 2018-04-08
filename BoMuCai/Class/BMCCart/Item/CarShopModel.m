//
//  CarShopModel.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/3/14.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "CarShopModel.h"

@implementation CarShopModel

- (NSArray *)bxhIgnoredPropertyNames
{
    return @[@"totalYunFei",@"totalPrice",@"buyNum",@"couponModel"];
}

- (void)keyValueToObjecDidFinish
{
    if (self.cartMdseDto && self.cartMdseDto.count > 0)
    {
        self.cartMdseDto = [CarGoodModel bxhObjectArrayWithKeyValuesArray:self.cartMdseDto];
    }
}

@end
