//
//  BXHAuthBtn.h
//  HangZhouSchool
//
//  Created by 步晓虎 on 16/2/26.
//  Copyright © 2016年 步晓虎. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BXHAuthBtn : UIButton

- (void)startVerify:(NSInteger)time;

- (void)startCountDown:(NSTimeInterval)time withNormalText:(NSString *)normalText;

- (void)stopCountDown;

@end
