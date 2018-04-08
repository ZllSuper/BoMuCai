//
//  CartGetDefaultAddressRequest.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/3/28.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "CartGetDefaultAddressRequest.h"

@implementation CartGetDefaultAddressRequest

- (void)serializeHTTPRequest
{
    [super serializeHTTPRequest];
    self.relativeUrlString = KURL_AddressDefaultGet;
    self.reuqestBody = [self bxhkeyValues];
    self.method = BXHRequestMethodPost;
}


@end
