#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ListSectionModel : NSObject
@property (nonatomic, assign, readonly) int organizationId;
@property (nonatomic, copy, nonnull, readonly) NSString *title;
@property (nonatomic, strong, nonnull, readonly) NSArray<NSString *> *visits;
- (instancetype)initWith:(int)organizationId
                   title:(NSString *)title
                  visits:(NSArray<NSString *> *)visits;
@end

NS_ASSUME_NONNULL_END
