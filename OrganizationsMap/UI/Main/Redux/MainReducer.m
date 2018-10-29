#import "MainReducer.h"
#import <ReactiveObjC.h>
#import "Action.h"
#import "FetchAction.h"
#import "ListSectionModel.h"
#import "MainState.h"
#import "MapSelectAction.h"
#import "PresentListAction.h"
#import "PresentMapAction.h"

@implementation MainReducer
- (ReduceBlock)createReducer {
  return ^MainState *(MainState *_Nonnull state, id<Action> _Nonnull action) {
    if ([action isKindOfClass:[FetchAction class]]) {
      state.status = StateLoading;
      return state;
    }

    if ([action isKindOfClass:[PresentListAction class]]) {
      state.status = StateOrganizationLoadedSuccess;
      state.data = action.payload;
      return state;
    }

    if ([action isKindOfClass:[PresentMapAction class]]) {
      state.status = StateVisitsLoadedSuccess;
      state.mapItems = action.payload;
      return state;
    }

    if ([action isKindOfClass:[MapSelectAction class]]) {
      state.status = StateFailure;
      [state.data enumerateObjectsUsingBlock:^(ListSectionModel *_Nonnull obj, NSUInteger idx,
                                               BOOL *_Nonnull stop) {
        if ([obj.title isEqualToString:action.payload] == NO) return;
        state.selectedOrganizationIndex = idx;
        state.status = StateOrganizationSelected;
        *stop = YES;
      }];
      return state;
    }
    return state;
  };
}
@end
