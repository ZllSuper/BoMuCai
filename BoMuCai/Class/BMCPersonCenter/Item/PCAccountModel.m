//
//  PCAccountModel.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/8.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "PCAccountModel.h"

@implementation PCAccountModel

- (NSString *)sexToHanZi
{
    if (self.sex.length > 0)
    {
        return ([self.sex integerValue] == 0 ? @"男" : @"女");
    }
    return @"";
}

@end
