//
//  INDataStatusView.m
//  Mailepai
//
//  Created by Bruce on 2019/10/18.
//  Copyright © Mailepai. All rights reserved.
//

#import "INDataStatusView.h"
#import "NSString+Size.h"

@implementation INDataStatusView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        [self addSubview:self.backgroundView];
        [self.backgroundView addSubview:self.contentView];
        [self.contentView addSubview:self.imageView];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.detailLabel];
        [self.contentView addSubview:self.button];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
        [self addGestureRecognizer:tapGesture];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.backgroundView.frame = self.bounds;
    
    if (self.customView) {
        CGFloat customWidth = self.customView.frame.size.width;
        CGFloat customHeight = self.customView.frame.size.height;
        
        self.customView.frame = CGRectMake(0.0, 0.0, customWidth, customHeight);
        
        CGPoint customCenter = CGPointMake(self.backgroundView.center.x, self.backgroundView.center.y + self.dataStatusItem.verticalTopOffset);
        self.customView.center = customCenter;
        return;
    }
    
    self.contentView.frame = CGRectMake(0.0, self.dataStatusItem.verticalTopOffset, CGRectGetWidth(self.backgroundView.frame), CGRectGetHeight(self.backgroundView.frame) - self.dataStatusItem.verticalTopOffset);
    
    CGFloat width = CGRectGetWidth([UIScreen mainScreen].bounds);
    CGFloat padding = roundf(width/16.0);
    
    CGFloat factPadding = width*padding/375.0;
    
    CGFloat imageTopPadding = 0.0;
    CGFloat titleTopPadding = 0.0;
    CGFloat descTopPadding = 0.0;
    CGFloat btnTopPadding = 0.0;
    if (self.dataStatusItem.iconImage) {
        titleTopPadding = self.dataStatusItem.verticalPadding;
    }
    
    if (self.dataStatusItem.title && self.dataStatusItem.title.length > 0) {
        descTopPadding = self.dataStatusItem.verticalPadding;
    }
    
    if (self.dataStatusItem.detail && self.dataStatusItem.detail.length > 0) {
        btnTopPadding = self.dataStatusItem.verticalPadding;
    }
    
    CGFloat contentWidth = CGRectGetWidth(self.contentView.frame) - 2*factPadding;
    
    CGSize titleSize = [self.dataStatusItem.title sizeWithFont:self.titleLabel.font forMaxSize:CGSizeMake(contentWidth, MAXFLOAT)];
    
    CGSize descSize = [self.dataStatusItem.detail sizeWithFont:self.detailLabel.font forMaxSize:CGSizeMake(contentWidth, MAXFLOAT)];
    
    CGFloat topPadding = (CGRectGetHeight(self.contentView.frame) - (self.dataStatusItem.iconImage.size.height + imageTopPadding + titleSize.height+titleTopPadding + descSize.height + descTopPadding + btnTopPadding + self.dataStatusItem.btnHeight))/2;
    
    self.imageView.frame = CGRectMake(MAX((CGRectGetWidth(self.contentView.frame) - self.dataStatusItem.iconImage.size.width)/2, 0.0), topPadding, self.dataStatusItem.iconImage.size.width, self.dataStatusItem.iconImage.size.height);
    
    self.titleLabel.frame = CGRectMake(factPadding, CGRectGetMaxY(self.imageView.frame) + titleTopPadding, CGRectGetWidth(self.contentView.frame) - 2*factPadding, titleSize.height);
    
    self.detailLabel.frame = CGRectMake(factPadding, CGRectGetMaxY(self.titleLabel.frame) + descTopPadding, CGRectGetWidth(self.contentView.frame) - 2*factPadding, descSize.height);
    
    self.button.frame = CGRectMake(factPadding, CGRectGetMaxY(self.detailLabel.frame) + btnTopPadding, CGRectGetWidth(self.contentView.frame) - 2*factPadding, self.dataStatusItem.btnHeight);
}

- (void)bindDataStatusItem:(INDataStatusItem *)item {
    self.dataStatusItem = item;
    
    self.backgroundView.image = nil;
    self.backgroundView.backgroundColor = [UIColor clearColor];
    if (self.dataStatusItem.bgImage) {
        self.backgroundView.image = self.dataStatusItem.bgImage;
    } else {
        self.backgroundView.backgroundColor = self.dataStatusItem.bgColor;
    }
    
    self.imageView.image = self.dataStatusItem.iconImage;
    
    self.titleLabel.text = (self.dataStatusItem.title?self.dataStatusItem.title:@"");
    self.titleLabel.textColor = self.dataStatusItem.titleColor;
    
    self.detailLabel.textColor = self.dataStatusItem.detailColor;
    self.detailLabel.text = (self.dataStatusItem.detail?self.dataStatusItem.detail:@"");
    
    self.button.hidden = !self.dataStatusItem.hasBtn;
    [self.button setTitle:self.dataStatusItem.btnTitle forState:UIControlStateNormal];
    [self.button setTitleColor:self.dataStatusItem.btnTitleColor forState:UIControlStateNormal];
    [self.button setBackgroundColor:self.dataStatusItem.btnBgColor];
    
    self.contentView.alpha = 1.0;
    
    [self setNeedsLayout];
}

- (void)setCustomView:(UIView *)customView {
    _customView = customView;
    [self.backgroundView addSubview:self.customView];
    self.contentView.alpha = 0.0;
    
    [self setNeedsLayout];
}

#pragma mark - GESTURE
- (void)tapAction {
    if (self.dataStatusItem && self.dataStatusItem.action) {
        self.dataStatusItem.action();
    }
}

- (void)buttonAction {
    if (self.dataStatusItem && self.dataStatusItem.action) {
        self.dataStatusItem.action();
    }
}

#pragma mark - SETTER/GETTER

- (UIImageView *)backgroundView {
    if (!_backgroundView) {
        _backgroundView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _backgroundView.backgroundColor = [UIColor clearColor];
        _backgroundView.contentMode = UIViewContentModeScaleAspectFill;
        _backgroundView.userInteractionEnabled = YES;
    }
    return _backgroundView;
}

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:CGRectZero];
        _contentView.backgroundColor = [UIColor clearColor];
        _contentView.userInteractionEnabled = YES;
    }
    return _contentView;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _imageView.backgroundColor = [UIColor clearColor];
    }
    return _imageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.backgroundColor = [UIColor clearColor];
        
        _titleLabel.font = [UIFont systemFontOfSize:18.0];
        _titleLabel.textColor = [UIColor clearColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}

- (UILabel *)detailLabel {
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _detailLabel.backgroundColor = [UIColor clearColor];
        
        _detailLabel.font = [UIFont systemFontOfSize:14.0];
        _detailLabel.textColor = [UIColor clearColor];
        _detailLabel.textAlignment = NSTextAlignmentCenter;
        _detailLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _detailLabel.numberOfLines = 0;
    }
    return _detailLabel;
}

- (UIButton *)button {
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.backgroundColor = [UIColor clearColor];
        _button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [_button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
        [_contentView addSubview:_button];
    }
    return _button;
}

@end
