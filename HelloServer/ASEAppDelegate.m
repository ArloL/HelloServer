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
    self.helloServer = [ASEHelloServer new];
}

@end
