//
//  INDefaultDataStatus.h
//  Mailepai
//
//  Created by Bruce on 2019/10/18.
//  Copyright © Mailepai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIView+DataStatus.h"
#import "INDataStatusView.h"
#import "INDataStatusLoadingView.h"

@interface INDefaultDataStatus : NSObject

+ (INDataStatusLoadingView *)dataLoadingView;

+ (INDataStatusView *)netErrorStatusView;

+ (INDataStatusView *)noDataStatusView;

+ (INDataStatusItem *)defaultNoDataItem:(DFEmptyTouchedAction)action;

+ (INDataStatusItem *)defaultNetErrorItem:(DFEmptyTouchedAction)action;

@end
