#import <MapKit/MapKit.h>
#import <UIKit/UIKit.h>
#import "State.h"

@class ListSectionModel;

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
  StateLoading,
  StateVisitsLoadedSuccess,
  StateOrganizationLoadedSuccess,
  StateFailure,
} MainStateStatus;

@interface MainState : NSObject <State>
@property(assign, nonatomic) MainStateStatus status;
@property(strong, nonatomic, nonnull) NSMutableArray<ListSectionModel *> *data;
@property(strong, nonatomic, nonnull) NSMutableArray<MKPointAnnotation *> *mapItems;
@end

NS_ASSUME_NONNULL_END
