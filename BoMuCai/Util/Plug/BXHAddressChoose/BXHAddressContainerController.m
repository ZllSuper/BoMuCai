//
//  BXHAddressContainerController.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/8.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "BXHAddressContainerController.h"

#define ContentViewHeight 260

@implementation UIViewController(BXHAddressContainer)

static char BXHAddressContainerControllerKey;

- (void)setContainerController:(BXHAddressContainerController *)containerController
{
    objc_setAssociatedObject(self, &BXHAddressContainerControllerKey, containerController, OBJC_ASSOCIATION_ASSIGN);
}

- (BXHAddressContainerController *)containerController
{
    return objc_getAssociatedObject(self, &BXHAddressContainerControllerKey);
}

@end


@interface BXHAddressContainerController ()

@property (nonatomic, weak) UIViewController *rootViewController;

@property (nonatomic, strong) UIWindow *rootWindow;

@property (nonatomic, strong) MASConstraint *rootTop;


@end

@implementation BXHAddressContainerController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
    [self hiddenWithAnimte];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - public
- (instancetype) initWithRootViewController:(UIViewController *)rootViewController
{
    if (self = [super init])
    {
        self.rootViewController = rootViewController;
        
        [self.view addSubview:self.rootViewController.view];
        [self addChildViewController:self.rootViewController];
        self.rootViewController.containerController = self;
        
        [self.rootViewController.view mas_makeConstraints:^(MASConstraintMaker *make) {
            self.rootTop = make.top.mas_equalTo(self.view).offset(DEF_SCREENHEIGHT);
            make.height.mas_equalTo(ContentViewHeight);
            make.right.mas_equalTo(self.view);
            make.left.mas_equalTo(self.view);
        }];
    }
    return self;
}

- (void)showWithAnimate
{
    [self.view layoutIfNeeded];
    [self.rootWindow makeKeyAndVisible];
    [self open];
}

- (void)hiddenWithAnimte
{
    [self close];
}

#pragma mark - private
- (void)open
{
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.2 animations:^{
        weakSelf.rootTop.offset = DEF_SCREENHEIGHT - ContentViewHeight;
        [weakSelf.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        
    }];
}

- (void)close
{
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.rootTop.offset = DEF_SCREENHEIGHT;
        [weakSelf.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        [weakSelf.rootViewController.view removeAllSubviews];
        [weakSelf.rootViewController removeAllChildViewController];
        [weakSelf.rootViewController.view removeFromSuperview];
        [weakSelf.rootViewController removeFromParentViewController];
        weakSelf.rootViewController = nil;
        [MainAppDelegate.window makeKeyAndVisible];
        weakSelf.rootWindow.rootViewController = nil;
        weakSelf.rootWindow.hidden = YES;
        weakSelf.rootWindow = nil;
    }];
}


#pragma makr - get
- (UIWindow *)rootWindow
{
    if (!_rootWindow)
    {
        _rootWindow = [[UIWindow alloc] initWithFrame:DEF_SCREENBOUNDS];
        _rootWindow.rootViewController = self;
        _rootWindow.windowLevel = UIWindowLevelStatusBar;
        _rootWindow.hidden = YES;
    }
    return _rootWindow;
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
