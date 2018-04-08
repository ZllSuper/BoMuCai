//
//  WaresDetailAdCell.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/1/23.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "WaresDetailAdCell.h"

@implementation WaresDetailAdCell

+ (CGFloat)showHeight
{
    return DEF_SCREENWIDTH * (560 / 750.0);
}

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self addSubview:self.adView];
        [self.adView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self);
        }];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

#pragma mark - get
- (DTAdView *)adView
{
    if (!_adView)
    {
        _adView = [[DTAdView alloc] init];
        _adView.pageControlPosition = DTPageControlPosition_BottomCenter;
    }
    return _adView;
}
@end
