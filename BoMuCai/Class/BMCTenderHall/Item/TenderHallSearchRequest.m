//
//  TenderHallSearchRequest.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/21.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "TenderHallSearchRequest.h"

@implementation TenderHallSearchRequest

- (void)serializeHTTPRequest
{
    [super serializeHTTPRequest];
    self.relativeUrlString = KURL_TenderHallSearch;
    self.reuqestBody = [self bxhkeyValues];
    self.method = BXHRequestMethodPost;
}

@end