//
//  UIView+AnimtateView.h
//  HangZhouSchool
//
//  Created by 步晓虎 on 16/6/3.
//  Copyright © 2016年 步晓虎. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (AnimtateView)

@property (nonatomic, assign) BOOL needRemoveFromSuperView;

+ (void)shakeViewHorizontal:(UIView*)viewToShake;

@end
