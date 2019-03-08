#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"
@import Firebase;
#import "GoogleMaps/GoogleMaps.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [GMSServices provideAPIKey:@"AIzaSyAbI1Ts5egkGMSVQecqblO18YBPPTz2Q9Y"];
  [GeneratedPluginRegistrant registerWithRegistry:self];
  
    FIRApp* appInstance = [FIRApp defaultApp];
    if (appInstance == nil){
        [FIRApp configure];
    }
    else{
        
    }
    //[FIRApp configure];
  // Override point for customization after application launch.
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

@end
