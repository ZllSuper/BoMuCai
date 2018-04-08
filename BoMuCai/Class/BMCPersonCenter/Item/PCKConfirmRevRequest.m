//
//  PCKConfirmRevRequest.m
//  BoMuCai
//
//  Created by Daniel on 2017/12/15.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "PCKConfirmRevRequest.h"

@implementation PCKConfirmRevRequest

- (NSDictionary *)bxhReplaceKeyFormPropertyNames
{
    return @{@"orderId" : @"id"};
}

- (void)serializeHTTPRequest
{
    [super serializeHTTPRequest];
    self.relativeUrlString = KURL_ConfirmRev;
    self.reuqestBody = [self bxhkeyValues];
    self.method = BXHRequestMethodPost;
}

@end
