//
//  UIView+DataStatus.m
//  Mailepai
//
//  Created by Bruce on 2019/10/18.
//  Copyright © Mailepai. All rights reserved.
//

#import "UIView+DataStatus.h"
#import "INDataStatusView.h"
#import "INDataStatusLoadingView.h"
#import <objc/runtime.h>

#define kNoDataStatusViewTag 100
#define kNetErrorStatusViewTag 101
#define kLoadingStatusViewTag 102

/**
 此类用于处理加载进度与数据为空、网络问题等提示
 */
static const void *kNoDataStatusKey = &kNoDataStatusKey;
static const void *kNetErrorStatusKey = &kNetErrorStatusKey;
static const void *kLoadingStatusKey = &kLoadingStatusKey;
static const void *kDataStatusEdgeInsetKey = &kDataStatusEdgeInsetKey;
static const void *kDataStatusOriginSizeKey = &kDataStatusOriginSizeKey;

static const void *kBeforeViewNameKey = &kBeforeViewNameKey;

@implementation UIView (DataStatus)

#pragma mark - 无数据状态占位图
- (void)setNoDataStatusView:(INDataStatusView *)noDataStatusView{
    if (noDataStatusView != self.noDataStatusView) {
        noDataStatusView.tag = kNoDataStatusViewTag;
        objc_setAssociatedObject(self, kNoDataStatusKey, noDataStatusView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
        for (UIView *view in self.subviews) {
            if ([view isKindOfClass:[INDataStatusView class]]
                && view.tag == kNoDataStatusViewTag) {
                [view removeFromSuperview];
            }
        }
        
        [self addSubview:self.noDataStatusView];
        self.noDataStatusView.hidden = YES;
    }
    [self layout];
}

- (INDataStatusView *)noDataStatusView{
    return objc_getAssociatedObject(self, kNoDataStatusKey);
}

#pragma mark - 网络异常状态占位图
- (void)setNetErrorStatusView:(INDataStatusView *)netErrorStatusView{
    if (netErrorStatusView != self.netErrorStatusView) {
        netErrorStatusView.tag = kNetErrorStatusViewTag;
        objc_setAssociatedObject(self, kNetErrorStatusKey, netErrorStatusView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
        for (UIView *view in self.subviews) {
            if ([view isKindOfClass:[INDataStatusView class]]
                && view.tag == kNetErrorStatusViewTag) {
                [view removeFromSuperview];
            }
        }
        [self addSubview:self.netErrorStatusView];
        self.netErrorStatusView.hidden = YES;
    }
    [self layout];
}

- (INDataStatusView *)netErrorStatusView{
    return objc_getAssociatedObject(self, kNetErrorStatusKey);
}

#pragma mark - 显示加载中的提示
- (void)setLoadingView:(INDataStatusLoadingView *)loadingView {
    if (loadingView != self.loadingView) {
        loadingView.tag = kLoadingStatusViewTag;
        objc_setAssociatedObject(self, kLoadingStatusKey, loadingView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
        for (UIView *view in self.subviews) {
            if ([view isKindOfClass:[INDataStatusLoadingView class]]
                && view.tag == kLoadingStatusViewTag) {
                [view removeFromSuperview];
            }
        }
        [self addSubview:self.loadingView];
        self.loadingView.hidden = YES;
    }
    [self layout];
}

- (INDataStatusLoadingView *)loadingView {
    return objc_getAssociatedObject(self, kLoadingStatusKey);
}

#pragma mark - 在之上的控件
- (NSString *)beforeViewName {
    return objc_getAssociatedObject(self, kBeforeViewNameKey);
}

- (void)setBeforeViewName:(NSString *)beforeViewName {
    objc_setAssociatedObject(self, kBeforeViewNameKey, beforeViewName, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - 上下左右间距
- (void)setEdgeInset:(UIEdgeInsets)edgeInset {
    NSString *edgeString = NSStringFromUIEdgeInsets(edgeInset);
    objc_setAssociatedObject(self, kDataStatusEdgeInsetKey, edgeString, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self layout];
}

- (UIEdgeInsets)edgeInset {
    NSString *edgeString = objc_getAssociatedObject(self, kDataStatusEdgeInsetKey);
    return UIEdgeInsetsFromString(edgeString);
}

#pragma mark - 大小Size
- (void)setStatusOriginSize:(CGSize)statusOriginSize {
    NSString *sizeString = NSStringFromCGSize(statusOriginSize);
    objc_setAssociatedObject(self, kDataStatusOriginSizeKey, sizeString, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self layout];
}


- (CGSize)statusOriginSize{
    NSString *sizeString = objc_getAssociatedObject(self, kDataStatusOriginSizeKey);
    return CGSizeFromString(sizeString);
}

/*
 布局排列layout的
 */
- (void)layout {
    UIEdgeInsets edgeInset = [self edgeInset];
    CGSize size = [self statusOriginSize];
    CGRect frame = CGRectMake(edgeInset.left, edgeInset.top, size.width - edgeInset.left - edgeInset.right, size.height - edgeInset.top - edgeInset.bottom);
    
    NSLog(@"frame:%@",NSStringFromCGRect(frame));
    
    if (self.noDataStatusView) {
        self.noDataStatusView.frame = frame;
    }
    
    if (self.netErrorStatusView) {
        self.netErrorStatusView.frame = frame;
    }
    
    if (self.loadingView) {
        self.loadingView.frame = frame;
        self.loadingView.originCenter = CGPointMake(frame.size.width/2.0, frame.size.height/2.0);
    }
}

- (void)showFrontStatusView {
    if (self.noDataStatusView) {
        [self bringSubviewToFront:self.noDataStatusView];
    }
    
    if (self.netErrorStatusView) {
        [self bringSubviewToFront:self.netErrorStatusView];
    }
    
    if (self.loadingView) {
        [self bringSubviewToFront:self.loadingView];
    }
}

/*
 显示加载进度
 */
- (void)showStartLoading {
    [self showFrontStatusView];
    self.noDataStatusView.hidden = YES;
    self.netErrorStatusView.hidden = YES;
    self.loadingView.hidden = NO;
    
    [self.loadingView displayPrecent:1.0];
    [self.loadingView startAnimation];
}

/*
 隐藏加载进度
 */
- (void)dismissLoadingView {
    [self showFrontStatusView];
    self.loadingView.hidden = YES;
    [self.loadingView displayPrecent:1.0];
    [self.loadingView stopAnimation];
    
    NSLog(@"noDataStatusView:%@",self.noDataStatusView);
    NSLog(@"netErrorStatusView:%@",self.netErrorStatusView);
    NSLog(@"loadingView:%@",self.loadingView);
}

/*
 显示无数据提示
 */
- (void)showNoDataStatus {
    [self showFrontStatusView];
    self.noDataStatusView.hidden = NO;
    
    self.netErrorStatusView.hidden = YES;
    self.loadingView.hidden = YES;
    [self dismissLoadingView];
}

/*
 显示网络异常提示
 */
- (void)showNetErrorStatus {
    [self showFrontStatusView];
    self.noDataStatusView.hidden = YES;
    self.netErrorStatusView.hidden = NO;
    self.loadingView.hidden = YES;
    [self dismissLoadingView];
}

/*
 隐藏
 */
- (void)dismissAllStatusView {
    [self showFrontStatusView];
    self.noDataStatusView.hidden = YES;
    self.netErrorStatusView.hidden = YES;
    self.loadingView.hidden = YES;
    [self dismissLoadingView];
}

@end
