#import "ASEAppDelegate.h"

#import "ASEHelloServer.h"

@interface ASEAppDelegate ()

@property (nonatomic, strong) ASEHelloServer * helloServer;

@end

@implementation ASEAppDelegate

@synthesize window;

@synthesize helloServer;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    helloServer = [ASEHelloServer new];
}

-(void)applicationDidBecomeActive:(NSNotification *)notification
{
    if (!helloServer) {
        helloServer = [ASEHelloServer new];
    }
}

-(void)applicationWillTerminate:(NSNotification *)notification
{
    helloServer = nil;
}

-(BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender
{
    return YES;
}

@end
