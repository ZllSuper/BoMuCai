//
//  PCUploadHeaderImageRequest.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/21.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "PCUploadHeaderImageRequest.h"

@implementation PCUploadHeaderImageRequest

- (NSDictionary *)bxhReplaceKeyFormPropertyNames
{
    return @{@"userId" : @"id"};
}

- (void)serializeHTTPRequest
{
    [super serializeHTTPRequest];
    self.relativeUrlString = KURL_UploadUserImage;
    self.reuqestBody = [self bxhkeyValues];
    self.method = BXHRequestMethodPost;
}


@end
