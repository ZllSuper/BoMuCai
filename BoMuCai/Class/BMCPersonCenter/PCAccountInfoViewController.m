//
//  PCAccountInfoViewController.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/8.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "PCAccountInfoViewController.h"
#import "PCAccountInfoTableView.h"
#import "PCAccountTextEditViewController.h"
#import "PCAccountRowSelViewController.h"
#import "BXHAddressViewController.h"
#import "PCAddressManagerViewController.h"
#import "PCEditPasswordViewController.h"

#import "TSRegularExpressionUtil.h"

#import "HJCActionSheet.h"

#import "PCAccountEditProtcol.h"

#import "PCUploadHeaderImageRequest.h"
#import "PCEditUserInfoRequest.h"

@interface PCAccountInfoViewController () <HJCActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,PCAccountEditProtcol,BXHAddressViewControllerDelegate>

@property (nonatomic, strong) PCAccountInfoTableView *tableView;

@end

@implementation PCAccountInfoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"账户信息";
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    
    __weak typeof(self) weakSelf = self;
    [self.tableView tableViewDidSelectCallBack:^(BaseTableView *tableView, NSIndexPath *indexPath) {
        [weakSelf tableViewRowActionSection:indexPath.section row:indexPath.row];
    }];
    
    [self.tableView.mj_header beginRefreshing];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - request
- (void)updatePersonHeader:(UIImage *)editImage
{
    NSString *imageStr = [editImage scaleToByteSize:150 * 1024 andImageWidth:150];
    __weak typeof(self) weakSelf = self;
    __block UIImage *blockImage = editImage;
    PCUploadHeaderImageRequest *item = [[PCUploadHeaderImageRequest alloc] init];
    item.userId = KAccountInfo.userId;
    item.photo = imageStr;
    ProgressShow(self.view);
    [item requestWithSuccess:^( BXHBaseRequest *request) {
        ProgressHidden(weakSelf.view);
        if ([request.response.code isEqualToString:@"0000"])
        {
            KAccountInfo.photo = request.response.data;
            [KAccountInfo saveToDisk];
            weakSelf.tableView.imageCell.headerImageView.image = blockImage;
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

#pragma mark - request
- (void)updateUserInfoRequest:(NSString *)address
{
    __weak typeof(self) weakSelf = self;
    __block typeof(address) blAddress = address;
    PCEditUserInfoRequest *infoRequest = [[PCEditUserInfoRequest alloc] init];
    infoRequest.userId = KAccountInfo.userId;
    [infoRequest setValue:address forKey:@"address"];
    ProgressShow(self.view);
    [infoRequest requestWithSuccess:^( BXHBaseRequest *request) {
        ProgressHidden(weakSelf.view);
        if ([request.response.code isEqualToString:@"0000"])
        {
            weakSelf.tableView.accountModel.address = blAddress;
            KAccountInfo.address = weakSelf.tableView.accountModel.address;
            [KAccountInfo saveToDisk];
            [weakSelf.tableView reloadData];

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


#pragma mark - private
- (void)tableViewRowActionSection:(NSInteger)section row:(NSInteger)row
{
    //  nickName,email,company,sex,area,areaId,qq,phone

    NSArray *sectionAry = [self.tableView.soureAry objectAtIndex:section];
    NSDictionary *rowDict = sectionAry[row];
    if (section == 0 && row == 0)
    {
        [self headerImageChangeAction];
    }
    else if (section == 0)
    {
        switch (row)
        {
            case 1:
            {

                PCAccountTextEditViewController *vc = [[PCAccountTextEditViewController alloc] initWithTitle:rowDict[@"title"] accountModel:self.tableView.accountModel propertyName:@"nickName"];
                vc.delegate = self;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 2:
            {
                PCAccountTextEditViewController *vc = [[PCAccountTextEditViewController alloc] initWithTitle:rowDict[@"title"] accountModel:self.tableView.accountModel propertyName:@"email"];
                vc.delegate = self;
                [vc validEnterText:^BOOL(NSString *confirmText) {
                    return [TSRegularExpressionUtil validateEmail:confirmText];
                }];
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 3:
            {
                PCAccountTextEditViewController *vc = [[PCAccountTextEditViewController alloc] initWithTitle:rowDict[@"title"] accountModel:self.tableView.accountModel propertyName:@"companyName"];
                vc.delegate = self;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 4:
            {
                NSString *path = [[NSBundle mainBundle] pathForResource:@"PCAccountSexList" ofType:@"plist"];
                NSArray *sexAry = [NSArray arrayWithContentsOfFile:path];
                
                PCAccountRowSelViewController *vc = [[PCAccountRowSelViewController alloc] initWithTitle:rowDict[@"title"] accountModel:self.tableView.accountModel propertyName:@"sex" andSelectSourceAry:sexAry];
                vc.delegate = self;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 5:
            {
                BXHAddressViewController *vc = [[BXHAddressViewController alloc] init];
                vc.delegate = self;
                BXHAddressContainerController *container = [[BXHAddressContainerController alloc] initWithRootViewController:vc];
                [container showWithAnimate];
            }
                break;
            case 6:
            {
                PCAccountTextEditViewController *vc = [[PCAccountTextEditViewController alloc] initWithTitle:rowDict[@"title"] accountModel:self.tableView.accountModel propertyName:@"qq"];
                vc.delegate = self;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
  
            default:
            {
                PCAddressManagerViewController *vc = [[PCAddressManagerViewController alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
        }
    }
    else
    {
        if (row == 1)
        {
            PCEditPasswordViewController *vc = [[PCEditPasswordViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}

- (void)headerImageChangeAction
{
    HJCActionSheet *sheet = [[HJCActionSheet alloc] initWithDelegate:self CancelTitle:@"取消" OtherTitles:@"从相册选择",@"拍照", nil];
    [sheet show];
}

#pragma mark - editProtcol
- (void)accountInfoEditSuccess:(UIViewController *)viewController
{
    KAccountInfo.nickName = self.tableView.accountModel.nickName;
    KAccountInfo.email = self.tableView.accountModel.email;
    KAccountInfo.companyName = self.tableView.accountModel.companyName;
    KAccountInfo.sex = self.tableView.accountModel.sex;
    KAccountInfo.address = self.tableView.accountModel.address;
    KAccountInfo.qq = self.tableView.accountModel.qq;
    KAccountInfo.phone = self.tableView.accountModel.phone;
    [KAccountInfo saveToDisk];
    [self.tableView reloadData];
}

- (void)addressViewController:(BXHAddressViewController *)vc proModel:(BXHProModel *)proModel cityModel:(BXHCityModel *)cityModel areaModel:(BXHAreaModel *)areaModel
{
    NSString *address = [NSString stringWithFormat:@"%@ %@ %@",proModel.provName,cityModel.cityName,areaModel.areaName];
    [self updateUserInfoRequest:address];
}

#pragma mark - actionSheetDelegate
- (void)actionSheet:(HJCActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    if(buttonIndex != 0)
    {
        if(buttonIndex == 1)
        {
            //相册
            sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        }
        else
        {
            sourceType = UIImagePickerControllerSourceTypeCamera;
        }
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = YES;
        //true为拍照、选择完进入图片编辑模式
        imagePickerController.sourceType = sourceType;
        [self presentViewController:imagePickerController animated:YES completion:nil];
    }
}

#pragma mark - ImagePickerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *editImage = info[@"UIImagePickerControllerEditedImage"];
    
    [self updatePersonHeader:editImage];
    
    //    self.infoModel.
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - get
- (PCAccountInfoTableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[PCAccountInfoTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    }
    return _tableView;
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
