//
//  PCAccountRowSelViewController.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/8.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PCAccountEditProtcol.h"
#import "PCAccountModel.h"

@interface PCAccountRowSelViewController : UIViewController

@property (nonatomic, weak) id <PCAccountEditProtcol>delegate;

- (instancetype)initWithTitle:(NSString *)title accountModel:(PCAccountModel *)model propertyName:(NSString *)properTyName andSelectSourceAry:(NSArray *)sourceAry;

@end
