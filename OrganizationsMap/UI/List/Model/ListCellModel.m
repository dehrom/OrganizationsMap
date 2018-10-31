#import "ListCellModel.h"

@implementation ListCellModel
- (instancetype)initWith:(NSString *)organizationName
                     and:(NSString *)organizationDescription {
    if (self = [super init]) {
        _organizationName = organizationName;
        _organizationDescription = organizationDescription;
    }
    return self;
}
@end
