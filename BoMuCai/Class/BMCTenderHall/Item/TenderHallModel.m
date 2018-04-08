//
//  TenderHallModel.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/28.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "TenderHallModel.h"

@implementation TenderHallModel

- (NSDictionary *)bxhReplaceKeyFormPropertyNames
{
    return @{@"hallId" : @"id"};
}

- (NSString *)switchTenderStatue
{
    if ([self.tenderStatus isEqualToString:@"00700001"])
    {
        return @"招标中";
    }
    else if ([self.tenderStatus isEqualToString:@"00700002"])
    {
        return @"已结束";
    }
    else
    {
        return @"未开始";
    }
}

@end
