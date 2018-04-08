//
//  STWXUserInfoRequest.m
//  STIntelligent
//
//  Created by 步晓虎 on 2017/8/4.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "STWXUserInfoRequest.h"

@implementation STWXUserInfoRequest

- (void)serializeHTTPRequest
{
    [super serializeHTTPRequest];
    NSDictionary *sourceDict = [self bxhkeyValues];
    self.relativeUrlString = [NSString stringWithFormat:@"/sns/userinfo?%@",[sourceDict httpBody]];;
    self.method = BXHRequestMethodGet;
}


@end
