//
//  BXHBasicAnimation.h
//  HangZhouSchool
//
//  Created by 步晓虎 on 16/5/23.
//  Copyright © 2016年 步晓虎. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface BXHBasicAnimation : CABasicAnimation

+(CABasicAnimation *)opacityForever_Animation:(float)time fromValue:(NSNumber *)fValue toValue:(NSNumber *)toValue;

+(CABasicAnimation *)moveX:(float)time X:(NSNumber *)x fromx:(NSNumber *)fx;

//纵向移动动画
+(CABasicAnimation *)moveY:(float)time Y:(NSNumber *)y fromY:(NSNumber *)fY;

//缩放动画
+(CABasicAnimation *)scale:(NSNumber *)Multiple orgin:(NSNumber *)orginMultiple durTimes:(float)time Rep:(float)repeatTimes;


//组合动画
+(CAAnimationGroup *)groupAnimation:(NSArray *)animationAry durTimes:(float)time Rep:(float)repeatTimes
;

@end
