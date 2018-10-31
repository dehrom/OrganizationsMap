#import "ListState.h"

@implementation ListState
@synthesize status;

+ (instancetype)new {
    return [[ListState alloc] initWithModels:nil index:-1 status:StateNoChanges];
}

- (instancetype)initWithModels:(NSArray<ListSectionModel *> *)models and:(StateStatus)status {
    return [self initWithModels:models index:-1 status:status];
}

- (instancetype)initWithIndex:(NSUInteger)selectedOrganizationIndex and:(StateStatus)status {
    return [self initWithModels:[NSArray array] index:selectedOrganizationIndex status:status];
}

- (instancetype)initWithModels:(NSArray<ListSectionModel *> *)models index:(NSUInteger)selectedOrganizationIndex status:(StateStatus)newStatus {
    if (self = [super init]) {
        _models = [models copy];
        _selectedOrganizationIndex = selectedOrganizationIndex;
        status = newStatus;
    }
    return self;
}

- (id)copy {
    return [[ListState alloc] initWithModels:self.models index:self.selectedOrganizationIndex status:StateNoChanges];
}
@end
