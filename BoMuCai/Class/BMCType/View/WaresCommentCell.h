//
//  WaresCommentCell.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/1/23.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CWStarRateView.h"
#import "BMCWaresCommentModel.h"

@interface WaresCommentCell : UITableViewCell

@property (weak, nonatomic) IBOutlet CWStarRateView *rateView;

@property (weak, nonatomic) IBOutlet UIView *bottomLine;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UILabel *commentLabel;

@property (weak, nonatomic) BMCWaresCommentModel *weakModel;

+ (CGFloat)showHeight:(NSString *)commentText;

@end
