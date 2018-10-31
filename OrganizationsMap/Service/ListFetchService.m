#import "ListFetchService.h"
#import <Foundation/Foundation.h>
#import <Mantle/MTLJSONAdapter.h>
#import <Mantle/MTLValueTransformer.h>
#import <ReactiveObjC.h>
#import "FetchingError.h"
#import "OrganizationDTOModel.h"
#import "VisitDTOModel.h"

static NSString *kOrganizationsListURL =  @"https://demo1546967.mockable.io/organizations/getOrganizationListTest";
static NSString *kVisitsURL =  @"https://demo1546967.mockable.io/organizationsMap/getVisitsListTest";

static NSString *fetchingServiceDomain = @"my-night.OrganizationsMap.FetchingService";

@interface ListFetchService ()
@property (strong, nonatomic) NSURLSession *session;
@end

@implementation ListFetchService
- (instancetype)init {
    if (self = [super init]) {
        _session = [NSURLSession
            sessionWithConfiguration:NSURLSessionConfiguration.ephemeralSessionConfiguration];
    }
    return self;
}

- (RACSignal<RACTwoTuple<NSArray<OrganizationDTOModel *> *, NSArray<VisitDTOModel *> *> *> *)fetch {
    return [RACSignal zip:@[ [self fetchOrganizations], [self fetchVisits] ]
                   reduce:^id(NSArray<OrganizationDTOModel *> *coordinates,
                              NSArray<VisitDTOModel *> *visits) {
                     return [RACTwoTuple pack:coordinates:visits];
                   }];
}

#pragma mark - Private functions

- (RACSignal<NSArray<OrganizationDTOModel *> *> *)fetchOrganizations {
    return [[[self loadWith:[NSURL URLWithString:kOrganizationsListURL]]
        tryMap:^NSArray<OrganizationDTOModel *> *_Nonnull(
            NSData *_Nullable value,
            NSError *_Nullable __autoreleasing *_Nullable errorPtr) {
          return [self transfromFrom:value
                               error:errorPtr
                               class:[OrganizationDTOModel class]];
        }] catch:^RACSignal *_Nonnull(NSError *_Nonnull error) {
      NSLog(@"fetchOrganizations Error: %@", error.localizedDescription);
      __auto_type customError = [NSError errorWithDomain:fetchingServiceDomain
                                                    code:FetchingOrganizationsFailure
                                                userInfo:error.userInfo];
      return [RACSignal error:customError];
    }];
}

- (RACSignal<NSArray<VisitDTOModel *> *> *)fetchVisits {
    return [[[self loadWith:[NSURL URLWithString:kVisitsURL]]
        tryMap:^NSArray<VisitDTOModel *> *_Nonnull(
            NSData *_Nullable value,
            NSError *_Nullable __autoreleasing *_Nullable errorPtr) {
          return [self transfromFrom:value
                               error:errorPtr
                               class:[VisitDTOModel class]];
        }] catch:^RACSignal *_Nonnull(NSError *_Nonnull error) {
      NSLog(@"fetchVisits Error: %@", error.localizedDescription);
      __auto_type customError = [NSError errorWithDomain:fetchingServiceDomain
                                                    code:FetchingVisitsFailure
                                                userInfo:error.userInfo];
      return [RACSignal error:customError];
    }];
}

- (NSArray *)transfromFrom:(NSData *)data
                     error:(NSError **)error
                     class:(Class)modelClass {
    NSArray<NSDictionary<NSString *, id> *> *dict =
        [NSJSONSerialization JSONObjectWithData:data
                                        options:NSJSONReadingAllowFragments
                                          error:error];
    __auto_type transformers = [MTLJSONAdapter arrayTransformerWithModelClass:modelClass];
    return [transformers transformedValue:dict success:nil error:error];
}

- (RACSignal<NSData *> *)loadWith:(NSURL *)url {
    return [[RACSignal createSignal:^RACDisposable *_Nullable(id<RACSubscriber> _Nonnull subscriber) {
      __auto_type task =
          [self.session dataTaskWithURL:url
                      completionHandler:^(NSData *_Nullable data,
                                          NSURLResponse *_Nullable response,
                                          NSError *_Nullable error) {
                        if (error != nil) {
                            [subscriber sendError:error];
                        } else if (data != nil) {
                            [subscriber sendNext:data];
                            [subscriber sendCompleted];
                        }
                      }];
      [task resume];
      return [RACDisposable disposableWithBlock:^{
        if (task.state == NSURLSessionTaskStateRunning) {
            [task cancel];
        }
      }];
    }] subscribeOn:[RACScheduler schedulerWithPriority:RACSchedulerPriorityBackground]];
}
@end
