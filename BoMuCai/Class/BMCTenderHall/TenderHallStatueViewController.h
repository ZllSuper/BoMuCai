//
//  TenderHallStatueViewController.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/3.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TenderHallStatueViewController;

@protocol TenderHallStatueViewControllerDelegate <NSObject>

- (void)statueVC:(TenderHallStatueViewController *)vc statueChoose:(NSDictionary *)statue;

@end

@interface TenderHallStatueViewController : UIViewController

@property (nonatomic, weak) id <TenderHallStatueViewControllerDelegate>delegate;

@end
