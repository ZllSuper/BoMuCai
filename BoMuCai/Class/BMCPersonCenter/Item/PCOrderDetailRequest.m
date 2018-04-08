//
//  PCOrderDetailRequest.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/4/13.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "PCOrderDetailRequest.h"

@implementation PCOrderDetailRequest

- (NSDictionary *)bxhReplaceKeyFormPropertyNames
{
    return @{@"orderId" : @"id"};
}

- (void)serializeHTTPRequest
{
    [super serializeHTTPRequest];
    self.relativeUrlString = KURL_OrderDetail;
    self.reuqestBody = [self bxhkeyValues];
    self.method = BXHRequestMethodPost;
}


@end
