#import "DankstormController.h"

@implementation DankstormController

- (id)init {
	if (self = [super init]) {
		window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        window.windowLevel = 100000;

		NSURL *audioURL = [NSURL URLWithString:@"/Library/Activator/Listeners/com.thomasfinch.mlgios/Sounds/darudedankstorm.mp3"];
	    NSError *error = nil;
	    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:audioURL error:&error];
	    audioPlayer.delegate = self;
	        
	    if (!audioPlayer && error) {
	    	NSLog(@"ERROR: %@", error);
	    	return nil;
	    }

	    [audioPlayer prepareToPlay];
	}
	return self;
}

- (void)startWithCompletion:(void (^)())completion {
	[audioPlayer play];
	window.hidden = NO;

	FLAnimatedImage *explosionImage = [FLAnimatedImage animatedImageWithGIFData:[NSData dataWithContentsOfFile:@"/Library/Activator/Listeners/com.thomasfinch.mlgios/Images/explosion.gif"]];
	FLAnimatedImageView *explosionImageView = [[FLAnimatedImageView alloc] init];
	explosionImageView.animatedImage = explosionImage;
	explosionImageView.frame = CGRectMake(0, window.frame.size.height/4, window.frame.size.width, window.frame.size.height/2);
	[window addSubview:explosionImageView];

	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
	    [explosionImageView removeFromSuperview];
	    [explosionImageView release];
	    [self mtndewDoritosIlluminatiPart];
	});

	[self performSelector:@selector(hitmarkerPart) withObject:nil afterDelay:4.0];
	[self performSelector:@selector(snoopDoggPart) withObject:nil afterDelay:14.5];
	[self performSelector:@selector(buildupPart) withObject:nil afterDelay:7.7];

	if (completionBlock)
        Block_release(completionBlock);
	completionBlock = Block_copy(completion);
}

- (void)mtndewDoritosIlluminatiPart {
	__block UIImageView *mtnDew1, *mtnDew2, *doritos1, *doritos2, *illuminati;
	CGRect bounds = [UIScreen mainScreen].bounds;
	float delay = 0.09;

	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0), dispatch_get_main_queue(), ^{
	    mtnDew1 = [[UIImageView alloc] initWithImage:[UIImage imageWithData:[NSData dataWithContentsOfFile:@"/Library/Activator/Listeners/com.thomasfinch.mlgios/Images/mountaindew.png"]]];
	    mtnDew1.frame = CGRectInset(CGRectMake(0, 0, bounds.size.width/2, bounds.size.height/2), 30, 30);
	    [window addSubview:mtnDew1];
	});

	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, delay * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
	   	doritos1 = [[UIImageView alloc] initWithImage:[UIImage imageWithData:[NSData dataWithContentsOfFile:@"/Library/Activator/Listeners/com.thomasfinch.mlgios/Images/doritos.png"]]];
	   	doritos1.frame = CGRectInset(CGRectMake(bounds.size.width/2, 0, bounds.size.width/2, bounds.size.height/2), 30, 30);
	   	[window addSubview:doritos1];
	});

	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2*delay * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
	    doritos2 = [[UIImageView alloc] initWithImage:[UIImage imageWithData:[NSData dataWithContentsOfFile:@"/Library/Activator/Listeners/com.thomasfinch.mlgios/Images/doritos.png"]]];
	    doritos2.frame = CGRectInset(CGRectMake(0, bounds.size.height/2, bounds.size.width/2, bounds.size.height/2), 30, 30);
	    [window addSubview:doritos2];
	});

	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 3*delay * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
	    mtnDew2 = [[UIImageView alloc] initWithImage:[UIImage imageWithData:[NSData dataWithContentsOfFile:@"/Library/Activator/Listeners/com.thomasfinch.mlgios/Images/mountaindew.png"]]];
	    mtnDew2.frame = CGRectInset(CGRectMake(bounds.size.width/2, bounds.size.height/2, bounds.size.width/2, bounds.size.height/2), 30, 30);
	    [window addSubview:mtnDew2];
	});

	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 4*delay * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
	    illuminati = [[UIImageView alloc] initWithImage:[UIImage imageWithData:[NSData dataWithContentsOfFile:@"/Library/Activator/Listeners/com.thomasfinch.mlgios/Images/Illuminati.jpg"]]];
	    illuminati.frame = CGRectInset(CGRectMake(0, 0, bounds.size.width, bounds.size.height), 80, 120);
	    [window addSubview:illuminati];
	});

	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 5*delay * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
	    [mtnDew1 removeFromSuperview];
	    [mtnDew1 release];
	    [mtnDew2 removeFromSuperview];
	    [mtnDew2 release];
	    [doritos1 removeFromSuperview];
	    [doritos1 release];
	    [doritos2 removeFromSuperview];
	    [doritos2 release];
	    [illuminati removeFromSuperview];
	    [illuminati release];

	    [self dancingPart];
	});
}

