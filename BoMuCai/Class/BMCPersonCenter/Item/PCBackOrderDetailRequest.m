//
//  PCBackOrderDetailRequest.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/4/16.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "PCBackOrderDetailRequest.h"

@implementation PCBackOrderDetailRequest

- (NSDictionary *)bxhReplaceKeyFormPropertyNames
{
    return @{@"orderId" : @"id"};
}

- (void)serializeHTTPRequest
{
    [super serializeHTTPRequest];
    self.relativeUrlString = KURL_BackOrderDetail;
    self.reuqestBody = [self bxhkeyValues];
    self.method = BXHRequestMethodPost;
}


@end
