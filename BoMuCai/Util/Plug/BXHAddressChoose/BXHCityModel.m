//
//  BXHCityModel.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/8.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "BXHCityModel.h"

@implementation BXHCityModel

- (void)keyValueToObjecDidFinish
{
    if (self.areaList)
    {
        self.areaList = [BXHAreaModel bxhObjectArrayWithKeyValuesArray:self.areaList];
    }
}

- (void)objectToKeyValueWillBegain
{
    if (self.areaList)
    {
        self.areaList = [BXHAreaModel bxhKeyValuesArrayWithObjectAry:self.areaList];
    }
}


@end
