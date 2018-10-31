#import <Foundation/Foundation.h>
#import "ListFetchServiceProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface ListFetchService : NSObject <ListFetchServiceProtocol>
- (RACSignal<RACTwoTuple<NSArray<OrganizationDTOModel *> *, NSArray<VisitDTOModel *> *> *> *)fetch;
@end

NS_ASSUME_NONNULL_END
