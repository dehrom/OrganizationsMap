#import "MainStore.h"
#import "Action.h"
#import "ListState.h"
#import "MainReducer.h"
#import "MainState.h"
#import "State.h"
#import "StoreSubscriber.h"

@interface MainStore ()
@property (nonatomic, strong) MainState *state;
@property (nonatomic, strong) NSMapTable<id<StoreSubscriber>, StateSelectBlock> *subscribers;
@property (nonatomic, copy) ReduceBlock reduceBlock;
@property (nonatomic, strong) dispatch_queue_t workingQueue;
@end

@implementation MainStore
- (instancetype)initWith:(MainReducer *)reducer state:(MainState *)initialState {
    if (self = [super init]) {
        _reduceBlock = [[reducer createReducer] copy];
        _state = initialState;
        _workingQueue = dispatch_queue_create("StoreQueue", DISPATCH_QUEUE_SERIAL);
        _subscribers = [NSMapTable weakToWeakObjectsMapTable];
    }
    return self;
}

- (void)dispatchAction:(id<Action>)action {
    dispatch_async(self.workingQueue, ^{
      if ([action respondsToSelector:@selector(start)]) {
          [action start];
      }
      MainState *newState = self.reduceBlock(self.state, action);
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
@end
