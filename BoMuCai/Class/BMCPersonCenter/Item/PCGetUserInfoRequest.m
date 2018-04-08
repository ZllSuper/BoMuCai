//
//  PCGetUserInfoRequest.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/4/16.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "PCGetUserInfoRequest.h"

@implementation PCGetUserInfoRequest

- (NSDictionary *)bxhReplaceKeyFormPropertyNames
{
    return @{@"userId" : @"id"};
}

- (void)serializeHTTPRequest
{
    [super serializeHTTPRequest];
    self.relativeUrlString = KURL_UserInfo;
    self.reuqestBody = [self bxhkeyValues];
    self.method = BXHRequestMethodPost;
}


@end
