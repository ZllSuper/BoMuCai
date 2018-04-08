//
//  TypeLeftTableView.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/1/19.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "BaseTableView.h"
#import "TypeLeftViewCell.h"
#import "BMCTypeModel.h"

@class TypeLeftTableView;
@protocol TypeLeftTableViewProtcol <NSObject>

- (void)tableView:(TypeLeftTableView *)tableView selectIndexPath:(NSIndexPath *)indexPath;

@end

@interface TypeLeftTableView : UITableView <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *sourceAry;

@property (nonatomic, weak) id <TypeLeftTableViewProtcol>protcol;

@end
