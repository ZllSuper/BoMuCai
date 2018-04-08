//
//  UITextField+BXHTextFiled.m
//  HangZhouSchool
//
//  Created by 步晓虎 on 16/8/25.
//  Copyright © 2016年 步晓虎. All rights reserved.
//

#import "UITextField+BXHTextFiled.h"

@implementation UITextField (BXHTextFiled)

static char ValueKeyStr;

- (NSRange) selectedRange
{
    UITextPosition* beginning = self.beginningOfDocument;
    UITextRange* selectedRange = self.selectedTextRange;
    UITextPosition* selectionStart = selectedRange.start;
    UITextPosition* selectionEnd = selectedRange.end;
    const NSInteger location = [self offsetFromPosition:beginning toPosition:selectionStart];
    const NSInteger length = [self offsetFromPosition:selectionStart toPosition:selectionEnd];
    return NSMakeRange(location, length);
}

- (void) setSelectedRange:(NSRange) range
{
    UITextPosition* beginning = self.beginningOfDocument;
    UITextPosition* startPosition = [self positionFromPosition:beginning offset:range.location];
    UITextPosition* endPosition = [self positionFromPosition:beginning offset:range.location + range.length];
    UITextRange* selectionRange = [self textRangeFromPosition:startPosition toPosition:endPosition];
    [self setSelectedTextRange:selectionRange];
}

- (void)setValueKey:(NSString *)valueKey
{
    objc_setAssociatedObject(self, &ValueKeyStr, valueKey, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)valueKey
{
    return objc_getAssociatedObject(self, &ValueKeyStr);
}

@end
