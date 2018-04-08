//
//  UIColor+BXHColor.h
//  ECar
//
//  Created by 步晓虎 on 14-12-15.
//  Copyright (c) 2014年 步晓虎. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (BXHColor)

+ (UIColor *)getHexColorWithHexStr:(NSString *)hexStr;

+ (UIColor *)randomColor;

@end

