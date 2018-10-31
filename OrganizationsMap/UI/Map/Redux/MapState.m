#import "MapState.h"
#import <MapKit/MKPointAnnotation.h>

@implementation MapState
@synthesize status;

+ (instancetype)new {
    return [[MapState alloc] initWithModels:nil point:nil status:StateNoChanges];
}

- (instancetype)initWithModels:(NSArray<MKPointAnnotation *> *)mapItems and:(StateStatus)status {
    return [self initWithModels:mapItems point:nil status:status];
}

- (instancetype)initWithModel:(MKPointAnnotation *)selectedOrganizationPoint and:(StateStatus)status;
{
    return [self initWithModels:[NSArray array] point:selectedOrganizationPoint status:status];
}

- (instancetype)initWithModels:(NSArray<MKPointAnnotation *> *)models point:(MKPointAnnotation *)selectedOrganizationPoint status:(StateStatus)newStatus {
    if (self = [super init]) {
        _models = [models copy];
        _selectedOrganizationPoint = selectedOrganizationPoint;
        status = newStatus;
    }
    return self;
}

- (id)copy {
    return [[MapState alloc] initWithModels:self.models point:self.selectedOrganizationPoint status:StateNoChanges];
    ;
}
@end
