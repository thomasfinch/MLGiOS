//
//  VLMHarlemShake.h
//  HarlemShakeDemo
//
//  Created by Zac White on 3/5/13.
//  Copyright (c) 2013 Velos Mobile. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VLMHarlemShake : NSObject

- (id)initWithRootView:(UIView*)rootView;
- (void)startShaking;
- (void)stopShaking;

@end
