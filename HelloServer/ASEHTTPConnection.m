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

/**
 * This method is called immediately prior to sending the response headers.
 * This method adds standard header fields, and then converts the response to an NSData object.
 **/
- (NSData *)preprocessResponse:(HTTPMessage *)response
{
	HTTPLogTrace();
    
    // Set the connection header if not already specified
	NSString *connection = [response headerField:@"Connection"];
	if (!connection) {
		connection = [self shouldDie] ? @"close" : @"keep-alive";
		[response setHeaderField:@"Connection" value:connection];
	}
	
	// Override me to customize the response headers
	// You'll likely want to add your own custom headers, and then return [super preprocessResponse:response]
	
	// Add optional response headers
	if ([httpResponse respondsToSelector:@selector(httpHeaders)])
	{
		NSDictionary *responseHeaders = [httpResponse httpHeaders];
		
		NSEnumerator *keyEnumerator = [responseHeaders keyEnumerator];
		NSString *key;
		
		while ((key = [keyEnumerator nextObject]))
		{
			NSString *value = [responseHeaders objectForKey:key];
			
			[response setHeaderField:key value:value];
		}
	}
	
	return [response messageData];
}


@end
