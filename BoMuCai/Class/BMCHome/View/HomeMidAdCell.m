//
//  HomeMidAdCell.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/1/17.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "HomeMidAdCell.h"

@implementation HomeMidAdCell

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
- (void)setAdModelList:(NSArray *)adModelList
{
    _adModelList = adModelList;
    
    NSMutableArray *urlAry = [NSMutableArray array];
    for (HomeAdModel *model in adModelList)
    {
        [urlAry addObject:model.image];
    }
    
    self.adView.adDataArray = urlAry;
    [self.adView loadAdDataThenStart];
    
}

- (DTAdView *)adView
{
    if (!_adView)
    {
        _adView = [[DTAdView alloc] init];
        _adView.pageControlPosition = DTPageControlPosition_BottomRight;
    }
    return _adView;
}

@end
