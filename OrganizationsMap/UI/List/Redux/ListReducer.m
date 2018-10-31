#import "ListReducer.h"
#import "PresentListAction.h"
#import "MapSelectAction.h"
#import "ListOrganizationSelectAction.h"
#import "PresentableErrorAction.h"
#import "MapState.h"
#import "MainState.h"
#import "ListState.h"
#import "FetchingError.h"
#import <MapKit/MKPointAnnotation.h>

static int kDefaultListOffset = -1;

@implementation ListReducer
- (ReduceBlock)createReducer {
    return ^MainState *(MainState *_Nonnull state, id<Action> _Nonnull action) {
        if ([action isKindOfClass:[PresentableErrorAction class]]) {
            __auto_type error = (NSError *)action.payload;
            if (error.code == FetchingOrganizationsFailure) {
                __auto_type listState = [[ListState alloc] initWithModels:[NSArray array]
                                                                    index:kDefaultListOffset
                                                                   status:StateFailure];
                return [[MainState alloc] initWithListState:listState MapState:[state.mapState copy]];
            }
        }
        
        if ([action isKindOfClass:[PresentListAction class]]) {
            __auto_type listState = [[ListState alloc] initWithModels:action.payload
                                                                index:state.listState.selectedOrganizationIndex
                                                               status:StateOrganizationLoadedSuccess];
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
