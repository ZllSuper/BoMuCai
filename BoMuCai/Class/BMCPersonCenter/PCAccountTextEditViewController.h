//
//  PCAccountTextEditViewController.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/8.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PCAccountEditProtcol.h"
#import "PCAccountModel.h"

typedef BOOL (^ValidEnterText)(NSString *confirmText);

@interface PCAccountTextEditViewController : UIViewController

@property (nonatomic, weak) id <PCAccountEditProtcol>delegate;

- (instancetype)initWithTitle:(NSString *)title accountModel:(PCAccountModel *)model propertyName:(NSString *)properTyName;


- (void)validEnterText:(ValidEnterText)valid;

@end
