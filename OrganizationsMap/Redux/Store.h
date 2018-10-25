#import <Foundation/Foundation.h>

@protocol State;
@protocol Action;
@protocol StoreSubscriber;

NS_ASSUME_NONNULL_BEGIN

typedef id<State> (^ReduceBlock)(id<State> state, id<Action> action);

@interface Store : NSObject
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)initWith:(ReduceBlock)reducer state:(id<State>)initialState NS_DESIGNATED_INITIALIZER;

- (void)dispatchAction:(id<Action>)action;
- (void)subscribeWith:(id<StoreSubscriber>)subscriber;
- (void)unsubscribeWith:(id<StoreSubscriber>)subscriber;

@end

NS_ASSUME_NONNULL_END
