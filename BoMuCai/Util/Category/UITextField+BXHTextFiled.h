//
//  UITextField+BXHTextFiled.h
//  HangZhouSchool
//
//  Created by 步晓虎 on 16/8/25.
//  Copyright © 2016年 步晓虎. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (BXHTextFiled)

@property (nonatomic, copy) NSString *valueKey;

- (NSRange) selectedRange;

- (void) setSelectedRange:(NSRange) range;

@end
