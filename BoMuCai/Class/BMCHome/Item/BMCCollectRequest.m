//
//  BMCCollectRequest.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/20.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "BMCCollectRequest.h"

@implementation BMCCollectRequest

- (NSDictionary *)bxhReplaceKeyFormPropertyNames
{
    return @{@"collectId" : @"id", @"collectStu" : @"status"};
}

- (void)serializeHTTPRequest
{
    [super serializeHTTPRequest];
    self.relativeUrlString = KURL_Collect;
    self.reuqestBody = [self bxhkeyValues];
    self.method = BXHRequestMethodPost;
}


@end
