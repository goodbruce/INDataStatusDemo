//
//  UIView+DataStatus.h
//  Mailepai
//
//  Created by Bruce on 2019/10/18.
//  Copyright © Mailepai. All rights reserved.
//

#import <UIKit/UIKit.h>

@class INDataStatusView;
@class INDataStatusLoadingView;

@interface UIView (DataStatus)

/**
 无数据状态占位图
 */
@property (nonatomic, strong) INDataStatusView *noDataStatusView;

/*
 网络异常状态占位图
 */
@property (nonatomic, strong) INDataStatusView *netErrorStatusView;

/*
 显示加载中的提示
 */
@property (nonatomic, strong) INDataStatusLoadingView *loadingView;

/*
 状态控件不能覆盖着的View的name
 */
@property (nonatomic, strong) NSString *beforeViewName;

/*
 显示相对于superView的上下左右间距
 */
@property (nonatomic) UIEdgeInsets edgeInset;

/*
 显示的statusView的大小size
 */
@property (nonatomic) CGSize statusOriginSize;

/*
 显示加载进度
 */
- (void)showStartLoading;

/*
 隐藏加载进度
 */
- (void)dismissLoadingView;

/*
 显示无数据提示
 */
- (void)showNoDataStatus;

/*
 显示网络异常提示
 */
- (void)showNetErrorStatus;

/*
 隐藏
 */
- (void)dismissAllStatusView;

/*
 布局排列layout的
 */
- (void)layout;

@end
