//
//  INDemoShowViewController.m
//  INDataStatusDemo
//
//  Created by guobingwei on 2019/10/19.
//  Copyright © 2019年 bruce. All rights reserved.
//

#import "INDemoShowViewController.h"

@interface INDemoShowViewController ()

@end

@implementation INDemoShowViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.barTintColor = [UIColor colorWithHexString:@"131518"];
        self.tintColor = [UIColor colorWithHexString:@"131518"];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.barTintColor = self.barTintColor;
    self.navigationController.navigationBar.tintColor = self.tintColor;
    
    [self.navigationController.navigationBar setTitleTextAttributes: @{NSFontAttributeName:[UIFont boldSystemFontOfSize:19],NSForegroundColorAttributeName:self.tintColor}];
}

- (void)barItemAction {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = self.navTitle;
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_nav_l_back"] style:UIBarButtonItemStylePlain target:self action:@selector(barItemAction)];
    self.navigationItem.leftBarButtonItem = barItem;
    
    [self updateShowDataStyle];
    [self.view showStartLoading];
    [self performSelector:@selector(loadFinished) withObject:nil afterDelay:3.0];
}

- (void)updateShowDataStyle {
    __block __weak typeof(self) weakSelf = self;
    INDataStatusItem *statusItem = [INDefaultDataStatus defaultNoDataItem:^{
        NSLog(@"no Data Touched refresh");
        [weakSelf statusDidTouched];
    }];
    
    if ([@"Facy" isEqualToString:self.navTitle]) {
        statusItem.bgColor = rgb(242, 242, 242);
        statusItem.iconImage = [UIImage imageNamed:@"placeholder_fancy"];
        statusItem.hasBtn = NO;
        statusItem.title = @"No Owns yet";
        statusItem.detail = @"Tap Add to List And add things to Owns";
    } else if ([@"airbnb" isEqualToString:self.navTitle]) {
        statusItem.iconImage = [UIImage imageNamed:@"placeholder_airbnb"];
        statusItem.bgColor = rgb(255, 255, 255);
        statusItem.hasBtn = YES;
        statusItem.title = @"No Messages";
        statusItem.titleColor = [UIColor colorWithHexString:@"c9c9c9"];
        statusItem.detail = @"When you have messages, you’ll see them here.";
        statusItem.detailColor = [UIColor colorWithHexString:@"cfcfcf"];
        statusItem.btnTitle = @"Start Browsing";
    } else if ([@"Dropbox" isEqualToString:self.navTitle]) {
        statusItem.iconImage = [UIImage imageNamed:@"placeholder_dropbox"];
        statusItem.bgColor = rgb(240, 243, 245);
        statusItem.hasBtn = YES;
        statusItem.title = @"Star Your Favorite Files";
        statusItem.titleColor = [UIColor colorWithHexString:@"25282b"];
        statusItem.detail = @"Favorites are saved for offline access.";
        statusItem.btnTitle = @"Learn more";
    } else if ([@"instagram" isEqualToString:self.navTitle]) {
        statusItem.iconImage = [UIImage imageNamed:@"placeholder_instagram"];
        statusItem.bgColor = rgb(255, 255, 255);
        statusItem.hasBtn = NO;
        statusItem.title = @"Instagram Direct";
        statusItem.detail = @"Send photos and videos directly to your friends. Only the people you send to can see these posts.";
    } else if ([@"qq" isEqualToString:self.navTitle]) {
        statusItem.iconImage = [UIImage imageNamed:@"empty_qq"];
        statusItem.bgColor = rgb(246, 246, 246);
        statusItem.hasBtn = NO;
        statusItem.title = @"暂时没有新消息";
        statusItem.titleColor = [UIColor colorWithHexString:@"acacac"];
        statusItem.detail = @"";
    } else if ([@"yy" isEqualToString:self.navTitle]) {
        statusItem.iconImage = [UIImage imageNamed:@"empty_yy"];
        statusItem.bgColor = rgb(246, 246, 246);
        statusItem.hasBtn = YES;
        statusItem.title = @"您附近没有主播在开播哦";
        statusItem.titleColor = [UIColor colorWithHexString:@"373737"];
        statusItem.detail = @"";
        statusItem.btnTitle = @"刷新试试";
        statusItem.btnTitleColor = rgb(253, 213, 40);
    } else if ([@"jd" isEqualToString:self.navTitle]) {
        statusItem.iconImage = [UIImage imageNamed:@"empty_jd"];
        statusItem.bgColor = rgb(246, 246, 246);
        statusItem.hasBtn = YES;
        statusItem.title = @"网络请求失败";
        statusItem.titleColor = [UIColor colorWithHexString:@"777777"];
        statusItem.detail = @"请检查网络重新加载吧";
        statusItem.detailColor = [UIColor colorWithHexString:@"acacac"];
        statusItem.btnTitle = @"重新加载";
        statusItem.btnTitleColor = [UIColor colorWithHexString:@"787878"];
    }
    [self.view.noDataStatusView bindDataStatusItem:statusItem];
    
    [self.view.netErrorStatusView bindDataStatusItem:statusItem];
}

- (void)loadFinished {
    [self.view showNoDataStatus];
}

- (void)showNetError {
    [self.view showNetErrorStatus];
}

/*
 显示状态页面的点击效果
 */
- (void)statusDidTouched {
    [self.view showStartLoading];
    [self performSelector:@selector(showNetError) withObject:nil afterDelay:3.0];
}

@end
