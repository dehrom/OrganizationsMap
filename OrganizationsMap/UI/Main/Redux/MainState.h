#import <MapKit/MapKit.h>
#import <UIKit/UIKit.h>
#import "State.h"

@class ListCellModel;

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
  StateLoading,
  StateSuccess,
  StateFailure,
} MainStateStatus;

@interface MainState : NSObject <State>
@property(assign, nonatomic) MainStateStatus status;
@property(strong, nonatomic, nonnull) NSMutableArray<ListCellModel *> *data;
@property(strong, nonatomic, nonnull) NSMutableArray<MKMapItem *> *mapItems;
@end

NS_ASSUME_NONNULL_END
