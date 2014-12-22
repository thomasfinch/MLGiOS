//
//  VLMHarlemShake.m
//  HarlemShakeDemo
//
//  Created by Zac White on 3/5/13.
//  Copyright (c) 2013 Velos Mobile. All rights reserved.
//

#import "VLMHarlemShake.h"
#import <objc/runtime.h>

typedef enum {
    VLMShakeStyleOne = 0,
    VLMShakeStyleTwo,
    VLMShakeStyleThree,
    VLMShakeStyleEnd
} VLMShakeStyle;


@interface VLMHarlemShake ()

@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) NSMutableArray *shakingViews;
@property (nonatomic, assign) BOOL shaking;

//Finds views that we might want to shake
- (void)_findViewsOfInterestWithCallback:(void(^)(UIView *viewOfInterest))callback;
- (void)_findViewsOfInterestInView:(UIView *)rootView withCallback:(void(^)(UIView *viewOfInterest))callback;

//Actually shakes the view
- (void)_shakeView:(UIView *)view withShakeStyle:(VLMShakeStyle)style randomSeed:(CGFloat)seed;

//Animation creation methods
- (CAAnimation *)animationForStyleOneWithSeed:(CGFloat)seed;
- (CAAnimation *)animationForStyleTwoWithSeed:(CGFloat)seed;
- (CAAnimation *)animationForStyleThreeWithSeed:(CGFloat)seed;

@end

@implementation VLMHarlemShake

- (id)initWithRootView:(UIView*)rootView {
    [self init];
    if (self) {
        _topView = rootView;
    }
    return self;
}

- (id)init {
    if (self = [super init]) {
        _shakingViews = [NSMutableArray array];
        _shaking = NO;
    }
    return self;
}

- (void)startShaking
{
    if (_shaking) return;
    
    _shaking = YES;
    
    //Inspect the hierarchy
    _shakingViews = [[NSMutableArray array] retain];

    NSLog(@"START SHAKING");

    [self _findViewsOfInterestWithCallback:^(UIView *viewOfInterest) {
        [_shakingViews addObject:viewOfInterest];
        
        //Shake the view with a random animation
        [self _shakeView:viewOfInterest withShakeStyle:(rand() % VLMShakeStyleEnd) randomSeed:(arc4random() / (CGFloat)RAND_MAX)];
        //Shake it with another to create more animations
        [self _shakeView:viewOfInterest withShakeStyle:(rand() % VLMShakeStyleEnd) randomSeed:(arc4random() / (CGFloat)RAND_MAX)];
    }];
}

- (void)stopShaking {
    for (UIView *view in _shakingViews)
            [view.layer removeAllAnimations];
    _shaking = NO;
}

- (void)_findViewsOfInterestWithCallback:(void(^)(UIView *viewOfInterest))callback {
    //Find the top view
    UIView *top = _topView;
    while ([top superview]) {
        top = [top superview];
    }
    
    [self _findViewsOfInterestInView:top withCallback:callback];
}

- (void)_findViewsOfInterestInView:(UIView *)rootView withCallback:(void(^)(UIView *viewOfInterest))callback {
    for (UIView *view in [rootView subviews]) {
        
        if ([view respondsToSelector:@selector(_iconImageView)] ||
            [view isKindOfClass:[UILabel class]] ||
            [view isKindOfClass:[UIButton class]] ||
            [view isKindOfClass:[UIImageView class]] ||
            [view isKindOfClass:[UISwitch class]] ||
            [view isKindOfClass:[UITableViewCell class]] ||
            [view isKindOfClass:[UIProgressView class]] ||
            [view isKindOfClass:[UITextField class]] ||
            [view isKindOfClass:[UISlider class]] ||
            [view isKindOfClass:[UITextView class]]) {
            
            if (callback) callback(view);
            
        }
        else {
            [self _findViewsOfInterestInView:view withCallback:callback];
        }
    }
}

- (void)_shakeView:(UIView *)view withShakeStyle:(VLMShakeStyle)style randomSeed:(CGFloat)seed {
    if (style == VLMShakeStyleOne)
        [view.layer addAnimation:[self animationForStyleOneWithSeed:seed] forKey:@"styleOne"];
    else if (style == VLMShakeStyleTwo)
        [view.layer addAnimation:[self animationForStyleTwoWithSeed:seed] forKey:@"styleTwo"];
    else if (style == VLMShakeStyleThree)
        [view.layer addAnimation:[self animationForStyleThreeWithSeed:seed] forKey:@"styleThree"];
    
    _shaking = NO;
}

