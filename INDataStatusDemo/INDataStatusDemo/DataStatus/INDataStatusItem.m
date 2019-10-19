//
//  INDataStatusItem.m
//  Mailepai
//
//  Created by Bruce on 2019/10/18.
//  Copyright © Mailepai. All rights reserved.
//

#import "INDataStatusItem.h"

#pragma mark -
#pragma mark - 此类用于显示的加载失败/无数据的时候的样式
/**
 此类用于显示的加载失败/无数据的时候的样式
 */
@implementation INDataStatusItem

+ (INDataStatusItem *)defaultDataStatusItem {
    INDataStatusItem *statusDataItem = [[INDataStatusItem alloc] init];
    statusDataItem.bgColor = [UIColor clearColor];
    statusDataItem.bgImage = nil;
    
    statusDataItem.startLoading = YES;
    statusDataItem.loadingBGColor = [UIColor clearColor];
    
    statusDataItem.title = @"";
    statusDataItem.titleColor = [UIColor colorWithHexString:@"333333"];
    
    statusDataItem.detail = @"";
    statusDataItem.detailColor = [UIColor colorWithHexString:@"999999"];
    
    statusDataItem.iconImage = nil;
    
    statusDataItem.hasBtn = NO;
    statusDataItem.title = @"";
    statusDataItem.btnTitleColor = [UIColor colorWithHexString:@"3b93ff" alpha:0.55];
    statusDataItem.btnHighlightTitleColor = [UIColor colorWithHexString:@"3b93ff" alpha:0.55];
    statusDataItem.btnBgColor = [UIColor clearColor];
    statusDataItem.btnHeight = 20.0;
    
    return statusDataItem;
}

@end
