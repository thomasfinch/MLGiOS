#import <libactivator/libactivator.h>
#import "Headers.h"
#import "VLMHarlemShake.h"
#import "DankstormController.h"

#ifndef DEBUG
	#define NSLog
#endif


@interface MLGiOSController : NSObject<LAListener> {
    VLMHarlemShake *harlemShake;
    DankstormController *dsController;
}
@end


@implementation MLGiOSController

- (void)activator:(LAActivator *)activator receiveEvent:(LAEvent *)event {
    NSLog(@"RECIEVED EVENT");

    UIView *initialView = nil;

    if ([event.mode isEqualToString:@"springboard"]) {
        NSArray *icons = [[(SBIconController*)[%c(SBIconController) sharedInstance] currentRootIconList] icons];
        initialView = [[%c(SBIconViewMap) homescreenMap] iconViewForIcon:[icons objectAtIndex:(arc4random() % [icons count])]];
    }
    
    if (initialView) {
    	NSLog(@"HAVE INITIAL VIEW, DOING ANIMATION");

        event.handled = YES;
        
        if (harlemShake) {
            [harlemShake release];
            harlemShake = nil;
        }

        if (!dsController) {
            dsController = [[DankstormController alloc] init];
        }
        
        harlemShake = [[VLMHarlemShake alloc] initWithRootView:initialView];
        [harlemShake startShaking];
        [dsController startWithCompletion:^void () {
            NSLog(@"DONE");
            [harlemShake stopShaking];
        }];
    }
}

// - (void)dealloc {
//     [harlemShake release];
//     [window release];
//     [dsController release];
//     [super dealloc];
// }


+ (void)load {
    if ([[[NSBundle mainBundle] bundleIdentifier] isEqualToString:@"com.apple.springboard"]) {
        [[LAActivator sharedInstance] registerListener:[MLGiOSController alloc] forName:@"com.thomasfinch.mlgios"];
    }
}

@end