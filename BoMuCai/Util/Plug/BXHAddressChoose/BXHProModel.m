//
//  BXHProModel.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/8.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "BXHProModel.h"

@implementation BXHProModel

- (void)keyValueToObjecDidFinish
{
    if (self.cityList)
    {
        self.cityList = [BXHCityModel bxhObjectArrayWithKeyValuesArray:self.cityList];
    }
}

- (void)objectToKeyValueWillBegain
{
    if (self.cityList)
    {
        self.cityList = [BXHCityModel bxhKeyValuesArrayWithObjectAry:self.cityList];
    }
}


@end
