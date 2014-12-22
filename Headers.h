@interface SBLockScreenView
@property(retain, nonatomic) UIView *dateView;
@end

@interface SBLockScreenViewController
@end

@interface SBIconController
- (id)sharedInstance;
- (id)currentRootIconList;
@end

@interface SBIconViewMap
- (id)homescreenMap;
- (id)iconViewForIcon:(id)icon;
@end
