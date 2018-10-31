#import "PresentMapAction.h"
#import <MapKit/MKPointAnnotation.h>

@implementation PresentMapAction
@synthesize payload;

- (instancetype)initWith:(NSArray<MKPointAnnotation *> *)points {
    if (self = [super init]) {
        payload = [points copy];
    }
    return self;
}

@end
