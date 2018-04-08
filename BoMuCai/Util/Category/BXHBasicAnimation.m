//
//  BXHBasicAnimation.m
//  HangZhouSchool
//
//  Created by 步晓虎 on 16/5/23.
//  Copyright © 2016年 步晓虎. All rights reserved.
//

#import "BXHBasicAnimation.h"

@implementation BXHBasicAnimation


+(CABasicAnimation *)opacityForever_Animation:(float)time fromValue:(NSNumber *)fValue toValue:(NSNumber *)toValue

{
    
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"alpha"];
    
    animation.fromValue = fValue;
    
    animation.toValue = toValue;
    
    animation.autoreverses = NO;
    
    animation.duration=time;
    
    animation.repeatCount=FLT_MAX;
    
    animation.removedOnCompletion = YES;
    
    animation.fillMode = kCAFillModeRemoved;
    
    return animation;
    
}



+(CABasicAnimation *)opacityTimes_Animation:(float)repeatTimes durTimes:(float)time;

{
    
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"opacity"];
    
    animation.fromValue=[NSNumber numberWithFloat:1.0];
    
    animation.toValue=[NSNumber numberWithFloat:0.4];
    
    animation.repeatCount=repeatTimes;
    
    animation.duration=time;
    
    animation.removedOnCompletion = YES;
    
    animation.fillMode=kCAFillModeRemoved;
    
    animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    animation.autoreverses=YES;
    
    return  animation;
    
}



+(CABasicAnimation *)moveX:(float)time X:(NSNumber *)x fromx:(NSNumber *)fx
{
    
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
    
    animation.toValue=x;
    
    animation.fromValue=fx;
    
    animation.duration=time;
    
    animation.removedOnCompletion = YES;
    
    animation.fillMode=kCAFillModeRemoved;
    
    return animation;
}



+(CABasicAnimation *)moveY:(float)time Y:(NSNumber *)y fromY:(NSNumber *)fY

{
    
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    
    animation.toValue=y;
    
    animation.fromValue=fY;
    
    animation.duration=time;
    
    animation.removedOnCompletion = YES;
    
    animation.fillMode=kCAFillModeRemoved;
    
    return animation;
    
}



+(CABasicAnimation *)scale:(NSNumber *)Multiple orgin:(NSNumber *)orginMultiple durTimes:(float)time Rep:(float)repeatTimes

{
    
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"transform.scale"];
    
    animation.fromValue=orginMultiple;
    
    animation.toValue=Multiple;
    
    animation.duration=time;
    
    animation.autoreverses = YES;
    
    animation.repeatCount=repeatTimes;
    
    animation.removedOnCompletion = YES;
    
    animation.fillMode=kCAFillModeRemoved;
    
    return animation;
    
}



+(CAAnimationGroup *)groupAnimation:(NSArray *)animationAry durTimes:(float)time Rep:(float)repeatTimes
{
    
    CAAnimationGroup *animation=[CAAnimationGroup animation];
    
    animation.animations=animationAry;
    
    animation.duration=time;
    
    animation.repeatCount=repeatTimes;
    
    animation.removedOnCompletion = YES;
    
    animation.fillMode=kCAFillModeRemoved;
    
    return animation;
    
}



+(CAKeyframeAnimation *)keyframeAniamtion:(CGMutablePathRef)path durTimes:(float)time Rep:(float)repeatTimes

{
    
    CAKeyframeAnimation *animation=[CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    animation.path=path;
    
    animation.removedOnCompletion=NO;
    
    animation.fillMode=kCAFillModeForwards;
    
    animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    animation.autoreverses=NO;
    
    animation.duration=time;
    
    animation.repeatCount=repeatTimes;
    
    return animation;
    
}



+(CABasicAnimation *)movepoint:(CGPoint )point

{
    
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"transform.translation"];
    
    animation.toValue=[NSValue valueWithCGPoint:point];
    
    animation.removedOnCompletion=NO;
    
    animation.fillMode=kCAFillModeRemoved;
    
    return animation;
    
}



+(CABasicAnimation *)rotation:(float)dur degree:(float)degree direction:(int)direction repeatCount:(int)repeatCount

{
    
    CATransform3D rotationTransform  = CATransform3DMakeRotation(degree, 0, 0,direction);
    
    CABasicAnimation* animation;
    
    animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    
    
    
    animation.toValue= [NSValue valueWithCATransform3D:rotationTransform];
    
    animation.duration= dur;
    
    animation.autoreverses= NO;
    
    animation.cumulative= YES;
    
    animation.removedOnCompletion=NO;
    
    animation.fillMode=kCAFillModeRemoved;
    
    animation.repeatCount= repeatCount; 
    
    animation.delegate= self;
    
    
    
    return animation;
    
}

@end
