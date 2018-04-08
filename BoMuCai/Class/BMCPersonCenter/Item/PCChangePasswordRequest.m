//
//  PCChangePasswordRequest.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/17.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "PCChangePasswordRequest.h"

@implementation PCChangePasswordRequest

- (NSDictionary *)bxhReplaceKeyFormPropertyNames
{
    return @{@"passwordNew" : @"newPassword"};
}

- (void)serializeHTTPRequest
{
    [super serializeHTTPRequest];
    self.relativeUrlString = KURL_ChangePassword;
    self.reuqestBody = [self bxhkeyValues];
    self.method = BXHRequestMethodPost;
}


@end
