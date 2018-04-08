//
//  PCAddressListRequest.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/21.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "PCAddressListRequest.h"

@implementation PCAddressListRequest

- (void)serializeHTTPRequest
{
    [super serializeHTTPRequest];
    self.relativeUrlString = KURL_AddressManager;
    self.reuqestBody = [self bxhkeyValues];
    self.method = BXHRequestMethodPost;
}


@end
