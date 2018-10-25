#import "Store.h"
#import "Action.h"
#import "Reducer.h"
#import "StoreSubscriber.h"

@interface Store ()
@property(nonatomic, strong) id<State> state;
@property(nonatomic, strong) NSHashTable<id<StoreSubscriber>> *subscribers;
@property(nonatomic, copy) ReduceBlock reduceBlock;
@property(nonatomic, strong) dispatch_queue_t workingQueue;
@end

@implementation Store

- (instancetype)initWith:(id<Reducer>)reducer state:(id<State>)initialState {
  if (self = [super init]) {
    _reduceBlock = [reducer createReducer];
    _state = initialState;
    _workingQueue = dispatch_queue_create("StoreQueue", DISPATCH_QUEUE_SERIAL);
    _subscribers = [NSHashTable weakObjectsHashTable];
  }
  return self;
}

- (void)dispatchAction:(id<Action>)action {
  dispatch_async(self.workingQueue, ^{
    if ([action respondsToSelector:@selector(start)]) {
      [action start];
    }
    id<State> newState = self.reduceBlock(self.state, action);
    dispatch_async(dispatch_get_main_queue(), ^{
      for (id<StoreSubscriber> subsciber in self.subscribers) {
        [subsciber newState:newState];
      }
    });
  });
}

- (void)subscribeWith:(id<StoreSubscriber>)subscriber {
  [self.subscribers addObject:subscriber];
}

- (void)unsubscribeWith:(id<StoreSubscriber>)subscriber {
  [self.subscribers removeObject:subscriber];
}
@end
