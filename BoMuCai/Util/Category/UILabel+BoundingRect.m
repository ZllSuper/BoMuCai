//
//  UILabel+BoundingRect.m
//  HangZhouSchool
//
//  Created by 陈栋 on 16/8/14.
//  Copyright © 2016年 步晓虎. All rights reserved.
//

#import "UILabel+BoundingRect.h"

@implementation UILabel (BoundingRect)


-(CGRect)boundingRectWithIninSize:(CGSize)size
{
    self.lineBreakMode = NSLineBreakByWordWrapping;
    
    CGRect rect = [self.text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:self.font,NSFontAttributeName, nil] context:nil];
    return rect;
}

@end
