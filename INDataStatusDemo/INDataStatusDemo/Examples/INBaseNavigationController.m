//
//  INBaseNavigationController.m
//  INDataStatusDemo
//
//  Created by guobingwei on 2019/10/18.
//  Copyright © 2019年 bruce. All rights reserved.
//

#import "INBaseNavigationController.h"
#import "INBaseViewController.h"
#import "UIColor+Addition.h"

@interface INBaseNavigationController ()<UIGestureRecognizerDelegate,UINavigationBarDelegate>

@end

@implementation INBaseNavigationController

+ (void)initialize {
    [self setupDefaultNavBarTheme];
}

- (id)initWithRootViewController:(UIViewController *)rootViewController {
    self = [super initWithRootViewController:rootViewController];
    if (self) {
    }
    return self;
}

/*!
 *  @brief  激活手势返回功能
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    __weak typeof (self) weakSelf = self;
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        weakSelf.interactivePopGestureRecognizer.delegate = weakSelf;
    }
    
    [self setNeedsStatusBarAppearanceUpdate];
}

#pragma mark 设置导航栏主题
+ (void)setupDefaultNavBarTheme{
    // 取出appearance对象
    [[UINavigationBar appearance] setTranslucent:NO];
    UINavigationBar *navBar = [UINavigationBar appearance];
    [navBar setBackgroundImage:[[UIImage alloc] init] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [navBar setShadowImage:[[UIImage alloc] init]];
    // 设置标题属性
    navBar.barTintColor = [UIColor colorWithHexString:@"131518"];
    //navBar.barTintColor = COLOR(7.0, 0.0, 5.0, 1.0);
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"363636"],NSForegroundColorAttributeName:[UIFont systemFontOfSize:19]}];
}

/*!
 *  @brief  避免在Push过程中激活手势返回而导致crash
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    NSArray *viewControllers = [self.navigationController viewControllers];
    UIViewController *topController;
    if ([viewControllers count] > 0) {
        topController = [viewControllers lastObject];
    }
    
    [super pushViewController:viewController animated:animated];
}

- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated {
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    
    return  [super popToRootViewControllerAnimated:animated];
}

- (NSArray *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    return [super popToViewController:viewController animated:animated];
}

-(UIViewController *)popViewControllerAnimated:(BOOL)animated {
    return [super popViewControllerAnimated:animated];
}


@end
