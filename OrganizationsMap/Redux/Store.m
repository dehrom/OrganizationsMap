#import "Store.h"
#import "StoreSubscriber.h"

@interface Store ()
@property (nonatomic, strong) id<State> state;
@property (nonatomic, copy) ReduceBlock reducer;
@property (nonatomic, copy) NSHashTable<id<StoreSubscriber>> *subscribers;
@property (nonatomic, strong) dispatch_queue_t operationQueue;
@end

@implementation Store

- (instancetype)initWith:(ReduceBlock)reducer state:(id<State>)initialState {
    if (self = [super init]) {
        _reducer = reducer;
        _state = initialState;
        _subscribers = [NSHashTable weakObjectsHashTable];
    }
    return self;
}

- (void)dispatchAction:(id<Action>)action {
    dispatch_async(self.operationQueue, ^{
        id<State> newState = self.reducer(self.state, action);
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
