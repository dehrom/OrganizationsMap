#import <Foundation/Foundation.h>
#import "State.h"

@class MKPointAnnotation;

NS_ASSUME_NONNULL_BEGIN

@interface MapState : NSObject <State>
@property (strong, nonatomic, nullable, readonly) MKPointAnnotation *selectedOrganizationPoint;
@property (strong, nonatomic, nonnull, readonly) NSArray<MKPointAnnotation *> *models;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithModels:(NSArray<MKPointAnnotation *> *)models and:(StateStatus)status;
- (instancetype)initWithModel:(MKPointAnnotation *)selectedOrganizationPoint and:(StateStatus)status;
@end

NS_ASSUME_NONNULL_END
