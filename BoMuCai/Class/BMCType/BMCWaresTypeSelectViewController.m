//
//  BMCWaresTypeSelectViewController.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/3.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "BMCWaresTypeSelectViewController.h"
#import "SearchCollectionReusableView.h"
#import "WaresDetailTypeCell.h"
#import "WaresTypeBuyCountCell.h"
#import "SearchCollectionFlowLayout.h"
#import "WaresTypeSectionModel.h"

@interface BMCWaresTypeSelectViewController () <UICollectionViewDelegate, UICollectionViewDataSource,WaresTypeBuyCountCellDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) UILabel *selectLabel;

@property (nonatomic, strong) UILabel *stockLabel;

@property (nonatomic, strong) UIButton *buyBtn;

@property (nonatomic, strong) UIButton *addToCarBtn;

@property (nonatomic, strong) NSMutableArray *sectionAry;

@property (nonatomic, weak) BMCWaresDetailModel *detailModel;


@end

@implementation BMCWaresTypeSelectViewController

- (instancetype) initWithWaresDetailModel:(BMCWaresDetailModel *)detailModel
{
    if (self = [super init])
    {
        self.detailModel = detailModel;
        
        [self projectSourceDeal];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.sectionAry = [NSMutableArray array];
    
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.buyBtn];
    [self.view addSubview:self.addToCarBtn];
    [self.view addSubview:self.selectLabel];
    [self.view addSubview:self.stockLabel];
    
    [self.selectLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(16);
        make.top.mas_equalTo(self.view).offset(10);
    }];
    
    [self.stockLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view).offset(-16);
        make.top.mas_equalTo(self.view).offset(10);
    }];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.selectLabel.mas_bottom).offset(10);
    }];
    
    
    [self.addToCarBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view);
        make.top.mas_equalTo(self.collectionView.mas_bottom);
        make.height.mas_equalTo(44);
        make.bottom.mas_equalTo(self.view);
    }];

    
    [self.buyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.addToCarBtn.mas_right);
        make.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.addToCarBtn);
        make.bottom.mas_equalTo(self.addToCarBtn);
        make.width.mas_equalTo(self.addToCarBtn);
       
    }];
    
    
    WaresTypeSectionModel *sectionModel4 = [[WaresTypeSectionModel alloc] init];
    sectionModel4.name = @"购买数量";
    
    [self.sectionAry addObjectsFromArray:self.detailModel.mdseTypePropertyDtos];
    [self.sectionAry addObject:sectionModel4];

    // Do any additional setup after loading the view.
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.collectionView registerAsDodgeViewForMLInputDodger];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.collectionView unregisterAsDodgeViewForMLInputDodger];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - action
- (void)buyBtnAction
{
    [self.delegate selectViewControllerBuyNow:self];
}

- (void)addCarBtnAction
{
    [self.delegate selectViewControllerAddToCart:self];
}

#pragma mark - BuyCountCellDelegate
- (void)buyCountCell:(WaresTypeBuyCountCell *)cell buyCountText:(NSString *)buyCount
{
    if ([buyCount integerValue] <= 1)
    {
        cell.buyView.countTextFiled.text = @"1";
//        cell.buyView.reduceBtn.enabled = NO;
        self.detailModel.buyCount = @"1";
//        cell.buyView.addBtn.enabled = YES;

    }
    else
    {
//        cell.buyView.reduceBtn.enabled = YES;
        if ([buyCount integerValue] > [self.detailModel.repertory integerValue])
        {
            cell.buyView.countTextFiled.text = self.detailModel.repertory;
//            cell.buyView.addBtn.enabled = NO;
            self.detailModel.buyCount = self.detailModel.repertory;
        }
        else
        {
//            cell.buyView.addBtn.enabled = YES;
            self.detailModel.buyCount = buyCount;
        }
    }
    
}

#pragma mark - collectdelegate datasource
#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == (self.sectionAry.count - 1))
    {
        return 1;
    }
    WaresTypeSectionModel *sectionModel =  self.sectionAry[section];
    return sectionModel.models.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == (self.sectionAry.count - 1))
    {
        WaresTypeBuyCountCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[WaresTypeBuyCountCell className] forIndexPath:indexPath];
        cell.buyView.maxCount = [self.detailModel.repertory integerValue];
        cell.buyView.countTextFiled.text = self.detailModel.buyCount;
