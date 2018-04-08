//
//  NSString+BXHMyString.h
//  TestMessage
//
//  Created by 步晓虎 on 14-9-4.
//  Copyright (c) 2014年 步晓虎. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface NSString (BXHMyString)

NSString * StringFilterNull(id orgStr);

+ (NSString *)generateUuidString;

- (NSString *)urlEncoded;

- (NSString *)md5Hash;

- (NSString *)sha1Hash;

- (NSDictionary*)queryContentsUsingEncoding:(NSStringEncoding)encoding;

- (NSString*)stringByAddingQueryDictionary:(NSDictionary*)query;

- (NSString*)stringByAddingURLEncodedQueryDictionary:(NSDictionary*)query;

- (NSString*)stringByRemovingHTMLTags;

- (NSAttributedString *)attributStrWithTargetStr:(NSString *)str color:(UIColor *)color;

- (NSAttributedString *)attributStrWithTargetStr:(NSString *)str targetColor:(UIColor *)color originalColor:(UIColor *)originalColor;

- (NSAttributedString *)attributStrWithTargetStr:(NSString *)str attribuDict:(NSDictionary *)dict;

- (NSString *)utf8ReplaceEncode;

- (NSString *)unicode;

/**
 *  Font
 */

- (CGSize) size_With_Font:(UIFont *)font;

- (CGSize) size_With_Font:(UIFont *)font constrainedToSize:(CGSize)size;

- (CGSize) size_With_Font:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode;

+ (BOOL)stringIsEmpty:(NSString *)sourceStr;

- (NSString *)checkNilStr;

+ (NSString *)checkNilStrWithStr:(NSString *)sourceStr;

- (id)jsonObject;

- (NSString *)formatCardNumber;

- (NSArray *)rangesOfFindText:(NSString *)searchText;

NSString * CheckString(NSString *str);

BOOL StringIsEmpty(NSString *str);

NSString * MoneyDeal(NSString *str);

@end
