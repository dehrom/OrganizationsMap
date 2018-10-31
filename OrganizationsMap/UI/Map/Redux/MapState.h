#import <Foundation/Foundation.h>
#import "State.h"

@class MKPointAnnotation;

NS_ASSUME_NONNULL_BEGIN

@interface MapState : NSObject <State>
@property (strong, nonatomic, nullable, readonly) MKPointAnnotation *selectedOrganizationPoint;
@property (strong, nonatomic, nullable, readonly) NSArray<MKPointAnnotation *> *models;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithModels:(NSArray<MKPointAnnotation *> * _Nullable)models
                         point:(MKPointAnnotation * _Nullable)selectedOrganizationPoint
                        status:(StateStatus)newStatus;
@end

NS_ASSUME_NONNULL_END
