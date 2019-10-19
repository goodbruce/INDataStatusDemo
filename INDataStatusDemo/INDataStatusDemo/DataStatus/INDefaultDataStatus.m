//
//  INDefaultDataStatus.m
//  Mailepai
//
//  Created by Bruce on 2019/10/18.
//  Copyright © Mailepai. All rights reserved.
//

#import "INDefaultDataStatus.h"

@implementation INDefaultDataStatus

+ (INDataStatusLoadingView *)dataLoadingView {
    INDataStatusLoadingView *loadingView = [[INDataStatusLoadingView alloc] initWithFrame:CGRectZero];
    loadingView.backgroundColor = [UIColor whiteColor];
    return loadingView;
}

+ (INDataStatusView *)netErrorStatusView {
    INDataStatusView *netErrorView = [[INDataStatusView alloc] initWithFrame:CGRectZero];
    netErrorView.backgroundColor = [UIColor whiteColor];
    return netErrorView;
}

+ (INDataStatusView *)noDataStatusView {
    INDataStatusView *noDataView = [[INDataStatusView alloc] initWithFrame:CGRectZero];
    noDataView.backgroundColor = [UIColor whiteColor];
    return noDataView;
}

+ (INDataStatusItem *)defaultNoDataItem:(DFEmptyTouchedAction)action {
    INDataStatusItem *item = [INDataStatusItem defaultDataStatusItem];
    
    item.bgColor = [UIColor colorWithHexString:@"ffffff"];
    
    item.iconImage = [UIImage imageNamed:@"ic_no_data"];
    item.title = @"这里空空如也";
    
    item.detail = @"暂时没有数据了哦，这里空空 空空 空空 空空 空空如也";
    
    item.hasBtn = YES;
    item.btnTitle = @"重新获取";
    item.verticalTopOffset = -50.0;
    item.verticalPadding = 15.0;
    item.action = action;
    
    item.startLoading = YES;
    
    return item;
}

+ (INDataStatusItem *)defaultNetErrorItem:(DFEmptyTouchedAction)action {
    INDataStatusItem *item = [INDataStatusItem defaultDataStatusItem];
    
    item.bgColor = [UIColor colorWithHexString:@"ffffff"];
    
    item.iconImage = [UIImage imageNamed:@"ic_net_error"];
    item.title = @"网络出现异常";
    
    item.detail = @"链接失败，或者网络链接异常，请检查网络设置。";
    
    item.hasBtn = YES;
    item.btnTitle = @"重新获取";
    item.verticalTopOffset = -50.0;
    item.verticalPadding = 15.0;
    item.action = action;
    
    item.startLoading = YES;
    
    return item;
}

@end
