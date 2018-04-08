//
//  BXHAlertViewController.h
//  GuoGangTong
//
//  Created by 步晓虎 on 2016/11/23.
//  Copyright © 2016年 woshishui. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,BXHAlertType)
{
    BXHAlertMessageType,
    BXHALertContentView
};

@interface BXHAlertAction : NSObject

+ (instancetype)actionWithTitle:(NSString *)title titleColor:(UIColor *)titleColor handler:(void (^)(BXHAlertAction *action))handler;

@property (nonatomic, readonly) NSString *title;

@property (nonatomic, readonly, strong) UIColor *titleColor;

@end

@interface BXHAlertViewController : UIViewController

@property (nonatomic, readonly) NSArray<BXHAlertAction *> *actions;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign) BXHAlertType alertType;

@property (nonatomic, strong) UIView *sourceView; //内容显示View

@property (nonatomic, copy) NSString *message;

@property (nonatomic, copy) NSAttributedString *attributeStr;

@property (nonatomic, assign) NSTextAlignment messageAlignment;

+ (instancetype)alertControllerWithTitle:(NSString *)title type:(BXHAlertType)type;

- (void)addAction:(BXHAlertAction *)action;


@end
