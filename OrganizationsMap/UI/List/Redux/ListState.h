#import <Foundation/Foundation.h>
#import "State.h"

@class ListSectionModel;

NS_ASSUME_NONNULL_BEGIN

@interface ListState : NSObject <State>
@property (assign, nonatomic, readonly) NSUInteger selectedOrganizationIndex;
@property (strong, nonatomic, readonly) NSArray<ListSectionModel *> *models;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithModels:(NSArray<ListSectionModel *> *)models
                         index:(NSUInteger)selectedOrganizationIndex
                        status:(StateStatus)newStatus;
@end

NS_ASSUME_NONNULL_END
