#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol Action;
@class MainState;

typedef MainState * (^ReduceBlock)(MainState *state, id<Action> action);
@protocol Reducer <NSObject>
- (ReduceBlock)createReducer;
@end

NS_ASSUME_NONNULL_END
