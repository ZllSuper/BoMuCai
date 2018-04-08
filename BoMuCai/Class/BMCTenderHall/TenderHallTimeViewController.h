//
//  TenderHallTimeViewController.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/3.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TenderHallTimeViewController;

@protocol TenderHallTimeViewControllerDelegate <NSObject>

- (void)timeChoose:(TenderHallTimeViewController *)viewController startTime:(NSString *)startTime endTime:(NSString *)endTime;

@end

@interface TenderHallTimeViewController : UIViewController

@property (nonatomic, weak) id <TenderHallTimeViewControllerDelegate>delegate;

@end
