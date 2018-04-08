//
//  BXHWebProgress.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/17.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface BXHWebProgress : CAShapeLayer

- (void)finishedLoad;

- (void)startLoad;

- (void)closeTimer;

@end
