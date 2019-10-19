//
//  INBaseViewController.m
//  INDataStatusDemo
//
//  Created by guobingwei on 2019/10/18.
//  Copyright © 2019年 bruce. All rights reserved.
//

#import "INBaseViewController.h"
#import "UIColor+Addition.h"

@interface INBaseViewController ()

@end

@implementation INBaseViewController

- (id)init {
    self = [super init];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
        [self setNeedsStatusBarAppearanceUpdate];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"f7f7f7"];
    self.view.exclusiveTouch = YES;
    self.view.clipsToBounds = YES;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.extendedLayoutIncludesOpaqueBars = YES;
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    self.view.statusOriginSize = [UIScreen mainScreen].bounds.size;
    self.view.edgeInset = UIEdgeInsetsMake(kStatusBarHeight+44.0, 0.0, 0.0, 0.0);
    self.view.noDataStatusView = [INDefaultDataStatus noDataStatusView];
    self.view.netErrorStatusView = [INDefaultDataStatus netErrorStatusView];
    self.view.loadingView = [INDefaultDataStatus dataLoadingView];
    
    __block __weak typeof(self) weakSelf = self;
    [self.view.noDataStatusView bindDataStatusItem:[INDefaultDataStatus defaultNoDataItem:^{
        NSLog(@"no Data Touched");
        [weakSelf statusDidTouched];
    }]];
    
    [self.view.netErrorStatusView bindDataStatusItem:[INDefaultDataStatus defaultNetErrorItem:^{
        NSLog(@"net Error Touched");
        [weakSelf statusDidTouched];
    }]];
    
    self.view.loadingView = [INDefaultDataStatus dataLoadingView];
}

- (void)loadView {
    [super loadView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

#pragma mark - StatusBar style
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

- (BOOL)prefersStatusBarHidden {
    return NO;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return (toInterfaceOrientation == UIInterfaceOrientationPortrait);
}

- (BOOL)shouldAutorotate {
    return NO;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    NSLog(@"DEALLOCBaseViewController");
}

@end
