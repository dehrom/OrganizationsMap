#import <Foundation/Foundation.h>
#import "Mantle/MTLJSONAdapter.h"
#import "Mantle/MTLModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface VisitDTOModel : MTLModel <MTLJSONSerializing>
@property (nonatomic, assign, readonly) int organizationId;
@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, assign, readonly) double latitude;
@property (nonatomic, assign, readonly) double longitude;
@end

NS_ASSUME_NONNULL_END
