//
//  PCBackOrderModel.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/4/14.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "PCBackOrderModel.h"

@implementation PCBackOrderModel

- (NSDictionary *)bxhReplaceKeyFormPropertyNames
{
    return @{@"oid" : @"id"};
}

- (void)keyValueToObjecDidFinish
{
    if (self.orderRejectedDtoList)
    {
        self.orderRejectedDtoList = [PCGoodsModel bxhObjectArrayWithKeyValuesArray:self.orderRejectedDtoList];
    }
}

@end
