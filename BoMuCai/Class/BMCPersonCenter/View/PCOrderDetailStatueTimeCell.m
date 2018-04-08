//
//  PCOrderDetailStatueTimeCell.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/7.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "PCOrderDetailStatueTimeCell.h"

@interface PCOrderDetailStatueTimeCell()

@property (nonatomic, strong) dispatch_source_t timer;

@property (nonatomic, copy) TimeDownEnd callBack;

@end

@implementation PCOrderDetailStatueTimeCell

+ (CGFloat)cellHeight
{
    return 66;
}


- (void)dealloc
{
    if (self.timer)
    {
        dispatch_source_cancel(self.timer);
        self.timer = nil;
    }
}


- (void)startCountDown:(NSTimeInterval)time andTimeDownCallBack:(TimeDownEnd)callBack
{
    self.callBack = callBack;
    __block NSInteger organlTime = time;
    __weak typeof(self) weakSelf = self;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(self.timer, dispatch_walltime(nil, 0), NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(self.timer, ^{
        BXHLog(@"timedown =========================================");
        if (organlTime <= 0)
        {
            if (weakSelf != nil)
            {
                dispatch_source_cancel(weakSelf.timer);
                weakSelf.timer = nil;
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    weakSelf.timeLabel.text = [NSString stringWithFormat:@"剩余%02d天%02d小时自动确认",0,0];
                });
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                if (weakSelf.callBack)
                {
                    weakSelf.callBack();
                }
            });
        }
        else
        {
            long dayUnit = 60 * 60 * 24;
            long hourUnit = 60 * 60;
            long mintUnit = 60;
            
            long day = organlTime / dayUnit;
            long daySurplus = organlTime % dayUnit;
            long hour = daySurplus / hourUnit;
            long hourSurplus = daySurplus % hourUnit;
            long mint = hourSurplus / mintUnit;
            long seconds = hourSurplus % mintUnit;
            dispatch_async(dispatch_get_main_queue(), ^{
                if (day > 0)
                {
                    weakSelf.timeLabel.text = [NSString stringWithFormat:@"剩余%02ld天%02ld小时自动确认",day,hour];
                }
                else if(hour > 0)
                {
                    weakSelf.timeLabel.text = [NSString stringWithFormat:@"剩余%02ld小时时%02ld分自动确认",hour,mint];
                }
                else
                {
                    weakSelf.timeLabel.text = [NSString stringWithFormat:@"剩余%02ld分%02ld秒自动确认",mint,seconds];
                }
                
            });
            organlTime--;
        }
    });
    dispatch_resume(self.timer);
}

- (void)stopCountDown
{
    if (self.timer)
    {
        dispatch_source_cancel(self.timer);
        self.timer = nil;
    }
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
