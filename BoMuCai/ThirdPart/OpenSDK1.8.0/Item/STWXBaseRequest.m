//
//  STWXBaseRequest.m
//  STIntelligent
//
//  Created by 步晓虎 on 2017/8/4.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "STWXBaseRequest.h"

NSString * const WXRequestKey = @"WXRequestKey";

@implementation STWXBaseRequest

- (instancetype) init
{
    if (self = [super init])
    {
        BXHNetWorkPartManager *manager = [[[BXHRequestEngine defaultEngine] managers] objectForKey:WXRequestKey];
        if (!manager)
        {
            manager = [BXHNetWorkPartManager mangerWithHost:@"https://api.weixin.qq.com" andsessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] valueKey:WXRequestKey];
            [[BXHRequestEngine defaultEngine].managers setValue:manager forKey:WXRequestKey];
        }
        
        self.timeOut = 30;
        self.manager = manager;
        self.requestSerializerType = BXHRequestSerializerTypeJSON;
        self.responseSerializerType = BXHResponseSerializerTypeJSON;
    }
    return self;
}


@end
