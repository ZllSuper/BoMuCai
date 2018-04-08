//
//  BaseMainRequest.m
//  GuoGangTong
//
//  Created by 步晓虎 on 2016/12/12.
//  Copyright © 2016年 woshishui. All rights reserved.
//

#import "BaseMainRequest.h"

NSString * const MainRequestKey = @"MainRequestKey";

@implementation BaseMainRequest

- (instancetype) init
{
    if (self = [super init])
    {
        BXHNetWorkPartManager *manager = [[[BXHRequestEngine defaultEngine] managers] objectForKey:MainRequestKey];
        if (!manager)
        {
            manager = [BXHNetWorkPartManager mangerWithHost:BaseRequestHost andsessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] valueKey:MainRequestKey];
            [[BXHRequestEngine defaultEngine].managers setValue:manager forKey:MainRequestKey];
        }
        
        self.timeOut = 30;
        self.manager = manager;
        self.requestSerializerType = BXHRequestSerializerTypeJSON;
        self.responseSerializerType = BXHResponseSerializerTypeJSON;
    }
    return self;
}




@end
