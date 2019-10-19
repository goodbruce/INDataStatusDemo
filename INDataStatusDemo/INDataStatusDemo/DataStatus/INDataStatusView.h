//
//  INDataStatusView.h
//  Mailepai
//
//  Created by Bruce on 2019/10/18.
//  Copyright © Mailepai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "INDataStatusItem.h"

@interface INDataStatusView : UIView

@property (nonatomic, strong) UIImageView *backgroundView;

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *detailLabel;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIButton *button;

@property (nonatomic, strong) UIView *customView;
@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;

@property (nonatomic, strong) INDataStatusItem *dataStatusItem;

- (void)bindDataStatusItem:(INDataStatusItem *)item;


@end
