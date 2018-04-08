//
//  TenderHallDetailRequest.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/3/15.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "TenderHallDetailRequest.h"

@implementation TenderHallDetailRequest

- (NSDictionary *)bxhReplaceKeyFormPropertyNames
{
    return @{@"tenderHallId" : @"id"};
}


- (void)serializeHTTPRequest
{
    [super serializeHTTPRequest];
    self.relativeUrlString = KURL_TenderHallDetail;
    self.reuqestBody = [self bxhkeyValues];
    self.method = BXHRequestMethodPost;
}

@end
