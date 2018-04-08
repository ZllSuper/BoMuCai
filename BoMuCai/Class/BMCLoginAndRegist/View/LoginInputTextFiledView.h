//
//  LoginInputTextFiledView.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/1/16.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LoginInputTextFiledView;

@protocol LoginInputTextFiledViewDelegate <NSObject>

- (BOOL)inputTextFiledErrorWithEndEditing:(LoginInputTextFiledView *)textFiled;

@end

@interface LoginInputTextFiledView : UIView <UITextFieldDelegate>

@property (nonatomic, strong) UITextField *inputTextFiled;

@property (nonatomic, strong) UILabel *errorTipLabel;

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, weak) id <LoginInputTextFiledViewDelegate>sourceDelegate;

@end
