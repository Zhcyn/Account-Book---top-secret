#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
@interface JSDMyCenterModel : NSObject
@property (nonatomic, copy) NSString* image;
@property (nonatomic, copy) NSString* title;
@property (nonatomic, copy) NSString* router;
@end
@interface JSDMyCenterViewModel : NSObject
@property (nonatomic, strong, nullable) NSArray<JSDMyCenterModel *>* array;
@end
NS_ASSUME_NONNULL_END
