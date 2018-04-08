//
//  BXHMyAlertView.h
//  ECar
//
//  Created by 步晓虎 on 15-1-8.
//  Copyright (c) 2015年 步晓虎. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BXHMyAlertView;

typedef void (^AlertViewActionHander) (BXHMyAlertView *alertView, NSInteger clickIndex);

@interface BXHMyAlertView : UIAlertView <UIAlertViewDelegate>

@property (nonatomic, copy) AlertViewActionHander actionHander;

- (instancetype) initWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...;

- (void)showWithActionHander:(AlertViewActionHander)hander;

@end
