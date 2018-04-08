//
//  PCOrderDetailModel.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/4/13.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "PCOrderDetailModel.h"

@implementation PCOrderDetailModel

- (void)keyValueToObjecDidFinish
{
    if (self.orderMdseDtoList)
    {
        self.orderMdseDtoList = [PCGoodsModel bxhObjectArrayWithKeyValuesArray:self.orderMdseDtoList];
    }
}

@end
