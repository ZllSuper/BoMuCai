//
//  PCOrderModel.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/4/12.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "PCOrderModel.h"

@implementation PCOrderModel

- (NSDictionary *)bxhReplaceKeyFormPropertyNames
{
    return @{@"oid" : @"id"};
}

- (void)keyValueToObjecDidFinish
{
    if (self.orderMdseDtoList && self.orderMdseDtoList.count > 0)
    {
        self.orderMdseDtoList = [PCGoodsModel bxhObjectArrayWithKeyValuesArray:self.orderMdseDtoList];
    }
}

@end
