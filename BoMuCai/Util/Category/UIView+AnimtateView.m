//
//  UIView+AnimtateView.m
//  HangZhouSchool
//
//  Created by 步晓虎 on 16/6/3.
//  Copyright © 2016年 步晓虎. All rights reserved.
//

#import "UIView+AnimtateView.h"
#import <objc/runtime.h>

@implementation UIView (AnimtateView)

static char RemoveFromSuperViewKey;

- (void)setNeedRemoveFromSuperView:(BOOL)needRemoveFromSuperView
{
    objc_setAssociatedObject(self, &RemoveFromSuperViewKey, [NSNumber numberWithBool:needRemoveFromSuperView], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)needRemoveFromSuperView
{
    return [objc_getAssociatedObject(self, &RemoveFromSuperViewKey) boolValue];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (flag && self.needRemoveFromSuperView)
    {
        [self removeFromSuperview];
    }
}

+ (void)shakeViewHorizontal:(UIView*)viewToShake
{
    CGFloat t =2.0;
    //左右抖动效果
    CGAffineTransform translateRight  =CGAffineTransformTranslate(CGAffineTransformIdentity, t,0.0);
    CGAffineTransform translateLeft =CGAffineTransformTranslate(CGAffineTransformIdentity,-t,0.0);
    
    viewToShake.transform = translateLeft;
    
    [UIView animateWithDuration:0.07 delay:0.0 options:UIViewAnimationOptionAutoreverse|UIViewAnimationOptionRepeat animations:^{
        [UIView setAnimationRepeatCount:2.0];
        viewToShake.transform = translateRight;
    } completion:^(BOOL finished){
        if(finished){
            [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                viewToShake.transform =CGAffineTransformIdentity;
            } completion:NULL];
        }
    }];
}

@end
