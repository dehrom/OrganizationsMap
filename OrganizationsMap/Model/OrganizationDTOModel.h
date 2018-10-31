#import <Foundation/Foundation.h>
#import "Mantle/MTLJSONAdapter.h"
#import "Mantle/MTLModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface OrganizationDTOModel : MTLModel <MTLJSONSerializing>
@property (nonatomic, assign, readonly) NSInteger organizationId;
@property (nonatomic, copy, readonly) NSString *visitDetail;
@end

NS_ASSUME_NONNULL_END
