//
//  UILabel+BoundingRect.h
//  HangZhouSchool
//
//  Created by 陈栋 on 16/8/14.
//  Copyright © 2016年 步晓虎. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (BoundingRect)

//初始化的size,高度或者宽度为0
-(CGRect)boundingRectWithIninSize:(CGSize)size;

@end
