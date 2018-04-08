//
//  RegistInputTextFiled.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/1/16.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RegistInputTextFiled;

@protocol RegistInputTextFiledDelegate <NSObject>

- (void)textFiledDidEndEditing:(RegistInputTextFiled *)textFiled;

@end

@interface RegistInputTextFiled : UIView<UITextFieldDelegate>

@property (nonatomic, strong) UITextField *inputTextFiled;

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, weak) id <RegistInputTextFiledDelegate>delegate;

@end
