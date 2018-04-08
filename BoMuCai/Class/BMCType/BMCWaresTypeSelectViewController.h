//
//  BMCWaresTypeSelectViewController.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/3.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMCWaresDetailModel.h"

@class BMCWaresTypeSelectViewController;

@protocol BMCWaresTypeSelectViewControllerDelegate <NSObject>

- (void)selectViewControllerAddToCart:(BMCWaresTypeSelectViewController *)viewController;

- (void)selectViewControllerBuyNow:(BMCWaresTypeSelectViewController *)viewController;

@end

@interface BMCWaresTypeSelectViewController : UIViewController

@property (nonatomic, weak) id <BMCWaresTypeSelectViewControllerDelegate>delegate;

- (instancetype) initWithWaresDetailModel:(BMCWaresDetailModel *)detailModel;

@end
