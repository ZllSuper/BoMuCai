//
//  STWXTokenGetRequest.m
//  STIntelligent
//
//  Created by 步晓虎 on 2017/7/5.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "STWXTokenGetRequest.h"


@implementation STWXTokenGetRequest


- (void)serializeHTTPRequest
{
    [super serializeHTTPRequest];
    NSDictionary *sourceDict = [self bxhkeyValues];
    self.relativeUrlString = [NSString stringWithFormat:@"/sns/oauth2/access_token?%@",[sourceDict httpBody]];;
    self.method = BXHRequestMethodGet;
}


@end
