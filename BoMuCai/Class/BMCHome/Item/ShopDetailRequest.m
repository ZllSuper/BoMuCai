//
//  ShopDetailRequest.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/20.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "ShopDetailRequest.h"

@implementation ShopDetailRequest

- (NSDictionary *)bxhReplaceKeyFormPropertyNames
{
    return @{@"shopId" : @"id"};
}

- (void)serializeHTTPRequest
{
    [super serializeHTTPRequest];
    self.relativeUrlString = KURL_ShopDetail;
    self.reuqestBody = [self bxhkeyValues];
    self.method = BXHRequestMethodPost;
}


@end
