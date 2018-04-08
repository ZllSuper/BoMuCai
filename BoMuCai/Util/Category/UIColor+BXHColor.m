//
//  UIColor+BXHColor.m
//  ECar
//
//  Created by 步晓虎 on 14-12-15.
//  Copyright (c) 2014年 步晓虎. All rights reserved.
//

#import "UIColor+BXHColor.h"

@implementation UIColor (BXHColor)

+ (UIColor *)getHexColorWithHexStr:(NSString *)hexStr
{
    unsigned int red,green,blue;
    NSRange range;
    range.length = 2;
    
    range.location = 1;
    [[NSScanner scannerWithString:[hexStr substringWithRange:range]] scanHexInt:&red];
    
    range.location = 3;
    [[NSScanner scannerWithString:[hexStr substringWithRange:range]] scanHexInt:&green];
    
    range.location = 5;
    [[NSScanner scannerWithString:[hexStr substringWithRange:range]] scanHexInt:&blue];
    
    return [UIColor colorWithRed:(float)(red/255.0f) green:(float)(green / 255.0f) blue:(float)(blue / 255.0f) alpha:1.0f];
}

+ (UIColor *)randomColor
{
    CGFloat hue = ( arc4random() % 256 / 256.0 ); //0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5; // 0.5 to 1.0,away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5; //0.5 to 1.0,away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}

@end