//        cell.buyView.reduceBtn.enabled = [self.detailModel.buyCount integerValue] > 1;
//        cell.buyView.addBtn.enabled = [self.detailModel.buyCount integerValue] < [self.detailModel.repertory integerValue];
        cell.delegate = self;
        return cell;
    }
    WaresDetailTypeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[WaresDetailTypeCell className] forIndexPath:indexPath];
    WaresTypeSectionModel *sectionModel = self.sectionAry[indexPath.section];
    WaresTypeModel *model =  sectionModel.models[indexPath.item];
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
        WaresTypeSectionModel *sectionModel = self.sectionAry[indexPath.section];
        view.sectionTitleLabel.text = sectionModel.name;
        reusableview = view;
    }
    
    return reusableview;
}

- (CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WaresTypeSectionModel *sectionModel = self.sectionAry[indexPath.section];
    WaresTypeModel *model =  sectionModel.models[indexPath.item];
    if (indexPath.section == (self.sectionAry.count - 1))
    {
        return [WaresTypeBuyCountCell sizeWithCell];
    }
    else
    {
        return [WaresDetailTypeCell cellSizeWithShowText:model.name];
    }

}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section != (self.sectionAry.count - 1))
    {
        WaresDetailTypeCell *cell = (WaresDetailTypeCell *)[collectionView cellForItemAtIndexPath:indexPath];
        if (cell.weakModel.statue != WaresTypeUnenable)
        {
            NSArray *selAry = [self.detailModel.morenfenlei componentsSeparatedByString:@","];
            NSMutableArray *mSelAry = [NSMutableArray arrayWithArray:selAry];
            if (cell.weakModel.statue == WaresTypeNormal)
            {
                [mSelAry replaceObjectAtIndex:indexPath.section withObject:cell.weakModel.typeId];
            }
            else
            {
                [mSelAry replaceObjectAtIndex:indexPath.section withObject:EMPTY_SEL];
            }
            self.detailModel.morenfenlei = [mSelAry componentsJoinedByString:@","];
            NSLog(@"selId ===== %@",self.detailModel.morenfenlei);
            [self projectSourceDeal];
            [collectionView reloadData];
            
        }
    }
}

- (void)projectSourceDeal
{
    NSString *resultStr = [self dealTypeWithSelId:self.detailModel.morenfenlei];
    
    if ([self.detailModel.morenfenlei rangeOfString:EMPTY_SEL].location == NSNotFound)
    {
        BMCWaresGoupsModel *goupModel = [self getProjectWithSelId:self.detailModel.morenfenlei];
        self.detailModel.mdseId = goupModel.waresId;
        self.detailModel.repertory = goupModel.amount;
        self.detailModel.price = goupModel.unitPrice;
        self.stockLabel.text = _StrFormate(@"库存：%@",goupModel.amount);
        if ([self.detailModel.buyCount integerValue] > [self.detailModel.repertory integerValue])
        {
            self.detailModel.buyCount = self.detailModel.repertory;
        }
    }
    else
    {
        self.stockLabel.text = @"";
    }
    self.selectLabel.text = _StrFormate(@"已选择:%@",resultStr);

}

- (BMCWaresGoupsModel *)getProjectWithSelId:(NSString *)selId
{
    for (BMCWaresGoupsModel *goupModel in self.detailModel.mdsePropertyDtos)
    {
        if ([goupModel.propertyValue isEqualToString:selId])
        {
            return goupModel;
        }
    }
    return nil;
}

