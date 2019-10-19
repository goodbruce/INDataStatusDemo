//
//  INDataStatusLoadingView.m
//  Mailepai
//
//  Created by Bruce on 2019/10/18.
//  Copyright © Mailepai. All rights reserved.
//

#import "INDataStatusLoadingView.h"
#import "UIColor+Addition.h"

static CGFloat kBallSize = 12.0;
static CGFloat kDistance = 15.0;

@interface INDataStatusLoadingView ()

@property (nonatomic, strong) UIImageView *aballImageView;
@property (nonatomic, strong) UIImageView *bballImageView;

@end

@implementation INDataStatusLoadingView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.aballImageView];
        [self addSubview:self.bballImageView];
        [self layoutBallFrame];
    }
    return self;
}

- (void)layoutBallFrame {
    self.aballImageView.center = self.originCenter;
    self.bballImageView.center = self.originCenter;
}

- (void)setOriginCenter:(CGPoint)originCenter {
    _originCenter = originCenter;
    [self layoutBallFrame];
}

- (void)displayPrecent:(CGFloat)precent {
    if (precent < 0) {
        precent = 0;
    }
    
    if (precent > 1.0) {
        precent = 1.0;
    }
    
    CGPoint centerCenter = self.originCenter;
    CGPoint aBallCenter = self.aballImageView.center;
    CGPoint bBallCenter = self.bballImageView.center;
    
    aBallCenter.x = centerCenter.x - precent*kDistance;
    self.aballImageView.center = aBallCenter;
    self.aballImageView.transform = CGAffineTransformMakeScale(precent, precent);
    
    bBallCenter.x = centerCenter.x + precent*kDistance;
    self.bballImageView.center = bBallCenter;
    self.bballImageView.transform = CGAffineTransformMakeScale(precent, precent);
}

- (void)startAnimation {
    CGPoint centerCenter = self.originCenter;
    CGFloat leftCenter = self.originCenter.x - kDistance;
    CGFloat rightCenter = self.originCenter.x + kDistance;
    
    [self showAnimation:self.aballImageView from:CGPointMake(leftCenter, centerCenter.y) toPosition:CGPointMake(rightCenter, centerCenter.y)];
    [self showAnimation:self.bballImageView from:CGPointMake(rightCenter, centerCenter.y) toPosition:CGPointMake(leftCenter, centerCenter.y)];
}

- (void)stopAnimation {
    [self.aballImageView.layer removeAnimationForKey:@"animationGroup"];
    [self.bballImageView.layer removeAnimationForKey:@"animationGroup"];
}

- (void)showAnimation:(UIView *)view from:(CGPoint)from toPosition:(CGPoint)to {
    CAMediaTimingFunction *defaultCurve = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    
    CAAnimationGroup *animationGroup;
    animationGroup = [CAAnimationGroup animation];
    animationGroup.removedOnCompletion = NO;
    animationGroup.timingFunction = defaultCurve;
    animationGroup.fillMode = kCAFillModeBoth;
    animationGroup.beginTime = CACurrentMediaTime();
    animationGroup.duration = 0.5;
    animationGroup.repeatCount = MAXFLOAT;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    animation.fromValue = [NSValue valueWithCGPoint:from];
    animation.toValue = [NSValue valueWithCGPoint:to]; // 终了帧
    
    CAKeyframeAnimation *scaleAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale.xy"];
    scaleAnimation.values = @[@1.0,@0.5,@1.0];
    scaleAnimation.keyTimes = @[@0.0,@0.5,@1.0];
    
    NSArray *animations = @[animation,scaleAnimation];
    
    animationGroup.animations = animations;
    
    [view.layer addAnimation:animationGroup forKey:@"animationGroup"];
}

#pragma mark - SETTER/GETTER
- (UIImageView *)aballImageView {
    if (!_aballImageView) {
        _aballImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, kBallSize, kBallSize)];
        _aballImageView.clipsToBounds = YES;
        _aballImageView.userInteractionEnabled = YES;
        _aballImageView.backgroundColor = [UIColor colorWithHexString:@"ff7e48"];
        _aballImageView.layer.cornerRadius = kBallSize/2;
        _aballImageView.layer.masksToBounds = YES;
    }
    return _aballImageView;
}

- (UIImageView *)bballImageView {
    if (!_bballImageView) {
        _bballImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, kBallSize, kBallSize)];
        _bballImageView.clipsToBounds = YES;
        _bballImageView.userInteractionEnabled = YES;
        _bballImageView.backgroundColor = [UIColor colorWithHexString:@"fe4373"];
        _bballImageView.layer.cornerRadius = kBallSize/2;
        _bballImageView.layer.masksToBounds = YES;
    }
    return _bballImageView;
}

@end
