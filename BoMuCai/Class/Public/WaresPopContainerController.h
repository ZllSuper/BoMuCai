//
//  WaresPopContainerController.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/1/25.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WaresPopContainerController;

@protocol WaresPopContainerControllerProtcol <NSObject>

- (void)containerController:(WaresPopContainerController *)containerController willDismissViewController:(UIViewController *)controller;

@end


@interface UIViewController(WaresPopContainer)

@property (nonatomic, weak) WaresPopContainerController *containerController;

@end

@interface WaresPopContainerController : UIViewController

@property (nonatomic, weak) id <WaresPopContainerControllerProtcol>protcol;

- (instancetype) initWithRootViewController:(UIViewController *)rootViewController;

- (void)showFromViewController:(UIViewController *)fromController;

- (void)hiddenWithAnimate;

@end
