#import <Foundation/Foundation.h>
#import "State.h"

@class ListSectionModel;

NS_ASSUME_NONNULL_BEGIN

@interface ListState : NSObject <State>
@property (assign, nonatomic, readonly) NSUInteger selectedOrganizationIndex;
@property (strong, nonatomic, nonnull, readonly) NSArray<ListSectionModel *> *models;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithModels:(NSArray<ListSectionModel *> *)models and:(StateStatus)status;
- (instancetype)initWithIndex:(NSUInteger)selectedOrganizationIndex and:(StateStatus)status;
@end

NS_ASSUME_NONNULL_END
