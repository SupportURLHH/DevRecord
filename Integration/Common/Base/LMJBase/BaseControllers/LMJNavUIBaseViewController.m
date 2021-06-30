//
//  LMJBaseViewController.m
//  PLMMPRJK
//
//  Created by NJHu on 2017/3/29.
//  Copyright © 2017年 GoMePrjk. All rights reserved.
//

#import "LMJNavUIBaseViewController.h"
#import "LMJNavigationBar.h"
#import <sys/utsname.h>

@implementation LMJNavUIBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    LMJWeak(self);
    [self.navigationItem addObserverBlockForKeyPath:LMJKeyPath(self.navigationItem, title) block:^(id  _Nonnull obj, id  _Nonnull oldVal, NSString  *_Nonnull newVal) {
        if (newVal.length > 0 && ![newVal isEqualToString:oldVal]) {
            weakself.title = newVal;
        }
    }];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.lmj_navgationBar.mj_w = self.view.mj_w;
    [self.view bringSubviewToFront:self.lmj_navgationBar];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:[self navUIBaseViewControllerPreferStatusBarStyle:self] animated:animated];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:[self navUIBaseViewControllerPreferStatusBarStyle:self] animated:animated];
}

- (void)dealloc {
    [self.navigationItem removeObserverBlocksForKeyPath:LMJKeyPath(self.navigationItem, title)];
}

#pragma mark - LMJNavUIBaseViewControllerDataSource
- (BOOL)navUIBaseViewControllerIsNeedNavBar:(LMJNavUIBaseViewController *)navUIBaseViewController
{
    return YES;
}

- (UIStatusBarStyle)navUIBaseViewControllerPreferStatusBarStyle:(LMJNavUIBaseViewController *)navUIBaseViewController
{
    if (@available(iOS 13.0, *)) {
        /// 适配iOS 13，默认变为了 DarkContent
        return UIStatusBarStyleDarkContent;
    }
    return UIStatusBarStyleDefault;
}

#pragma mark - DataSource
/**头部标题*/
- (NSMutableAttributedString*)lmjNavigationBarTitle:(LMJNavigationBar *)navigationBar
{
    return [self changeTitle:self.title ?: self.navigationItem.title];
}

/** 背景色 */
- (UIColor *)lmjNavigationBackgroundColor:(LMJNavigationBar *)navigationBar
{
    return [UIColor whiteColor];
}

- (UIColor *)lmjNavigationLineColor:(LMJNavigationBar *)navigationBar
{
    return [UIColor colorWithHexString:@"#EEEEEE"];
}

/** 是否显示底部黑线 */
- (BOOL)lmjNavigationIsHideBottomLine:(LMJNavigationBar *)navigationBar
{
    return NO;
}

/** 导航条的高度 */
- (CGFloat)lmjNavigationHeight:(LMJNavigationBar *)navigationBar
{
    return [UIApplication sharedApplication].statusBarFrame.size.height + 44.0;
}

#pragma mark - Delegate
/** 左边的按钮的点击 */
-(void)leftButtonEvent:(UIButton *)sender navigationBar:(LMJNavigationBar *)navigationBar
{
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    NSLog(@"%s", __func__);
}

/** 右边的按钮的点击 */
-(void)rightButtonEvent:(UIButton *)sender navigationBar:(LMJNavigationBar *)navigationBar
{
    NSLog(@"%s", __func__);
}

/** 中间如果是 label 就会有点击 */
-(void)titleClickEvent:(UILabel *)sender navigationBar:(LMJNavigationBar *)navigationBar
{
    NSLog(@"%s", __func__);
}

#pragma mark 自定义代码
- (NSMutableAttributedString *)changeTitle:(NSString *)curTitle
{
    UIColor *dyColor = [UIColor colorWithHexString:@"010101"];
    if (@available(iOS 13.0, *)) {
        dyColor = [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull trainCollection) {
            if ([trainCollection userInterfaceStyle] == UIUserInterfaceStyleLight) {
                return [UIColor colorWithHexString:@"010101"];
            }
            else {
                return [UIColor colorWithHexString:@"C4C7CC"];
            }
        }];
    }
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:curTitle ?: @""];
    [title addAttribute:NSForegroundColorAttributeName value:dyColor range:NSMakeRange(0, title.length)];
    [title addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18 weight:UIFontWeightBold] range:NSMakeRange(0, title.length)];
    return title;
}

- (NSMutableAttributedString *)changeTitle:(NSString *)curTitle titleColor:(UIColor*)titleColor
{
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:curTitle ?: @""];
    [title addAttribute:NSForegroundColorAttributeName value:titleColor range:NSMakeRange(0, title.length)];
    [title addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18 weight:UIFontWeightBold] range:NSMakeRange(0, title.length)];
    return title;
}

- (LMJNavigationBar *)lmj_navgationBar
{
    // 父类控制器必须是导航控制器
    if(!_lmj_navgationBar && [self.parentViewController isKindOfClass:[UINavigationController class]] && [self navUIBaseViewControllerIsNeedNavBar:self])
    {
        LMJNavigationBar *navigationBar = [[LMJNavigationBar alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 0)];
        [self.view addSubview:navigationBar];
        navigationBar.dataSource = self;
        navigationBar.lmjDelegate = self;
        _lmj_navgationBar = navigationBar;
    }
    return _lmj_navgationBar;
}

- (void)setTitle:(NSString *)title
{
    [super setTitle:title];
    self.lmj_navgationBar.title = [self changeTitle:title];
}

- (void)setTitle:(NSString *)title Color:(UIColor*)textColor
{
    [super setTitle:title];
    self.lmj_navgationBar.title = [self changeTitle:title titleColor:textColor];
}

@end






