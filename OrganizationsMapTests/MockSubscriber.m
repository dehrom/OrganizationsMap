#import "MockSubscriber.h"

@implementation MockSubscriber
- (void)newState:(id<State>)state {
    self.state = state;
}
@end
