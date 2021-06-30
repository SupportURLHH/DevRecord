//
//  LMJBaseViewController.h
//  PLMMPRJK
//
//  Created by NJHu on 2017/3/29.
//  Copyright © 2017年 GoMePrjk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LMJNavigationBar.h"
#import "LMJNavigationController.h"

@class LMJNavUIBaseViewController;
@protocol LMJNavUIBaseViewControllerDataSource <NSObject>

@optional
- (BOOL)navUIBaseViewControllerIsNeedNavBar:(LMJNavUIBaseViewController *)navUIBaseViewController;

- (UIStatusBarStyle)navUIBaseViewControllerPreferStatusBarStyle:(LMJNavUIBaseViewController *)navUIBaseViewController;

@end

/*
* 证优客 基础VC
* 1：控制着导航栏的颜色，时间，布局
*/
@interface LMJNavUIBaseViewController : UIViewController <LMJNavigationBarDelegate, LMJNavigationBarDataSource, LMJNavUIBaseViewControllerDataSource>

/*默认的导航栏字体*/
- (NSMutableAttributedString *)changeTitle:(NSString *)curTitle;

- (void)setTitle:(NSString *)title Color:(UIColor*)textColor;

- (NSMutableAttributedString *)changeTitle:(NSString *)curTitle titleColor:(UIColor*)titleColor;

@property (weak, nonatomic) LMJNavigationBar *lmj_navgationBar;
@end
