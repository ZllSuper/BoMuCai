//
//  CartPayOrderCreatRequest.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/4/20.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "CartPayOrderCreatRequest.h"

@implementation CartPayOrderCreatRequest

- (NSDictionary *)bxhReplaceKeyFormPropertyNames
{
    return @{@"orderId" : @"id"};
}

- (void)serializeHTTPRequest
{
    [super serializeHTTPRequest];
    self.relativeUrlString = KURL_PayOrderCreat;
    self.reuqestBody = [self bxhkeyValues];
    self.method = BXHRequestMethodPost;
}


@end
