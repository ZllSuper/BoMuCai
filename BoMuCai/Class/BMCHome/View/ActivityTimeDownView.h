//
//  ActivityTimeDownView.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/1/19.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivityTimeDownView : UIView

@property (weak, nonatomic) IBOutlet UILabel *dayLabel;

@property (weak, nonatomic) IBOutlet UILabel *hourLabel;

@property (weak, nonatomic) IBOutlet UILabel *mintLabel;

@property (assign, nonatomic) BOOL endTime;

- (void)startCountDown:(NSTimeInterval)time;

- (void)stopCountDown;

@end
