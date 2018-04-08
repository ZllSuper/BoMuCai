//
//  TypeRightCell.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/1/19.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMCTypeModel.h"

@class TypeRightCell;

@protocol TypeRightCellDelegate <NSObject>

- (void)cell:(TypeRightCell *)cell itemTouchAction:(BMCTypeModel *)model;

@end

@interface TypeRightCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageViewOne;

@property (weak, nonatomic) IBOutlet UIImageView *imageViewTwo;

@property (weak, nonatomic) IBOutlet UILabel *titleLabelOne;

@property (weak, nonatomic) IBOutlet UILabel *titleLabelTwo;

@property (weak, nonatomic) id <TypeRightCellDelegate>delegate;

@property (nonatomic, weak) BMCTypeModel *leftModel;

@property (nonatomic, weak) BMCTypeModel *rightModel;

+ (CGFloat)cellHeight;

@end
