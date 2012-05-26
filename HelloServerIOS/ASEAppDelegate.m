#import "ASEAppDelegate.h"

#import "ASEHelloServer.h"

@interface ASEAppDelegate ()

@property (nonatomic, strong) ASEHelloServer * helloServer;

@end

@implementation ASEAppDelegate

@synthesize window;

@synthesize helloServer;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    helloServer = [ASEHelloServer new];

    return YES;
}

-(void)applicationDidBecomeActive:(UIApplication *)application
{
    if(!helloServer) {
        helloServer = [ASEHelloServer new];
    }
}

-(void)applicationWillResignActive:(UIApplication *)application
{
    helloServer = nil;
}

-(void)applicationWillTerminate:(UIApplication *)application
{
    helloServer = nil;
}

@end
