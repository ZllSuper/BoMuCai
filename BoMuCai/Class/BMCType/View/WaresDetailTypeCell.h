//
//  WaresDetailTypeCell.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/14.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WaresTypeModel.h"

@interface WaresDetailTypeCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIView *backGroundView;

@property (nonatomic, weak) WaresTypeModel *weakModel;

+ (CGSize)cellSizeWithShowText:(NSString *)text;

@end
