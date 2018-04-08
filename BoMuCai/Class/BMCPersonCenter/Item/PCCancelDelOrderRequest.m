//
//  PCCancelDelOrderRequest.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/4/14.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "PCCancelDelOrderRequest.h"

@implementation PCCancelDelOrderRequest

- (NSDictionary *)bxhReplaceKeyFormPropertyNames
{
    return @{@"orderId" : @"id"};
}

- (void)serializeHTTPRequest
{
    [super serializeHTTPRequest];
    self.relativeUrlString = KURL_CancelDelOrder;
    self.reuqestBody = [self bxhkeyValues];
    self.method = BXHRequestMethodPost;
}


@end
