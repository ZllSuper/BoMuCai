//
//  PCOrderListGetRequest.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/4/12.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "PCOrderListGetRequest.h"

@implementation PCOrderListGetRequest

- (NSDictionary *)bxhReplaceKeyFormPropertyNames
{
    return @{@"requestType" : @"status"};
}

- (void)serializeHTTPRequest
{
    [super serializeHTTPRequest];
    self.relativeUrlString = KURL_OrderList;
    self.reuqestBody = [self bxhkeyValues];
    self.method = BXHRequestMethodPost;
}

@end
