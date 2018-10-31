#import "ListFetchService_Local.h"
#import <ReactiveObjC.h>
#import "OrganizationDTOModel.h"
#import "VisitDTOModel.h"

@implementation ListFetchService_Local
- (RACSignal<RACTwoTuple<NSArray<OrganizationDTOModel *> *, NSArray<VisitDTOModel *> *> *> *)
    fetch {
    return [RACSignal zip:@[ [self fetchOrganizations], [self fetchVisits] ]
                   reduce:^id(NSArray<OrganizationDTOModel *> *coordinates,
                              NSArray<VisitDTOModel *> *visits) {
                     return [RACTwoTuple pack:coordinates:visits];
                   }];
}

- (RACSignal<NSArray<VisitDTOModel *> *> *)fetchVisits {
    NSError *error;
    __auto_type array = @[
        [[VisitDTOModel alloc] initWithDictionary:@{
            @"organizationId" : @"100",
            @"title" : @"Apple Infinite Loop",
            @"latitude" : @"55.453145",
            @"longitude" : @"37.61847"
        }
                                            error:&error],
        [[VisitDTOModel alloc] initWithDictionary:@{
            @"organizationId" : @"101",
            @"title" : @"Google HQ",
            @"latitude" : @"55.461395",
            @"longitude" : @"37.619376"
        }
                                            error:&error],
    ];
    __auto_type str =
        [NSString stringWithFormat:@"fetchOrganizations error %@", error];
    NSAssert(error == nil, str);
    return [RACSignal return:array];
}

- (RACSignal<NSArray<OrganizationDTOModel *> *> *)fetchOrganizations {
    NSError *error;
    __auto_type array = @[
        [[OrganizationDTOModel alloc] initWithDictionary:@{
            @"organizationId" : @"100",
            @"title" : @"Meeting",
        }
                                                   error:&error],
        [[OrganizationDTOModel alloc] initWithDictionary:@{
            @"organizationId" : @"101",
            @"title" : @"Product Presentation",
        }
                                                   error:&error],
    ];
    __auto_type str = [NSString stringWithFormat:@"fetchVisits error %@", error];
    NSAssert(error == nil, str);
    return [RACSignal return:array];
}
@end
