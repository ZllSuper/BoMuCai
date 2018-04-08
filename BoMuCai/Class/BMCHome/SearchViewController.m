//
//  SearchViewController.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/1/18.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "SearchViewController.h"

#import "SearchNavBar.h"
#import "SUPopupMenu.h"
#import "SearchCollectionReusableView.h"
#import "SearchCollectionFlowLayout.h"
#import "SearchCollectionCell.h"

#import "SearchModel.h"

#import "HotSearchRequest.h"

#define HistorySearch @"HistorySearch"

@interface SearchViewController () <UICollectionViewDelegate, UICollectionViewDataSource, SearchNavBarDelegate,SUDropMenuDelegate>

@property (nonatomic, strong) UICollectionView *searchCollectionView;

@property (nonatomic, strong) SearchNavBar *navBar;

@property (nonatomic, strong) NSMutableArray *sectionAry;

@property (nonatomic, strong) UIButton *clearBtn;

@property (nonatomic, strong) MASConstraint *btnBottom;

@property (nonatomic, strong) SUPopupMenu *popupView;

@end

@implementation SearchViewController

- (instancetype)init
{
    if (self = [super init])
    {
        self.modalPresentationStyle = UIModalPresentationCustom;
        self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = Color_White;
    
    [self prepareData];
    
    [self.view addSubview:self.navBar];
    [self.view addSubview:self.searchCollectionView];
    [self.view addSubview:self.clearBtn];
    
    [self.navBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view);
        make.left.and.right.mas_equalTo(self.view);
        make.height.mas_equalTo(@64);
    }];
    
    [self.searchCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.navBar.mas_bottom).offset(10);
        make.left.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
    }];
    
    [self.clearBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(16);
        make.right.mas_equalTo(self.view).offset(-16);
        self.btnBottom = make.bottom.mas_equalTo(self.view).offset(-20);
        make.height.mas_equalTo(@45);
        make.top.mas_equalTo(self.searchCollectionView.mas_bottom);
    }];
    
    [self hotSearchRequest];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHidden:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.navBar.searchTextField becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)prepareData
{
    self.sectionAry = [NSMutableArray array];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)keyBoardWillShow:(NSNotification *)notification
{
    NSDictionary *userInfo = notification.userInfo;
    CGFloat durition = [userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    CGRect keyBoardFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    [UIView animateWithDuration:durition animations:^{
        self.btnBottom.offset = -(CGRectGetHeight(keyBoardFrame) + 40);
        [self.view layoutIfNeeded];
    }];
}

- (void)keyBoardWillHidden:(NSNotification *)notification
{
    NSDictionary *userInfo = notification.userInfo;
    CGFloat durition = [userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    [UIView animateWithDuration:durition animations:^{
        self.btnBottom.offset = -20;
        [self.view layoutIfNeeded];
    }];
}

#pragma mark - request
- (void)hotSearchRequest
{
    __weak typeof(self) weakSelf = self;
    HotSearchRequest *request = [[HotSearchRequest alloc] init];
    ProgressShow(self.view);
    [request requestWithSuccess:^( BXHBaseRequest *request) {
        ProgressHidden(weakSelf.view);
        if ([request.response.code isEqualToString:@"0000"])
        {
            
            [weakSelf.sectionAry addObject:[SearchModel bxhObjectArrayWithKeyValuesArray:request.response.data]];
            NSString *jsonStr = [[NSUserDefaults standardUserDefaults] objectForKey:HistorySearch];
            if (!StringIsEmpty(jsonStr))
            {
                NSArray *jsonAry = [jsonStr jsonObject];
                [weakSelf.sectionAry addObject:[SearchModel bxhObjectArrayWithKeyValuesArray:jsonAry]];
            }
            [weakSelf.searchCollectionView reloadData];
        }
        else
        {
            ToastShowBottom(request.response.message);
        }
        
    } failure:^(NSError *error, BXHBaseRequest *request) {
        ProgressHidden(weakSelf.view);
        ToastShowBottom(NetWorkErrorTip);
    }];
}

#pragma mark - action
- (void)cancelBtnAction
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)clearBtnAction
{
    if (self.sectionAry && self.sectionAry.count > 1)
    {
        [self.sectionAry removeLastObject];
        [[NSUserDefaults standardUserDefaults] setValue:nil forKey:HistorySearch];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self.searchCollectionView reloadData];
    }
}

#pragma mark - popViewDelegate
- (void)dropMenuDidTappedAtIndex:(NSInteger)index
{
    if (index == 0)
    {
        self.navBar.type = @"商品";
    }
    else
    {
        self.navBar.type = @"店铺";
    }
}