- (void)dancingPart {
	FLAnimatedImage *bluesCluesImage = [FLAnimatedImage animatedImageWithGIFData:[NSData dataWithContentsOfFile:@"/Library/Activator/Listeners/com.thomasfinch.mlgios/Images/dancingwithchicken.gif"]];
	FLAnimatedImageView *bluesCluesImageView = [[FLAnimatedImageView alloc] init];
	bluesCluesImageView.animatedImage = bluesCluesImage;
	bluesCluesImageView.frame = CGRectMake(0, 50, window.frame.size.width, window.frame.size.height/3);
	[window addSubview:bluesCluesImageView];

	FLAnimatedImage *kidDancingImage = [FLAnimatedImage animatedImageWithGIFData:[NSData dataWithContentsOfFile:@"/Library/Activator/Listeners/com.thomasfinch.mlgios/Images/kiddancing.gif"]];
	FLAnimatedImageView *kidDancingImageView = [[FLAnimatedImageView alloc] init];
	kidDancingImageView.animatedImage = kidDancingImage;
	kidDancingImageView.frame = CGRectMake(0, window.frame.size.height*2/3, window.frame.size.width, window.frame.size.height/3);
	[window addSubview:kidDancingImageView];

	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 3.2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
	    [bluesCluesImageView removeFromSuperview];
	    [bluesCluesImageView release];
	    [kidDancingImageView removeFromSuperview];
	    [kidDancingImageView release];
	});
}

- (void)hitmarkerPart {
	NSMutableArray *arr = [[NSMutableArray alloc] init];

	int numMarkers = 20;
	for (int i = 0; i < numMarkers; i++) {
		UIImageView *hitmarkerView = [[UIImageView alloc] initWithImage:[UIImage imageWithData:[NSData dataWithContentsOfFile:@"/Library/Activator/Listeners/com.thomasfinch.mlgios/Images/hitmarker.png"]]];
		CGFloat xCoord = (arc4random() % (int)([UIScreen mainScreen].bounds.size.width + 100)) - 100;
		CGFloat yCoord = (arc4random() % (int)([UIScreen mainScreen].bounds.size.height + 100)) - 100;
		hitmarkerView.frame = CGRectMake(xCoord, yCoord, 100, 100);
		[arr addObject:hitmarkerView];
		dispatch_after(dispatch_time(DISPATCH_TIME_NOW, ((0.75/numMarkers)*i) * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
		    [window addSubview:hitmarkerView];
		});
	}

	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.75 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
	    //Release all hitmarker views
	    for (int i = 0; i < [arr count]; i++) {
	    	[((UIView*)arr[i]) removeFromSuperview];
	    	[((UIView*)arr[i]) release];
	    }
	    [self performSelector:@selector(sanicPart) withObject:nil afterDelay:0.15];
	    [self sanicPart];
	});
}

- (void)sanicPart {
	UIImageView *sanic = [[UIImageView alloc] initWithImage:[UIImage imageWithData:[NSData dataWithContentsOfFile:@"/Library/Activator/Listeners/com.thomasfinch.mlgios/Images/sanic.png"]]];
	sanic.frame = CGRectMake(50, 50, 200, 200);

	int locationCount = 100;

	[window addSubview:sanic];

	[UIView animateKeyframesWithDuration:3.0 delay:0 options:nil animations:^ {
		for (int i = 0; i < locationCount; i++) {
			[UIView addKeyframeWithRelativeStartTime:i*(3.0/locationCount) relativeDuration:2.45/locationCount animations:^{
				CGFloat xCoord = (arc4random() % (int)[UIScreen mainScreen].bounds.size.width);
				CGFloat yCoord = (arc4random() % (int)[UIScreen mainScreen].bounds.size.height);
				sanic.center = CGPointMake(xCoord, yCoord);
		    }];
		}
	} completion:nil];


	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2.45 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
		[sanic removeFromSuperview];
		[sanic release];
	});
}

