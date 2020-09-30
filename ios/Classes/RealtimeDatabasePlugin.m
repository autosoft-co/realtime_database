#import "RealtimeDatabasePlugin.h"
#if __has_include(<realtime_database/realtime_database-Swift.h>)
#import <realtime_database/realtime_database-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "realtime_database-Swift.h"
#endif

@implementation RealtimeDatabasePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftRealtimeDatabasePlugin registerWithRegistrar:registrar];
}
@end
