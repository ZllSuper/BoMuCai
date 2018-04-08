//
//  PCFeedBackTextView.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/13.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YMTextView.h"

@interface PCFeedBackTextView : UIView <UITextViewDelegate>

@property (nonatomic, strong) YMTextView *textView;

@property (nonatomic, strong) UILabel *textNumLabel;


@end
