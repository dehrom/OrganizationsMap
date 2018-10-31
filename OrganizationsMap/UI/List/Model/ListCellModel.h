#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ListCellModel : NSObject
@property (copy, nonatomic, nonnull, readonly) NSString *organizationName;
@property (copy, nonatomic, nonnull, readonly) NSString *organizationDescription;
- (instancetype)initWith:(NSString *)organizationName
                     and:(NSString *)organizationDescription;
@end

NS_ASSUME_NONNULL_END
