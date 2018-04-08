//
//  PCUploadHeaderImageRequest.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/21.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "BaseMainRequest.h"

@interface PCUploadHeaderImageRequest : BaseMainRequest

@property (nonatomic, copy) NSString *userId; //	用户Id

@property (nonatomic, copy) NSString *photo; //	图片base64

@end
