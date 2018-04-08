//
//  LoginRequest.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/16.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "LoginRequest.h"

@implementation LoginRequest

- (void)serializeHTTPRequest
{
    [super serializeHTTPRequest];
    self.relativeUrlString = KURL_Login;
    self.reuqestBody = [self bxhkeyValues];
    self.method = BXHRequestMethodPost;
}


@end
