// See http://iphonedevwiki.net/index.php/Logos

#if TARGET_OS_SIMULATOR
#error Do not support the simulator, please use the real iPhone Device.
#endif

#import <UIKit/UIKit.h>
#import "YztAlphaManager.h"

%hook UIWindow

- (void) makeKeyAndVisible
{
    %orig;
    [[YztAlphaManager sharedInstance] setup];
}

%end
