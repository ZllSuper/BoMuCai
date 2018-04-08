//
//  BMCTypeModel.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/16.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "BMCTypeModel.h"

@implementation BMCTypeModel

- (NSDictionary *)bxhReplaceKeyFormPropertyNames
{
    return @{@"typeId" : @"id"};
}

- (void)keyValueToObjecDidFinish
{
    if (self.mdseTypeDtoList)
    {
        self.mdseTypeDtoList = [BMCTypeModel bxhObjectArrayWithKeyValuesArray:self.mdseTypeDtoList];
    }
}

@end
