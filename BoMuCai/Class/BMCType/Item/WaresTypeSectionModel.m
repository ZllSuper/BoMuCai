//
//  WaresTypeSectionModel.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/14.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "WaresTypeSectionModel.h"

@implementation WaresTypeSectionModel

- (NSDictionary *)bxhReplaceKeyFormPropertyNames
{
    return @{@"models" : @"mdseTypePropertyDetailDtos"};
}

- (void)keyValueToObjecDidFinish
{
    if (self.models && self.models.count > 0)
    {
        self.models = [WaresTypeModel bxhObjectArrayWithKeyValuesArray:self.models];
    }
}

@end
