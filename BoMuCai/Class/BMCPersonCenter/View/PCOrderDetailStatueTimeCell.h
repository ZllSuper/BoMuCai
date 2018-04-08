//
//  PCOrderDetailStatueTimeCell.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/7.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TimeDownEnd)();

@interface PCOrderDetailStatueTimeCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *statueLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

- (void)startCountDown:(NSTimeInterval)time andTimeDownCallBack:(TimeDownEnd)callBack;

+ (CGFloat)cellHeight;

@end
