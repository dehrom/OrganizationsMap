#import "PresentableErrorAction.h"

@implementation PresentableErrorAction
@synthesize payload;

- (instancetype)initWith:(NSError *)error {
    if (self = [super init]) {
        payload = error;
    }
    return self;
}
@end
