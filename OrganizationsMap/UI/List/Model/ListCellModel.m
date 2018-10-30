#import "ListCellModel.h"

@implementation ListCellModel
- (instancetype)initWith:(int)identifier
                     and:(NSString *)organizationName
                     and:(NSString *)organizationDescription {
    if (self = [super init]) {
        _identifier = identifier;
        _organizationName = organizationName;
        _organizationDescription = organizationDescription;
    }
    return self;
}
@end
