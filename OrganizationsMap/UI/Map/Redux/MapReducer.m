#import "MapReducer.h"
#import "PresentMapAction.h"
#import "MapSelectAction.h"
#import "ListSectionModel.h"
#import "PresentableErrorAction.h"
#import "MapState.h"
#import "MainState.h"
#import "ListState.h"
#import "FetchingError.h"

@implementation MapReducer
- (ReduceBlock)createReducer {
    return ^MainState *(MainState *_Nonnull state, id<Action> _Nonnull action) {
        if ([action isKindOfClass:[PresentableErrorAction class]]) {
            __auto_type error = (NSError *)action.payload;
            if (error.code == FetchingVisitsFailure) {
                __auto_type mapState = [[MapState alloc] initWithModels:[NSArray array] point:nil status:StateFailure];
                return [[MainState alloc] initWithListState:[state.listState copy] MapState:mapState];
            }
        }
        
        if ([action isKindOfClass:[PresentMapAction class]]) {
            __auto_type mapState = [[MapState alloc] initWithModels:action.payload
                                                              point:state.mapState.selectedOrganizationPoint
                                                             status:StateVisitsLoadedSuccess];
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
        
        return state;
    };
}
@end
