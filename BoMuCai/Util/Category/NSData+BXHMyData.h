//
//  NSData+BXHMyData.h
//  TestMessage
//
//  Created by 步晓虎 on 14-9-29.
//  Copyright (c) 2014年 步晓虎. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (BXHMyData)

@property (nonatomic, readonly) NSString *md5Hash;

@property (nonatomic, readonly) NSString* sha1Hash;

- (id)jsonObject;

+ (id)dataWithBase64EncodedString:(NSString *)string;

- (NSString *)base64Encoding;

//加密
- (NSData *)AES256EncryptWithKey:(NSString *)key;

//解密
- (NSData *)AES256DecryptWithKey:(NSString *)key;
@end
