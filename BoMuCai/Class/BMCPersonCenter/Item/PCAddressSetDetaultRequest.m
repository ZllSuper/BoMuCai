//
//  PCAddressSetDetaultRequest.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/21.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "PCAddressSetDetaultRequest.h"

@implementation PCAddressSetDetaultRequest

- (NSDictionary *)bxhReplaceKeyFormPropertyNames
{
    return @{@"addressId" : @"id"};
}

- (void)serializeHTTPRequest
{
    [super serializeHTTPRequest];
    self.relativeUrlString = KURL_AddressSetDefault;
    self.reuqestBody = [self bxhkeyValues];
    self.method = BXHRequestMethodPost;
}



@end
