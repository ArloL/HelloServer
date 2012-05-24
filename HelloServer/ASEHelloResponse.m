#import "ASEHelloResponse.h"

@implementation ASEHelloResponse

-(NSDictionary *)httpHeaders {
    return [NSDictionary dictionaryWithObjectsAndKeys:@"application/json", @"Content-Type", nil];
}

@end
