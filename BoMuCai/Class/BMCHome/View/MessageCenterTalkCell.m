//
//  MessageCenterTalkCell.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/1/17.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "MessageCenterTalkCell.h"

@implementation MessageCenterTalkCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.request = [[ShopNameHeadRequest alloc] init];
    
        [self.contentView addSubview:self.headerImageView];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.subTitleLabel];
        
        self.badgeView.badgeText = nil;
        
        [self.headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(60, 60));
            make.centerY.mas_equalTo(self.contentView);
            make.left.mas_equalTo(self.contentView).offset(16);
        }];
        
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.headerImageView.mas_centerY).offset(-2);
            make.left.mas_equalTo(self.headerImageView.mas_right).offset(15);
            make.right.mas_equalTo(self.contentView).offset(-16);
        }];
        
        [self.subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.headerImageView.mas_centerY).offset(2);
            make.left.mas_equalTo(self.nameLabel);
            make.right.mas_equalTo(self.contentView).offset(-16);
        }];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)requestWithConversationModel:(EaseConversationModel *)model;
{
    BXHBlockObj(model);
    [self.request cancel];
    BXHWeakObj(self);
    self.request.shopId = model.conversation.conversationId;
    [self.request requestWithSuccess:^( BXHBaseRequest *request) {
        if ([request.response.code isEqualToString:@"0000"])
        {
            modelblock.title = request.response.data[@"name"];
            selfWeak.nameLabel.text = request.response.data[@"name"];
            [selfWeak.headerImageView sd_setImageWithURL:[NSURL encodeURLWithString:request.response.data[@"image"]] placeholderImage:ImagePlaceHolder];
        }
        
    } failure:^(NSError *error, BXHBaseRequest *request) {
        
    }];
}

#pragma mark - get
- (BXHCornerRadiusImageView *)headerImageView
{
    if (!_headerImageView)
    {
        _headerImageView = [[BXHCornerRadiusImageView alloc] init];
        _headerImageView.cornerRadius = 30;
        _headerImageView.image = ImagePlaceHolder;
        _headerImageView.layer.cornerRadius = 30;
        _headerImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _headerImageView;
}

- (JSBadgeView *)badgeView
{
    if (!_badgeView)
    {
        _badgeView = [[JSBadgeView alloc] initWithParentView:self.headerImageView alignment:JSBadgeViewAlignmentTopRight];
        _badgeView.badgePositionAdjustment = CGPointMake(-2, 5);
        //1、背景色
        _badgeView.badgeBackgroundColor = [UIColor redColor];
        //2、没有反光面
        _badgeView.badgeOverlayColor = [UIColor clearColor];
        //3、外圈的颜色，默认是白色
        _badgeView.badgeStrokeColor = [UIColor redColor];
    }
    return _badgeView;
}

- (UILabel *)nameLabel
{
    if (!_nameLabel)
    {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = Font_sys_14;
        _nameLabel.textColor = Color_MainText;
    }
    return _nameLabel;
}

- (UILabel *)subTitleLabel
{
    if (!_subTitleLabel)
    {
        _subTitleLabel = [[UILabel alloc] init];
        _subTitleLabel.textColor = Color_Text_LightGray;
        _subTitleLabel.font = Font_sys_12;
    }
    return _subTitleLabel;
}

@end
