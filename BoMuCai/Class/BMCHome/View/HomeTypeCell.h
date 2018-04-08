//
//  HomeTypeCell.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/1/17.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMCTypeModel.h"

@class HomeTypeCell;

@protocol HomeTypeCellDelegate <NSObject>

- (void)typeCellBtnAction:(HomeTypeCell *)typeCell actionAtIndex:(NSInteger)index;

@end

@interface HomeTypeCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *moreBtn;

@property (weak, nonatomic) IBOutlet UILabel *oneTypeLabel;

@property (weak, nonatomic) IBOutlet UIImageView *oneTypeImage;

@property (weak, nonatomic) IBOutlet UILabel *twoTypeLabel;

@property (weak, nonatomic) IBOutlet UIImageView *twoTypeImage;

@property (weak, nonatomic) IBOutlet UILabel *threeTypeLabel;

@property (weak, nonatomic) IBOutlet UIImageView *threeTypeImage;

@property (weak, nonatomic) id <HomeTypeCellDelegate>delegate;

@property (nonatomic, strong) NSArray *typeAry;

@end
