#import <Foundation/Foundation.h>
#import <ReactiveObjC/RACSignal.h>

@class OrganizationDTOModel;
@class VisitDTOModel;

NS_ASSUME_NONNULL_BEGIN

@interface ListFetchService_Local : NSObject
- (RACSignal<
    RACTwoTuple<NSArray<OrganizationDTOModel *> *, NSArray<VisitDTOModel *> *> *> *)
    fetch;
@end

NS_ASSUME_NONNULL_END
