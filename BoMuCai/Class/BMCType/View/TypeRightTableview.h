//
//  TypeRightTableview.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/1/19.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "BaseTableView.h"
#import "TypeRightCell.h"
#import "TypeRightSectionHeaderView.h"
#import "BMCTypeModel.h"

@class TypeRightTableview;

@protocol TypeRightTableviewDelegate <NSObject>

- (void)tableView:(TypeRightTableview *)tableView itemAction:(BMCTypeModel *)model;

@end

@interface TypeRightTableview : BaseTableView <TypeRightCellDelegate>

@property (nonatomic, strong) UIImageView *headerImageView;

@property (nonatomic, weak) id <TypeRightTableviewDelegate>actionDelegate;

@end
