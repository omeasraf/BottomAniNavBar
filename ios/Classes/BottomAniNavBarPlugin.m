#import "BottomAniNavBarPlugin.h"
#if __has_include(<bottom_ani_nav_bar/bottom_ani_nav_bar-Swift.h>)
#import <bottom_ani_nav_bar/bottom_ani_nav_bar-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "bottom_ani_nav_bar-Swift.h"
#endif

@implementation BottomAniNavBarPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftBottomAniNavBarPlugin registerWithRegistrar:registrar];
}
@end
