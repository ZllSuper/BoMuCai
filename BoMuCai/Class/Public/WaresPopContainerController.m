//
//  WaresPopContainerController.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/1/25.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "WaresPopContainerController.h"


@implementation UIViewController(WaresPopContainer)

static char WaresPopContainerControllerKey;

- (void)setContainerController:(WaresPopContainerController *)containerController
{
    objc_setAssociatedObject(self, &WaresPopContainerControllerKey, containerController, OBJC_ASSOCIATION_ASSIGN);
}

- (WaresPopContainerController *)containerController
{
    return objc_getAssociatedObject(self, &WaresPopContainerControllerKey);
}

@end

#define ShowPerecent 0.6

@interface WaresPopContainerController ()

@property (nonatomic, weak) UIViewController *rootViewController;

@property (nonatomic, weak) UIViewController *fromViewController;

@property (nonatomic, strong) UIWindow *rootWindow;

@property (nonatomic, strong) MASConstraint *rootTop;

@end

@implementation WaresPopContainerController
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
    [self hiddenWithAnimate];
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
            make.height.mas_equalTo(DEF_SCREENHEIGHT * ShowPerecent);
            make.right.mas_equalTo(self.view);
            make.left.mas_equalTo(self.view);
        }];
    }
    return self;
}

- (void)showFromViewController:(UIViewController *)fromController
{
    self.fromViewController = fromController;
    
    [self.rootWindow makeKeyAndVisible];
    [self open];
}

- (void)hiddenWithAnimate
{
    [self close];
}

#pragma mark - private
- (void)open
{
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.2 animations:^{
        weakSelf.fromViewController.view.layer.transform = [weakSelf firstStepTransform];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            weakSelf.rootTop.offset = DEF_SCREENHEIGHT * (1 - ShowPerecent);
            [weakSelf.view layoutIfNeeded];
            weakSelf.fromViewController.view.layer.transform = [weakSelf secondStepTransform];
        }];
    }];
}

- (void)close
{
    if (self.protcol)
    {
         [self.protcol containerController:self willDismissViewController:self.rootViewController];
    }

    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.rootTop.offset(DEF_SCREENHEIGHT);
        [weakSelf.view layoutIfNeeded];
        weakSelf.fromViewController.view.layer.transform = [weakSelf firstStepTransform];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            weakSelf.fromViewController.view.layer.transform = CATransform3DIdentity;
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
    }];
}

// 动画1
- (CATransform3D)firstStepTransform
{
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = 1.0 / -500.0;
    transform = CATransform3DScale(transform, 0.98, 0.98, 1.0);
    transform = CATransform3DRotate(transform, 5.0 * M_PI / 180.0, 1, 0, 0);
    transform = CATransform3DTranslate(transform, 0, 0, -40.0);
    return transform;
}


// 动画2
- (CATransform3D)secondStepTransform
{
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = 1.0 / -500.0;
    transform = CATransform3DTranslate(transform, 0, DEF_SCREENHEIGHT * -0.08, 0);
    transform = CATransform3DScale(transform, 0.8, 0.8, 1.0);
    return transform;
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
