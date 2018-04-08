//
//  WaresCommentCell.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/1/23.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "WaresCommentCell.h"

@implementation WaresCommentCell

+ (CGFloat)showHeight:(NSString *)commentText
{
   CGSize size = [commentText size_With_Font:Font_sys_13 constrainedToSize:CGSizeMake(DEF_SCREENWIDTH - 32, MAXFLOAT)];
    return size.height + 50;
}

- (void)setWeakModel:(BMCWaresCommentModel *)weakModel
{
    _weakModel = weakModel;
    self.rateView.scorePercent = [weakModel.starLevel floatValue] / 5;
    self.commentLabel.text = weakModel.introduce;
    self.nameLabel.text = weakModel.nickName;
    self.timeLabel.text = weakModel.createTime;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
//    self.rateView.scorePercent = 0.8;
    self.rateView.userInteractionEnabled = NO;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
