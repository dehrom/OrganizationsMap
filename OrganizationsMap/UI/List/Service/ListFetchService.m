#import "ListFetchService.h"
#import <Foundation/Foundation.h>
#import <ReactiveObjC.h>
#import "ListDTOModel.h"

static NSString *kOrganizationsListURL =
    @"https://demo1546967.mockable.io/OrganizationsMap/getVisitsListTest";

@interface ListFetchService ()
@property(strong, nonatomic) NSURLSession *session;
@end

@implementation ListFetchService
- (instancetype)init {
  if (self = [super init]) {
    _session = [NSURLSession
        sessionWithConfiguration:NSURLSessionConfiguration.ephemeralSessionConfiguration];
  }
  return self;
}

- (RACSignal<NSArray<ListDTOModel *> *> *)fetch {
  return [[self loadData] map:^NSArray<ListDTOModel *> *_Nullable(NSData *_Nullable value) {
    __auto_type json = [self transfromFrom:value];
    return [self transformFrom:json];
  }];
}

#pragma mark - Private functions

- (NSArray<ListDTOModel *> *)transformFrom:(NSArray<NSDictionary<NSString *, id> *> *)array {
  __auto_type result = [[NSMutableArray alloc] initWithCapacity:array.count];
  for (NSDictionary<NSString *, id> *item in array) {
    __auto_type dtoModel = [[ListDTOModel alloc] initWithDictionary:item error:nil];
    [result addObject:dtoModel];
  }
  return [NSArray arrayWithArray:result];
}

- (NSArray<NSDictionary<NSString *, id> *> *)transfromFrom:(NSData *)data {
  return
      [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
}

- (RACSignal<NSData *> *)loadData {
  return [[RACSignal createSignal:^RACDisposable *_Nullable(id<RACSubscriber> _Nonnull subscriber) {
    __auto_type task =
        [self.session dataTaskWithURL:[NSURL URLWithString:kOrganizationsListURL]
                    completionHandler:^(NSData *_Nullable data, NSURLResponse *_Nullable response,
                                        NSError *_Nullable error) {
                      if (error != nil) {
                        [subscriber sendError:error];
                      } else if (data != nil) {
                        [subscriber sendNext:data];
                      }
                      [subscriber sendCompleted];
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
