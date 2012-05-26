#import "ASEHelloServer.h"

#import <CocoaLumberjack/DDLog.h>
#import <CocoaLumberjack/DDTTYLogger.h>
#import <CocoaHTTPServer/HTTPServer.h>

#import "ASEHTTPConnection.h"

// Log levels: off, error, warn, info, verbose
static const int ddLogLevel = LOG_LEVEL_VERBOSE;

@interface ASEHelloServer ()

@property (nonatomic, strong) HTTPServer * httpServer;

@end

@implementation ASEHelloServer

@synthesize httpServer;

- (id)init
{
    self = [super init];
    if (self) {
        // Configure our logging framework.
        // To keep things simple and fast, we're just going to log to the Xcode console.
        [DDLog addLogger:[DDTTYLogger sharedInstance]];
        
        // Initalize our http server
        httpServer = [[HTTPServer alloc] init];
        
        [httpServer setType:@"_http._tcp"];
        
        // Normally there's no need to run our server on any specific port.
        // Technologies like Bonjour allow clients to dynamically discover the server's port at runtime.
        // However, for easy testing you may want force a certain port so you can just hit the refresh button.
        [httpServer setPort:12345];
        
        // We're going to extend the base HTTPConnection class with our MyHTTPConnection class.
        // This allows us to do all kinds of customizations.
        [httpServer setConnectionClass:[ASEHTTPConnection class]];
        
        NSError * error = nil;
        if(![httpServer start:&error])
        {
            DDLogError(@"Error starting HTTP Server: %@", error);
        }
    }
    return self;
}

-(void)dealloc
{
    [httpServer stop];
    
    httpServer = nil;
}

@end
