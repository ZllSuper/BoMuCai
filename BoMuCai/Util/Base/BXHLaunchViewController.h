//
//  BXHLaunchViewController.h
//  GuoGangTong
//
//  Created by 步晓虎 on 2016/12/21.
//  Copyright © 2016年 woshishui. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BXHLaunchViewController;

@protocol BXHLaunchViewControllerDelegate <NSObject>

- (void)bxhLaunchViewControllerWillDismiss:(BXHLaunchViewController *)vc;

- (void)bxhLaunchViewControllerDidDismiss:(BXHLaunchViewController *)vc;

@end

@interface BXHLaunchViewController : UIViewController

@property (nonatomic, weak) id <BXHLaunchViewControllerDelegate>delegate;

- (void)show;

@end
