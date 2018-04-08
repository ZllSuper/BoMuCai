//
//  ActivityListCollectionVIew.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/1/19.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivityHeaderView.h"
#import "ActivityListCell.h"
#import "ActivityDetailRequest.h"
#import "ActivityDetailTimeRequest.h"

@class ActivityListCollectionVIew;
@protocol ActivityListCollectionVIewProtcol <NSObject>

- (void)collectionView:(ActivityListCollectionVIew *)collectionView indexPathAction:(NSIndexPath *)indexPath;

@end

@interface ActivityListCollectionVIew : UICollectionView <UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSMutableArray *sourceAry;

@property (nonatomic, copy) NSString *activityId;

@property (nonatomic, copy) NSString *headerImage;

@property (nonatomic, strong) BXHRequestContainer *container;

@property (nonatomic, weak) id <ActivityListCollectionVIewProtcol>protcol;


- (void)requestViewSource:(BOOL)refresh;

@end