- (NSString *)dealTypeWithSelId:(NSString *)selId
{
    NSArray *selAry = [selId componentsSeparatedByString:@","];
    NSString *resultStr = @"";
    for (WaresTypeSectionModel *model in self.detailModel.mdseTypePropertyDtos)
    {
        NSInteger index = [self.detailModel.mdseTypePropertyDtos indexOfObject:model];
        NSString *selId = selAry[index];
        for (WaresTypeModel *typeModel in model.models)
        {
            if ([selId isEqualToString:typeModel.typeId])
            {
                typeModel.statue = WaresTypeSelect;
                resultStr = _StrFormate(@" %@%@-%@",resultStr,model.name,typeModel.name);
            }
            else
            {
                NSMutableArray *mSelAry = [NSMutableArray arrayWithArray:selAry];
                [mSelAry replaceObjectAtIndex:index withObject:typeModel.typeId];
                NSString *resultSelStr = [mSelAry componentsJoinedByString:@","];
                BOOL projectHave = NO;
                for (BMCWaresGoupsModel *goupModel in self.detailModel.mdsePropertyDtos)
                {

                    if ([self checkProjectHaveWithTypeStr:resultSelStr projectStr:goupModel.propertyValue])
                    {
                        projectHave = YES;
                        break;
                    }
                }
                
                if (projectHave)
                {
                    typeModel.statue = WaresTypeNormal;
                }
                else
                {
                    typeModel.statue = WaresTypeUnenable;
                }
            }
        }
    }
    return resultStr;
}

- (BOOL)checkProjectHaveWithTypeStr:(NSString *)typeStr projectStr:(NSString *)projectStr
{
    NSArray *projectAry = [projectStr componentsSeparatedByString:@","];
    NSArray *typeAry = [typeStr componentsSeparatedByString:@","];
    
    for (int i = 0; i < projectAry.count; i ++)
    {
        NSString *typeId = typeAry[i];
        NSString *selId = projectAry[i];
        if ([typeId isEqualToString:EMPTY_SEL])
        {
            continue;
        }
        if (![typeId isEqualToString:selId])
        {
            return NO;
        }
    }
    return YES;
}

#pragma mark - get

- (UILabel *)selectLabel
{
    if (!_selectLabel)
    {
        _selectLabel = [[UILabel alloc] init];
        _selectLabel.textColor = Color_Text_Gray;
        _selectLabel.font = Font_sys_14;
        _selectLabel.textAlignment = NSTextAlignmentLeft;
        _selectLabel.text = @"已选择:";
    }
    return _selectLabel;
}

- (UILabel *)stockLabel
{
    if (!_stockLabel)
    {
        _stockLabel = [[UILabel alloc] init];
        _stockLabel.textColor = Color_Text_Gray;
        _stockLabel.font = Font_sys_14;
        _stockLabel.textAlignment = NSTextAlignmentRight;
    }
    return _stockLabel;
}

- (UICollectionView *)collectionView
{
    if (!_collectionView)
    {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:[[SearchCollectionFlowLayout alloc] init]];
        _collectionView.contentInset = UIEdgeInsetsMake(0, 16, 0, 16);
        _collectionView.backgroundColor = Color_White;
        [_collectionView registerClass:[SearchCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:[SearchCollectionReusableView className]];
        [_collectionView registerClass:[WaresDetailTypeCell class] forCellWithReuseIdentifier:[WaresDetailTypeCell className]];
        [_collectionView registerClass:[WaresTypeBuyCountCell class] forCellWithReuseIdentifier:[WaresTypeBuyCountCell className]];

        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    }
    return _collectionView;
}



- (UIButton *)buyBtn
{
    if (!_buyBtn)
    {
        _buyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_buyBtn setTitle:@"立即购买" forState:UIControlStateNormal];
        [_buyBtn setBackgroundImage:ImageWithColor(Color_Main_Dark) forState:UIControlStateNormal];
        [_buyBtn setTitleColor:Color_White forState:UIControlStateNormal];
        _buyBtn.titleLabel.font = Font_sys_16;
        [_buyBtn addTarget:self action:@selector(buyBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _buyBtn;
}

- (UIButton *)addToCarBtn
{
    if (!_addToCarBtn)
    {
        _addToCarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addToCarBtn setTitle:@"加入购物车" forState:UIControlStateNormal];
        [_addToCarBtn setBackgroundImage:ImageWithColor(UIColorFromRGB(0xDFBC40)) forState:UIControlStateNormal];
        [_addToCarBtn setTitleColor:Color_White forState:UIControlStateNormal];
        _addToCarBtn.titleLabel.font = Font_sys_16;
        [_addToCarBtn addTarget:self action:@selector(addCarBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addToCarBtn;
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
