#import "MainReducer.h"
#import <ReactiveObjC.h>
#import "Action.h"
#import "FetchAction.h"
#import "MainState.h"
#import "PresentListAction.h"

@implementation MainReducer
- (ReduceBlock)createReducer {
  return ^MainState *(MainState *_Nonnull state, id<Action> _Nonnull action) {
    if ([action.identifier isEqualToString:NSStringFromClass([FetchAction class])]) {
      state.status = StateLoading;
      return state;
    }
    if ([action.identifier isEqualToString:NSStringFromClass([PresentListAction class])]) {
      state.status = StateSuccess;
      state.data = action.payload;
      return state;
    }
    return [MainState new];
  };
}
@end
