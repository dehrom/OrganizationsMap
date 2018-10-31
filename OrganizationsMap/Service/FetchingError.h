#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol FetchingError <NSObject>
typedef enum : NSInteger {
    FetchingOrganizationsFailure,
    FetchingVisitsFailure,
} FetchingErrorType;
@end

NS_ASSUME_NONNULL_END
