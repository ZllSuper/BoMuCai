//
//  BXHLaunchViewController.m
//  GuoGangTong
//
//  Created by 步晓虎 on 2016/12/21.
//  Copyright © 2016年 woshishui. All rights reserved.
//

#import "BXHLaunchViewController.h"
#import "BXHAreaDBManager.h"

#define MaxErrorCount 8

@interface BXHLaunchViewController ()

@property (nonatomic, strong) UIImageView *launchImageView;

@property (nonatomic, strong) UILabel *tipLabel;

@property (nonatomic, strong) UIWindow *ownWindow;

@property (nonatomic, assign) NSInteger errorCount;

@end

@implementation BXHLaunchViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.errorCount = 0;
//    self.view.backgroundColor = Color_Orange;
    
    [self.view addSubview:self.launchImageView];
    
    [self.launchImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view).insets(UIEdgeInsetsZero);
    }];
    
    [self.view addSubview:self.tipLabel];
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view).offset(-80);
    }];
    
    [BXHAreaDBManager defaultManeger];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    __weak typeof(self) weakSelf = self;
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status <= 0)
        {
            weakSelf.tipLabel.hidden = NO;
        }
        else
        {
            
            if (![NSString stringIsEmpty:KAccountInfo.userId])
            {
                [weakSelf huanxinLogin];
            }
            BXHStrongObj(weakSelf);
            [weakSelfStrong performSelector:@selector(cancelViewController) withObject:nil afterDelay:1.0];
        }
    }];
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}

- (void)dismissViewController:(void (^ __nullable)(BOOL finished))completion
{
    [UIView animateWithDuration:0.5 animations:^{
        self.view.transform = CGAffineTransformMakeScale(1.2, 1.2);
        self.view.alpha = 0;
    } completion:completion];
}

- (void)show
{
    [self.ownWindow makeKeyAndVisible];
}

- (void)cancelViewController
{
    [self.delegate bxhLaunchViewControllerWillDismiss:self];
    [self dismissViewController:^(BOOL finished) {
        
        if (finished)
        {
            [self.delegate bxhLaunchViewControllerDidDismiss:self];
        }
        self.ownWindow.hidden = YES;
        self.ownWindow = nil;
    }];
}

- (BOOL)huanxinLogin
{
    EMError *error = [[EMClient sharedClient] loginWithUsername:KAccountInfo.easemob password:KAccountInfo.easemobPassword];
    if(error && self.errorCount < MaxErrorCount)
    {
        self.errorCount++;
        return [self huanxinLogin];
    }
    else {
        //设置是否自动登录
        [[EMClient sharedClient].options setIsAutoLogin:YES];
    }
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIImageView *)launchImageView
{
    if (!_launchImageView)
    {
        _launchImageView = [[UIImageView alloc] init];

    
        NSURL *imageUrl = [[NSUserDefaults standardUserDefaults] URLForKey:ImageStartLoadUrl];
        if (imageUrl)
        {
            [_launchImageView sd_setImageWithURL:imageUrl];
        }
        else
        {
            NSString *suffix = nil;
            
            if (DEF_SCREENHEIGHT == 480)
            { //4，4S
                suffix = @"LaunchImage-700";
            }
            else if (DEF_SCREENHEIGHT == 568)
            { //5, 5C, 5S, iPod
                suffix = @"LaunchImage-700-568h";
            }
            else if (DEF_SCREENHEIGHT == 667)
            { //6, 6S
                suffix = @"LaunchImage-800-667h";
            }
            else if (DEF_SCREENHEIGHT == 736)
            { // 6Plus, 6SPlus
                suffix = @"LaunchImage-800-Landscape-736h";
            }
            
            
            if (suffix.length > 0)
            {
                _launchImageView.image = ImageWithName(suffix);
            }
        }
    }
    return _launchImageView;
}

- (UILabel *)tipLabel
{
    if (!_tipLabel)
    {
        _tipLabel = [[UILabel alloc] init];
        _tipLabel.font = Font_sys_14;
        _tipLabel.textColor =  Color_MainText;
        _tipLabel.text = @"网络无法连接";
        _tipLabel.hidden = YES;
    }
    return _tipLabel;
}

- (UIWindow *)ownWindow
{
    if (!_ownWindow)
    {
        _ownWindow = [[UIWindow alloc] initWithFrame:DEF_SCREENBOUNDS];
        _ownWindow.windowLevel = UIWindowLevelStatusBar;
        _ownWindow.hidden = YES;
        _ownWindow.rootViewController = self;
    }
    return _ownWindow;
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
