#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol State;
@protocol Action;

typedef id<State> (^ReduceBlock)(id<State> state, id<Action> action);
@protocol Reducer <NSObject>
- (ReduceBlock)createReducer;
@end

NS_ASSUME_NONNULL_END
