//
//  UIMyDatePicker.h
//  OpenAllTheWay
//
//  Created by 步晓虎 on 14-10-30.
//  Copyright (c) 2014年 步晓虎. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,BXHMyPickerViewType)
{
    BXHMyPickerViewBottomType,
    BXHMyPickerViewMidType

};

@class UIMyDatePicker;

@protocol  UIMyDatePickerDelegate <NSObject>

- (void)myDatePicker:(UIMyDatePicker *)picker tapedCancel:(BOOL)cancel;

@end

@interface UIMyDatePicker : UIView

@property (nonatomic, strong) UIDatePicker *datePicker;

@property (nonatomic, weak) id <UIMyDatePickerDelegate>delegate;

@property (nonatomic, assign) BXHMyPickerViewType type;

@property (nonatomic, weak) UIView *actionView;

- (instancetype) initWithDelegate:(id <UIMyDatePickerDelegate>)delegate andType:(BXHMyPickerViewType)pickerType;

- (void)showDatePickerView;

- (void)cancelDatePickerView;

@end
