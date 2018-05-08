//
//  CarCountCalculateView.h
//  BoMuCai
//
//  Created by liangliang.zhu on 2018/5/8.
//  Copyright © 2018年 woshishui. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CarCountCalculateViewBlock)(NSString *count);
@class CarGoodModel;

@interface CarCountCalculateView : UIView

@property (nonatomic, strong) UIView *alertView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIButton *addBtn;

@property (nonatomic, strong) UIButton *reduceBtn;

@property (nonatomic, strong) UITextField *countTextFiled;


@property (nonatomic, strong) UIButton *hideBtn;

@property (nonatomic, strong) UIButton *commitBtn;

@property (nonatomic, strong) UIButton *cancelBtn;

@property (nonatomic, copy) CarCountCalculateViewBlock completion;
@property (nonatomic, weak) CarGoodModel *carGoodModel;

+ (void)showWithCarGoodModel:(CarGoodModel *)carGoodModel completion:(CarCountCalculateViewBlock)completion;

@end
