//
//  PopContainerController.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/1/19.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PopContainerController;

@interface UIViewController(PopContainer)

@property (nonatomic, weak) PopContainerController *containerController;

@end

@interface PopContainerController : UIViewController

- (instancetype) initWithRootViewContorller:(UIViewController *)rootController;

- (void)dismissAnimate;

@end
