#line 1 "/Users/easy/Desktop/app/YztAlphaDylib/YztAlpha/YztAlpha.xm"


#if TARGET_OS_SIMULATOR
#error Do not support the simulator, please use the real iPhone Device.
#endif

#import <UIKit/UIKit.h>
#import "YztAlphaManager.h"


#include <substrate.h>
#if defined(__clang__)
#if __has_feature(objc_arc)
#define _LOGOS_SELF_TYPE_NORMAL __unsafe_unretained
#define _LOGOS_SELF_TYPE_INIT __attribute__((ns_consumed))
#define _LOGOS_SELF_CONST const
#define _LOGOS_RETURN_RETAINED __attribute__((ns_returns_retained))
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif

@class UIWindow; 
static void (*_logos_orig$_ungrouped$UIWindow$makeKeyAndVisible)(_LOGOS_SELF_TYPE_NORMAL UIWindow* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$UIWindow$makeKeyAndVisible(_LOGOS_SELF_TYPE_NORMAL UIWindow* _LOGOS_SELF_CONST, SEL); 

#line 10 "/Users/easy/Desktop/app/YztAlphaDylib/YztAlpha/YztAlpha.xm"



static void _logos_method$_ungrouped$UIWindow$makeKeyAndVisible(_LOGOS_SELF_TYPE_NORMAL UIWindow* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    _logos_orig$_ungrouped$UIWindow$makeKeyAndVisible(self, _cmd);
    [[YztAlphaManager sharedInstance] setup];
}


static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$UIWindow = objc_getClass("UIWindow"); MSHookMessageEx(_logos_class$_ungrouped$UIWindow, @selector(makeKeyAndVisible), (IMP)&_logos_method$_ungrouped$UIWindow$makeKeyAndVisible, (IMP*)&_logos_orig$_ungrouped$UIWindow$makeKeyAndVisible);} }
#line 19 "/Users/easy/Desktop/app/YztAlphaDylib/YztAlpha/YztAlpha.xm"
