#import "ASEHelloResponse.h"

@implementation ASEHelloResponse

-(NSDictionary *)httpHeaders {
    return [NSDictionary dictionaryWithObjectsAndKeys:@"application/json;charset=utf-8", @"Content-Type", @"Hello", @"Server", nil];
}

@end
