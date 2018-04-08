//
//  PCAddressManagerViewController.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/9.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PCAddressModel.h"

@class PCAddressManagerViewController;
@protocol PCAddressManagerViewControllerDelegate <NSObject>

- (void)addressManager:(PCAddressManagerViewController *)vc addressModel:(PCAddressModel *)addressModel;

@end

@interface PCAddressManagerViewController : UIViewController

@property (nonatomic, weak) id <PCAddressManagerViewControllerDelegate>delegate;

@end
