//
//  SearchCollectionCell.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/1/18.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchModel.h"

@interface SearchCollectionCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIView *backGroundView;

@property (nonatomic, weak) SearchModel *weakModel;

+ (CGSize)cellSizeWithShowText:(NSString *)text;

@end
