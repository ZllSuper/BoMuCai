//
//  UIImageView+AddActionExtend.m
//  HangZhouSchool
//
//  Created by 步晓虎 on 16/2/17.
//  Copyright © 2016年 步晓虎. All rights reserved.
//

#import "UIImageView+AddActionExtend.h"

@implementation UIImageView (AddActionExtend)

- (void)addActionWithTarget:(id)target andSelector:(SEL)sel
{
    self.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:target action:sel];
    [self addGestureRecognizer:tap];
}

@end
