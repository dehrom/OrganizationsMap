#import "MainReducer.h"
#import <ReactiveObjC.h>
#import "Action.h"
#import "FetchAction.h"
#import "FetchingError.h"
#import "ListOrganizationSelectAction.h"
#import "ListSectionModel.h"
#import "ListState.h"
#import "MainState.h"
#import "MapSelectAction.h"
#import "MapState.h"
#import "PresentListAction.h"
#import "PresentMapAction.h"
#import "PresentableErrorAction.h"
#import "State.h"

static int kDefaultListOffset = -1;
// TODO: Split
@implementation MainReducer
- (ReduceBlock)createReducer {
    return ^MainState *(MainState *_Nonnull state, id<Action> _Nonnull action) {
        if ([action isKindOfClass:[PresentableErrorAction class]]) {
            __auto_type error = (NSError *)action.payload;
            switch (error.code) {
                case FetchingOrganizationsFailure: {
                    __auto_type listState = [[ListState alloc] initWithModels:[NSArray array]
                                                                        index:kDefaultListOffset
                                                                       status:StateFailure];
                    return [[MainState alloc] initWithListState:listState MapState:[state.mapState copy]];
                } break;
                case FetchingVisitsFailure: {
                    __auto_type mapState = [[MapState alloc] initWithModels:[NSArray array] point:nil status:StateFailure];
                    return [[MainState alloc] initWithListState:[state.listState copy] MapState:mapState];
                } break;
            }
        }

        if ([action isKindOfClass:[PresentListAction class]]) {
            __auto_type listState = [[ListState alloc] initWithModels:action.payload
                                                                index:kDefaultListOffset
                                                               status:StateOrganizationLoadedSuccess];
            return [[MainState alloc] initWithListState:listState MapState:[state.mapState copy]];
        }

        if ([action isKindOfClass:[PresentMapAction class]]) {
            __auto_type mapState = [[MapState alloc] initWithModels:action.payload point:nil status:StateVisitsLoadedSuccess];
            return [[MainState alloc] initWithListState:[state.listState copy] MapState:mapState];
        }

        if ([action isKindOfClass:[MapSelectAction class]]) {
            __block __auto_type listState = [ListState new];
            [state.listState.models enumerateObjectsUsingBlock:^(ListSectionModel *_Nonnull obj,
                                                                 NSUInteger idx, BOOL *_Nonnull stop) {
              if ([obj.title isEqualToString:action.payload] == NO)
                  return;
                listState = [[ListState alloc] initWithModels:state.listState.models index:idx status:StateMapItemSelect];
              *stop = YES;
            }];
            return [[MainState alloc] initWithListState:listState MapState:[state.mapState copy]];
        }

        if ([action isKindOfClass:[ListOrganizationSelectAction class]]) {
            __block __auto_type mapState = [MapState new];
            [state.mapState.models enumerateObjectsUsingBlock:^(MKPointAnnotation *_Nonnull obj,
                                                                NSUInteger idx, BOOL *_Nonnull stop) {
              if ([obj.title isEqualToString:action.payload] == NO)
                  return;
              mapState = [[MapState alloc] initWithModels:state.mapState.models point:obj status:StateListItemSelect];
              *stop = YES;
            }];
            return [[MainState alloc] initWithListState:[state.listState copy] MapState:mapState];
        }
        return state;
    };
}
@end
