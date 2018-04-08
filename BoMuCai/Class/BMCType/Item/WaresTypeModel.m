//
//  WaresTypeModel.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/3.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "WaresTypeModel.h"

@implementation WaresTypeModel

- (instancetype)init
{
    if (self = [super init])
    {
        self.statue = WaresTypeNormal;
    }
    return self;
}

- (NSDictionary *)bxhReplaceKeyFormPropertyNames
{
    return @{@"typeId" : @"id"};
}

- (NSArray *)bxhIgnoredPropertyNames
{
    return @[@"statue"];
}

@end
