#import "MainStore.h"
#import "MainState.h"

@implementation MainStore
- (instancetype)initWith:(id<Reducer>)reducer state:(id<State>)initialState {
  return [super initWith:reducer state:initialState];
}
@end
