//
//  INDataStatusLoadingView.h
//  Mailepai
//
//  Created by Bruce on 2019/10/18.
//  Copyright © Mailepai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface INDataStatusLoadingView : UIView

@property (nonatomic, assign) CGPoint originCenter;

- (void)displayPrecent:(CGFloat)precent;

- (void)startAnimation;

- (void)stopAnimation;

@end
