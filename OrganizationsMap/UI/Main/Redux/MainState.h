#import <UIKit/UIKit.h>
#import "State.h"

@class ListSectionModel;
@class MKPointAnnotation;

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    StateLoading,
    StateVisitsLoadedSuccess,
    StateOrganizationLoadedSuccess,
    StateMapItemSelect,
    StateListItemSelect,
    StateFailure,
} MainStateStatus;

@interface MainState : NSObject <State>
@property (assign, nonatomic) MainStateStatus status;
@property (assign, nonatomic) NSUInteger selectedOrganizationIndex;
@property (strong, nonatomic, nullable) MKPointAnnotation *selectedOrganizationPoint;
@property (strong, nonatomic, nonnull) NSMutableArray<ListSectionModel *> *data;
@property (strong, nonatomic, nonnull) NSMutableArray<MKPointAnnotation *> *mapItems;
@end

NS_ASSUME_NONNULL_END
