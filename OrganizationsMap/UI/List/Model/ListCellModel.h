#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ListCellModel : NSObject
@property (assign, readonly) int identifier;
@property (copy, nonatomic, nonnull, readonly) NSString *organizationName;
@property (copy, nonatomic, nonnull, readonly) NSString *organizationDescription;
- (instancetype)initWith:(int)identifier
                     and:(NSString *)organizationName
                     and:(NSString *)organizationDescription;
@end

NS_ASSUME_NONNULL_END
