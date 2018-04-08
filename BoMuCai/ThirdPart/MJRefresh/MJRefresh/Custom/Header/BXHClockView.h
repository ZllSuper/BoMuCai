//
//  BXHClockView.h
//  TryLayout
//
//  Created by 步晓虎 on 2017/2/10.
//  Copyright © 2017年 金人网络. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BXHClockView : UIView


@property (nonatomic, assign) CGFloat progress; // 0~1;

- (void)startAnimate;

- (void)endAnimate;

@end
