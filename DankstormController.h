#include <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "VENSnowOverlayView.h"
#import "FLAnimatedImage.h"
#import "FLAnimatedImageView.h"

@interface DankstormController : NSObject <AVAudioPlayerDelegate> {
	AVAudioPlayer *audioPlayer;
	UIWindow *window;
	void (^completionBlock)();
	void (^cleanupLastPart)();
}

- (void)startWithCompletion:(void (^)())completion;

@end