//
//  StartLoadRequest.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/4/28.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "StartLoadRequest.h"

@implementation StartLoadRequest

- (instancetype)init
{
    if (self = [super init])
    {
        self.cachePolicy = BXHRequestReturnCacheDataElseReloadRemoteData;
        self.cacheTime = 60 * 60 * 24;
    }
    return self;
}

- (void)serializeHTTPRequest
{
    [super serializeHTTPRequest];
    self.relativeUrlString = KURL_StartLoadImage;
    self.reuqestBody = [self bxhkeyValues];
    self.method = BXHRequestMethodPost;
}

@end
