//
//  PCAddressEditRequest.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/28.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "PCAddressEditRequest.h"

@implementation PCAddressEditRequest

- (NSDictionary *)bxhReplaceKeyFormPropertyNames
{
    return @{@"addressId" : @"id"};
}

- (void)serializeHTTPRequest
{
    [super serializeHTTPRequest];
    self.relativeUrlString = KURL_AddressEdit;
    self.reuqestBody = [self bxhkeyValues];
    self.method = BXHRequestMethodPost;
}



@end