- (CAAnimation *)animationForStyleOneWithSeed:(CGFloat)seed {
    CAAnimationGroup *styleOneGroup = [CAAnimationGroup animation];
    
    CABasicAnimation *rotate = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    
    if (seed < 0.5) {
        rotate.fromValue = @(M_PI * 2);
        rotate.toValue = @(0);
    } else {
        rotate.fromValue = @(0);
        rotate.toValue = @(M_PI * 2);
    }
    
    rotate.duration = 0.1 * seed;
    
    CABasicAnimation *pop = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    
    pop.fromValue = @(1);
    pop.toValue = @(1.2);
    
    pop.beginTime = rotate.duration;
    
    pop.duration = 0.1 * seed;
    
    pop.autoreverses = YES;
    pop.repeatCount = 1;
    
    styleOneGroup.repeatCount = 1000;
    styleOneGroup.autoreverses = YES;
    styleOneGroup.duration = rotate.duration + pop.duration;
    styleOneGroup.animations = @[rotate, pop];
    
    return styleOneGroup;
}

- (CAAnimation *)animationForStyleTwoWithSeed:(CGFloat)seed {
    CAKeyframeAnimation *keyFrameShake = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    
    CGFloat negative = -1;
    if (seed < 0.5) {
        negative = 1;
    }
    
    CATransform3D startingScale = CATransform3DIdentity;
    CATransform3D secondScale = CATransform3DScale(CATransform3DIdentity, 1.0f + (seed * negative), 1.0f + (seed * negative), 1.0f);
    CATransform3D thirdScale = CATransform3DScale(CATransform3DIdentity, 1.0f + (seed * -negative), 1.0f + (seed * -negative), 1.0f);
    CATransform3D finalScale = CATransform3DIdentity;
    
    keyFrameShake.values = @[[NSValue valueWithCATransform3D:startingScale],
                             [NSValue valueWithCATransform3D:secondScale],
                             [NSValue valueWithCATransform3D:thirdScale],
                             [NSValue valueWithCATransform3D:finalScale]
                             ];
    
    keyFrameShake.keyTimes = @[@(0), @(0.4), @(0.7), @(1.0)];
    
    NSArray *timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut],
                                 [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                 [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                 ];
    
    keyFrameShake.timingFunctions = timingFunctions;
    
    keyFrameShake.duration = 0.1 * seed;
    keyFrameShake.repeatCount = 1000;
    
    return keyFrameShake;
}

- (CAAnimation *)animationForStyleThreeWithSeed:(CGFloat)seed {
    CAKeyframeAnimation *keyFrameShake = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation"];
    
    CGFloat negative = -1;
    if (seed < 0.5) {
        negative = 1;
    }
    
    NSInteger offsetOne = (NSInteger)((10.0 + 20.0 * seed) * negative);
    NSInteger offsetTwo = -offsetOne;
    
    NSValue *startingOffset = [NSValue valueWithCGSize:CGSizeZero];
    NSValue *firstOffset = [NSValue valueWithCGSize:CGSizeMake(offsetOne, 0)];
    NSValue *secondOffset = [NSValue valueWithCGSize:CGSizeMake(offsetTwo, 0)];
    NSValue *thirdOffset = [NSValue valueWithCGSize:CGSizeZero];
    NSValue *fourthOffset = [NSValue valueWithCGSize:CGSizeMake(0, offsetOne)];
    NSValue *fifthOffset = [NSValue valueWithCGSize:CGSizeMake(0, offsetTwo)];
    NSValue *finalOffset = [NSValue valueWithCGSize:CGSizeZero];
    
    keyFrameShake.values = @[startingOffset, firstOffset, secondOffset, thirdOffset, fourthOffset, fifthOffset, finalOffset];
    
    keyFrameShake.keyTimes = @[@(0), @(0.1), @(0.3), @(0.4), @(0.5), @(0.7), @(0.8), @(1.0)];
    
    NSArray *timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                 [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                 [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                 [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                 ];
    
    keyFrameShake.timingFunctions = timingFunctions;
    
    keyFrameShake.duration = 0.1 * seed;
    keyFrameShake.repeatCount = 1000;
    keyFrameShake.removedOnCompletion = YES;
    
    return keyFrameShake;
}

-(void)dealloc {
    [_shakingViews release];
    _shakingViews = nil;
    [super dealloc];
}

@end
