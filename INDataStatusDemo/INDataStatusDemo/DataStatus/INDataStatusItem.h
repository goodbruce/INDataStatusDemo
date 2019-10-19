//
//  INDataStatusItem.h
//  Mailepai
//
//  Created by Bruce on 2019/10/18.
//  Copyright © Mailepai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UIColor+Addition.h"

#pragma mark -
#pragma mark - 此类用于显示的加载失败/无数据的时候的样式
/**
 此类用于显示的加载失败/无数据的时候的样式
 */
typedef void (^DFEmptyTouchedAction)(void);

@interface INDataStatusItem : NSObject

@property (nonatomic, strong) UIImage *bgImage;
@property (nonatomic, strong) UIColor *bgColor;
@property (nonatomic, strong) UIColor *loadingBGColor;

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) UIColor *titleColor;

@property (nonatomic, strong) NSString *detail;
@property (nonatomic, strong) UIColor *detailColor;

@property (nonatomic, strong) UIImage *iconImage;

@property (nonatomic, assign) BOOL hasBtn;
@property (nonatomic, strong) NSString *btnTitle;
@property (nonatomic, strong) UIColor *btnTitleColor;
@property (nonatomic, strong) UIColor *btnHighlightTitleColor;
@property (nonatomic, strong) UIColor *btnBgColor;
@property (nonatomic, assign) CGFloat btnHeight;
@property (nonatomic, copy) DFEmptyTouchedAction action;

@property (nonatomic, assign) CGFloat verticalPadding;   //子控件之间垂直间距
@property (nonatomic, assign) CGFloat verticalTopOffset; //距屏幕顶部的offset间距

@property (nonatomic, assign) BOOL startLoading;        //开始加载，显示加载控件

+ (INDataStatusItem *)defaultDataStatusItem;

@end
