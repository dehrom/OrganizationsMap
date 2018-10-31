#import "FetchAction.h"
#import <MapKit/MKPointAnnotation.h>
#import <ReactiveObjC.h>
#import "ListCellModel.h"
#import "ListFetchService.h"
#import "ListFetchService_Local.h"
#import "ListSectionModel.h"
#import "MainStore.h"
#import "OrganizationDTOModel.h"
#import "PresentListAction.h"
#import "PresentMapAction.h"
#import "PresentableErrorAction.h"
#import "UIApplication+Accessor.h"
#import "VisitDTOModel.h"

@interface FetchAction ()
@property (copy, nonatomic) id<ListFetchServiceProtocol> fetchService;
@property (strong, nonatomic) MainStore *store;
@end

@implementation FetchAction
@synthesize payload;

+ (instancetype)new {
    return [[FetchAction alloc] initWith:[ListFetchService new]];
}

- (instancetype)initWith:(id<ListFetchServiceProtocol>)service; {
    if (self = [super init]) {
        _store = [[UIApplication sharedApplication] mainStore];
        _fetchService = service;
    }
    return self;
}

- (void)start {
    [[self.fetchService fetch]
        subscribeNext:^(RACTwoTuple<NSArray<OrganizationDTOModel *> *,
                                    NSArray<VisitDTOModel *> *> *_Nullable x) {
          [self.store dispatchAction:[[PresentMapAction alloc] initWith:[self resolvePointsFrom:x.first and:x.second]]];
          [self.store dispatchAction:[[PresentListAction alloc] initWith:[self resolveOrganizationsFrom:x.first and:x.second]]];
        }
        error:^(NSError *_Nullable error) {
          [self.store dispatchAction:[[PresentableErrorAction alloc] initWith:error]];
        }];
}

#pragma mark - TURN TO WORKER

- (NSArray<MKPointAnnotation *> *)resolvePointsFrom:(NSArray<OrganizationDTOModel *> *)first
                                                and:(NSArray<VisitDTOModel *> *)second {
    NSMutableArray<MKPointAnnotation *> *coordinates = [NSMutableArray new];
    for (VisitDTOModel *visitDTO in second) {
        __auto_type annotation = [MKPointAnnotation alloc];
        annotation.coordinate = CLLocationCoordinate2DMake(visitDTO.latitude, visitDTO.longitude);
        annotation.title = visitDTO.title;
        [coordinates addObject:annotation];
    }
    return [NSArray arrayWithArray:coordinates];
}

- (NSArray<ListSectionModel *> *)resolveOrganizationsFrom:(NSArray<OrganizationDTOModel *> *)first
                                                      and:(NSArray<VisitDTOModel *> *)second {
    NSMutableArray<ListSectionModel *> *organizationsSections = [NSMutableArray new];
    for (VisitDTOModel *visitDTO in second) {
        @autoreleasepool {
            NSMutableArray<NSString *> *reasons = [NSMutableArray new];
            __auto_type predicate = [NSPredicate predicateWithBlock:^BOOL(OrganizationDTOModel *_Nullable evaluatedObject,
                                                                          NSDictionary<NSString *, id> *_Nullable bindings) {
              return evaluatedObject.organizationId == visitDTO.organizationId;
            }];
            __auto_type visits = [first filteredArrayUsingPredicate:predicate];
            for (OrganizationDTOModel *organizationDTO in visits) {
                [reasons addObject:organizationDTO.visitDetail];
            }
            __auto_type section =
                [[ListSectionModel alloc] initWith:visitDTO.organizationId
                                             title:visitDTO.title
                                            visits:reasons];
            [organizationsSections addObject:section];
        }
    }
    return [NSArray arrayWithArray:organizationsSections];
}

@end