- (void)buildupPart {
	FLAnimatedImage *roundWinningKill = [FLAnimatedImage animatedImageWithGIFData:[NSData dataWithContentsOfFile:@"/Library/Activator/Listeners/com.thomasfinch.mlgios/Images/roundwinningkill.gif"]];
	FLAnimatedImageView *winningKillView = [[FLAnimatedImageView alloc] init];
	winningKillView.animatedImage = roundWinningKill;
	winningKillView.frame = [UIScreen mainScreen].bounds;
	[window addSubview:winningKillView];

	// UIImageView *illuminati = [[UIImageView alloc] initWithImage:[UIImage imageWithData:[NSData dataWithContentsOfFile:@"/Library/Activator/Listeners/com.thomasfinch.mlgios/Images/Illuminati.jpg"]]];
 //    illuminati.frame = CGRectInset(CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height), 80, 120);
 //    [window addSubview:illuminati];
	
	FLAnimatedImage *bluesClues = [FLAnimatedImage animatedImageWithGIFData:[NSData dataWithContentsOfFile:@"/Library/Activator/Listeners/com.thomasfinch.mlgios/Images/bluescluesdance.gif"]];
	FLAnimatedImageView *bluesCluesView = [[FLAnimatedImageView alloc] init];
	bluesCluesView.animatedImage = bluesClues;
	bluesCluesView.bounds = CGRectMake(0,0,[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height/3);
	bluesCluesView.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height/2);
	[window addSubview:bluesCluesView];

	FLAnimatedImage *quickscope = [FLAnimatedImage animatedImageWithGIFData:[NSData dataWithContentsOfFile:@"/Library/Activator/Listeners/com.thomasfinch.mlgios/Images/quickscope-small.gif"]];
	FLAnimatedImageView *quickscopeView = [[FLAnimatedImageView alloc] init];
	quickscopeView.animatedImage = quickscope;
	quickscopeView.bounds = CGRectMake(0,0,[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height/2);
	quickscopeView.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height/2);
	[window addSubview:quickscopeView];

	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 6.3 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
		[winningKillView removeFromSuperview];
	    [roundWinningKill release];
	    [winningKillView release];
	    [quickscopeView removeFromSuperview];
	    [quickscopeView release];
	    [quickscope release];
	    [bluesCluesView removeFromSuperview];
	    [bluesCluesView release];
	    [bluesClues release];
	    // [illuminati removeFromSuperview];
	    // [illuminati release];
	});
}

- (void)snoopDoggPart {
	UIView *flashingView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
	flashingView.alpha = 1.0;
	flashingView.backgroundColor = [UIColor greenColor];
	[window addSubview:flashingView];
	__block int count = 0;
	[UIView animateWithDuration:0.01 delay:0 options:UIViewAnimationOptionAutoreverse animations:^ {
	       [UIView setAnimationRepeatCount:10000];
	       if (count++ % 2 == 0)
	       	flashingView.alpha = 0.0;
	       else
	       	flashingView.alpha = 1.0;
	} completion:nil]; 

	VENSnowOverlayView *overlayView = [[VENSnowOverlayView alloc] initWithFrame:[UIScreen mainScreen].bounds];
	overlayView.flakeFileName = @"/Library/Activator/Listeners/com.thomasfinch.mlgios/Images/weedleaf.png";
	overlayView.flakeWidth = 50;
	overlayView.flakeHeight = 50;
	[window addSubview:overlayView];
	[overlayView beginSnowAnimation];

	FLAnimatedImage *snoopImage = [FLAnimatedImage animatedImageWithGIFData:[NSData dataWithContentsOfFile:@"/Library/Activator/Listeners/com.thomasfinch.mlgios/Images/snoopdogg.gif"]];
	FLAnimatedImageView *snoopImageView = [[FLAnimatedImageView alloc] init];
	snoopImageView.animatedImage = snoopImage;
	snoopImageView.frame = CGRectMake(0, window.frame.size.height/4, window.frame.size.width, window.frame.size.height/2);
	[window addSubview:snoopImageView];

	FLAnimatedImage *leftFrogImage = [FLAnimatedImage animatedImageWithGIFData:[NSData dataWithContentsOfFile:@"/Library/Activator/Listeners/com.thomasfinch.mlgios/Images/rainbowfrogleft.gif"]];
	FLAnimatedImageView *leftFrogView = [[FLAnimatedImageView alloc] init];
	leftFrogView.animatedImage = leftFrogImage;
	leftFrogView.frame = CGRectMake(window.frame.size.width-150, window.frame.size.height-150, 150, 150);
	[window addSubview: leftFrogView];

	FLAnimatedImage *rightFrogImage = [FLAnimatedImage animatedImageWithGIFData:[NSData dataWithContentsOfFile:@"/Library/Activator/Listeners/com.thomasfinch.mlgios/Images/rainbowfrogright.gif"]];
	FLAnimatedImageView *rightFrogView = [[FLAnimatedImageView alloc] init];
	rightFrogView.animatedImage = rightFrogImage;
	rightFrogView.frame = CGRectMake(0, window.frame.size.height-150, 150, 150);
	[window addSubview: rightFrogView];

	cleanupLastPart = Block_copy(^{
		[overlayView removeFromSuperview];
    	[overlayView release];
    	[snoopImageView removeFromSuperview];
    	[snoopImageView release];
    	[snoopImage release];
    	[flashingView removeFromSuperview];
    	[flashingView release];
    	[leftFrogView removeFromSuperview];
    	[leftFrogView release];
    	[leftFrogImage release];
    	[rightFrogView removeFromSuperview];
    	[rightFrogView release];
    	[rightFrogImage release];
	});
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    if (player == audioPlayer) {
    	window.hidden = YES;

    	cleanupLastPart();

        if (completionBlock)
            completionBlock();
    }
}

@end