#pragma mark - navBarDelegate
- (void)navbarSearchAction:(SearchNavBar *)navbar
{
    NSMutableArray *historyAry = nil;
    if (self.sectionAry.count > 1)
    {
        historyAry = self.sectionAry[1];
    }
    else
    {
        historyAry = [NSMutableArray array];
    }
    SearchModel *newModel = [[SearchModel alloc] init];
    newModel.name = navbar.searchTextField.text;
    newModel.searchId = @"";
    [historyAry addObject:newModel];
    
    NSString *jsonStr = [[SearchModel bxhKeyValuesArrayWithObjectAry:historyAry] jsonString];
    [[NSUserDefaults standardUserDefaults] setObject:jsonStr forKey:HistorySearch];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    __weak typeof(self) weakSelf = self;
    [self dismissViewControllerAnimated:YES completion:^{
        if (weakSelf.delegate)
        {
            [weakSelf.delegate searchController:weakSelf searchText:navbar.searchTextField.text type:weakSelf.navBar.type];
        }
    }];

}

- (void)navbarSearchTypeBtnAction:(SearchNavBar *)navbar
{
    [self.view endEditing:YES];
    CGRect sendToWindow = [navbar.typeBtn convertRect:navbar.typeBtn.frame toView:[UIApplication sharedApplication].keyWindow];
    CGPoint p = CGPointMake(CGRectGetMidX(sendToWindow), CGRectGetMidY(sendToWindow));
    
    [self.popupView presentWithAnchorPoint:p];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSArray *modelAry =  self.sectionAry[section];
    return modelAry.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SearchCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[SearchCollectionCell className] forIndexPath:indexPath];
    NSArray *modelAry = self.sectionAry[indexPath.section];
    SearchModel *model =  modelAry[indexPath.item];
    cell.weakModel = model;
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.sectionAry.count;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    if ([kind isEqualToString: UICollectionElementKindSectionHeader])
    {
        SearchCollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:[SearchCollectionReusableView className] forIndexPath:indexPath];
        if(indexPath.section == 0)
        {
            view.sectionTitleLabel.text = @"热门搜索";
        }
        else
        {
            view.sectionTitleLabel.text = @"历史搜索";
        }
        reusableview = view;
    }
    
    return reusableview;
}

- (CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *modelAry = self.sectionAry[indexPath.section];
    SearchModel *sectionModel =  modelAry[indexPath.item];
    return [SearchCollectionCell cellSizeWithShowText:sectionModel.name];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    SearchCollectionCell *cell = (SearchCollectionCell *)[collectionView cellForItemAtIndexPath:indexPath];
    __weak typeof(self) weakSelf = self;
    [self dismissViewControllerAnimated:YES completion:^{
        if (weakSelf.delegate)
        {
            [weakSelf.delegate searchController:weakSelf searchText:cell.weakModel.name type:weakSelf.navBar.type];
        }
    }];
}

#pragma mark - get
- (SearchNavBar *)navBar
{
    if (!_navBar)
    {
        _navBar = [[SearchNavBar alloc] init];
        _navBar.delegate = self;
        [_navBar.cancelBtn addTarget:self action:@selector(cancelBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _navBar;
}

- (UICollectionView *)searchCollectionView
{
    if (!_searchCollectionView)
    {
        _searchCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:[[SearchCollectionFlowLayout alloc] init]];
        _searchCollectionView.contentInset = UIEdgeInsetsMake(0, 16, 0, 16);
        _searchCollectionView.backgroundColor = Color_White;
        [_searchCollectionView registerClass:[SearchCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:[SearchCollectionReusableView className]];
        [_searchCollectionView registerClass:[SearchCollectionCell class] forCellWithReuseIdentifier:[SearchCollectionCell className]];
        _searchCollectionView.dataSource = self;
        _searchCollectionView.delegate = self;
        _searchCollectionView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    }
    return _searchCollectionView;
}

- (UIButton *)clearBtn
{
    if (!_clearBtn)
    {
        _clearBtn = [[UIButton alloc] init];
        [_clearBtn setBackgroundImage:ImageWithResizableImage(@"SearchClearBtnBack", UIEdgeInsetsMake(10, 15, 10, 15)) forState:UIControlStateNormal];
        [_clearBtn setTitle:@"清空历史记录" forState:UIControlStateNormal];
        [_clearBtn setTitleColor:Color_Main_Dark forState:UIControlStateNormal];
        _clearBtn.titleLabel.font = Font_sys_16;
        [_clearBtn addTarget:self action:@selector(clearBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _clearBtn;
}

- (SUPopupMenu *)popupView
{
    if (!_popupView)
    {
        _popupView = [[SUPopupMenu alloc] initWithTitles:@[@"商品",@"店铺"] icons: nil menuItemSize:CGSizeMake(110, 44)];
        _popupView.delegate = self;
    }
    return _popupView;
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
