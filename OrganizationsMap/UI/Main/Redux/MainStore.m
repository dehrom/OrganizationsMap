#import "MainStore.h"
#import "MainState.h"

@implementation MainStore
- (instancetype)initWith:(ReduceBlock)reducer state:(MainState *)initialState {
    return [super initWith:reducer state:initialState];
}
@end
