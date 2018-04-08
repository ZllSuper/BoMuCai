//
//  ActivityDetailViewController.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/1/19.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "ActivityDetailViewController.h"
#import "BMCWaresDetailViewController.h"

#import "ActivityListCollectionVIew.h"

@interface ActivityDetailViewController () <ActivityListCollectionVIewProtcol>

@property (nonatomic, strong) ActivityListCollectionVIew *collectionView;

@end

@implementation ActivityDetailViewController

- (instancetype)initWithActivityModel:(BMCActivityModel *)activityModel
{
    if (self = [super init])
    {
        self.collectionView.activityId = activityModel.activityId;
        self.collectionView.headerImage = activityModel.activityImageApp;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"活动详情";
    
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    
    [self.collectionView.mj_header beginRefreshing];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - protcol
- (void)collectionView:(ActivityListCollectionVIew *)collectionView indexPathAction:(NSIndexPath *)indexPath
{
    BMCWaresModel *waresModel = collectionView.sourceAry[indexPath.item];
    BMCWaresDetailViewController *vc = [[BMCWaresDetailViewController alloc] initWithWaresDetailId:waresModel.waresId];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - get
- (ActivityListCollectionVIew *)collectionView
{
    if (!_collectionView)
    {
        _collectionView = [[ActivityListCollectionVIew alloc] initWithFrame:CGRectZero collectionViewLayout:[UICollectionViewFlowLayout new]];
        _collectionView.protcol = self;
        
    }
    return _collectionView;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
