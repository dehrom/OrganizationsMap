#import <Foundation/Foundation.h>

@class MainState;
@protocol State;
@protocol Action;
@protocol StoreSubscriber;
@protocol Reducer;

NS_ASSUME_NONNULL_BEGIN

typedef id<State> _Nonnull (^StateSelectBlock)(MainState *);

@interface MainStore : NSObject
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)initWith:(NSArray<id<Reducer>> *)reducers
                   state:(MainState *)initialState NS_DESIGNATED_INITIALIZER;

- (void)dispatchAction:(id<Action>)action;
- (void)subscribeWith:(id<StoreSubscriber>)subscriber stateSelectBlock:(StateSelectBlock)block;
- (void)unsubscribeWith:(id<StoreSubscriber>)subscriber;
- (void)unsubscribeAll;
@end

NS_ASSUME_NONNULL_END
