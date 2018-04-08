//
//  BXHAddressContainerController.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/8.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BXHAddressContainerController;

@interface UIViewController(BXHAddressContainer)

@property (nonatomic, weak) BXHAddressContainerController *containerController;

@end

@interface BXHAddressContainerController : UIViewController

- (instancetype) initWithRootViewController:(UIViewController *)rootViewController;

- (void)showWithAnimate;

- (void)hiddenWithAnimte;

@end
