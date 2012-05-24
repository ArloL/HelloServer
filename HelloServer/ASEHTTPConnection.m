#import "ASEHTTPConnection.h"

#import <CocoaHTTPServer/HTTPMessage.h>
#import <CocoaHTTPServer/HTTPLogging.h>

#import "ASEHelloResponse.h"

// Log levels : off, error, warn, info, verbose
// Other flags: trace
static const int httpLogLevel = HTTP_LOG_LEVEL_WARN; // | HTTP_LOG_FLAG_TRACE;

@implementation ASEHTTPConnection

- (BOOL)supportsMethod:(NSString *)method atPath:(NSString *)path
{
	HTTPLogTrace();
	
	// Add support for POST
	
	if ([method isEqualToString:@"GET"] && [path isEqualToString:@"/hello"]) {
        return YES;
	}
	
	return [super supportsMethod:method atPath:path];
}

- (NSObject<HTTPResponse> *)httpResponseForMethod:(NSString *)method URI:(NSString *)path
{
	HTTPLogTrace();
	
	if ([method isEqualToString:@"GET"] && [path isEqualToString:@"/hello"]) {
        NSData * responseData = [@"{\"responses\":{\"message\":\"hello world\"}}" dataUsingEncoding:NSUTF8StringEncoding];
        ASEHelloResponse * response = [[ASEHelloResponse alloc] initWithData:responseData];
		return response;
	}
	
	return [super httpResponseForMethod:method URI:path];
}

@end
