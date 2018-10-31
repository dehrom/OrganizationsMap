#import "MainStore.h"
#import "Action.h"
#import "ListState.h"
#import "MainState.h"
#import "State.h"
#import "StoreSubscriber.h"
#import "Reducer.h"

@interface MainStore ()
@property (nonatomic, strong) MainState *state;
@property (nonatomic, strong) NSMapTable<id<StoreSubscriber>, StateSelectBlock> *subscribers;
@property (nonatomic, strong) NSMutableArray<ReduceBlock> *reduceBlocks;
@property (nonatomic, strong) dispatch_queue_t workingQueue;
@end

@implementation MainStore
- (instancetype)initWith:(NSArray<id<Reducer>> *)reducers state:(MainState *)initialState {
    if (self = [super init]) {
        _state = initialState;
        _workingQueue = dispatch_queue_create("StoreQueue", DISPATCH_QUEUE_SERIAL);
        _subscribers = [NSMapTable weakToWeakObjectsMapTable];
        _reduceBlocks = [NSMutableArray arrayWithCapacity:reducers.count];
        for (id<Reducer> reducer in reducers) {
            [_reduceBlocks addObject:[reducer createReducer]];
        }
    }
    return self;
}

- (void)dispatchAction:(id<Action>)action {
    dispatch_async(self.workingQueue, ^{
      if ([action respondsToSelector:@selector(start)]) {
          [action start];
      }
      MainState *newState = self.state;
      for (ReduceBlock block in self.reduceBlocks) {
          newState = block(newState, action);
      }
      self.state = newState;
      __auto_type keys = [self.subscribers.keyEnumerator allObjects];
      for (id<StoreSubscriber> s in keys) {
          StateSelectBlock block = [self.subscribers objectForKey:s];
          id<State> concreteState = block(self.state);
          if (concreteState.status != StateNoChanges) {
              dispatch_async(dispatch_get_main_queue(), ^{
                [s newState:concreteState];
              });
          }
      }
    });
}

- (void)subscribeWith:(id<StoreSubscriber>)subscriber stateSelectBlock:(StateSelectBlock)block {
    [self.subscribers setObject:block forKey:subscriber];
}

- (void)unsubscribeWith:(id<StoreSubscriber>)subscriber {
    [self.subscribers removeObjectForKey:subscriber];
}

- (void)unsubscribeAll {
    [self.subscribers removeAllObjects];
}
@end
