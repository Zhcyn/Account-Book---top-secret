#import "MDCCollectionViewController.h"
#import "MDCFlexibleHeaderContainerViewController.h"
#import "JSDMyCenterContentVC.h"
NS_ASSUME_NONNULL_BEGIN
extern NSString* const kMyCenterDataUpdateNotifaction;
@class MDCCollectionViewCell;
@protocol MyCenterCollectionViewControllerDelegate <NSObject>
@optional
- (void)didSelectCell:(MDCCollectionViewCell *)cell
           completion:(void (^)(void))completionBlock;
@end
@interface JSDMyCenterVC : MDCCollectionViewController
@property(nonatomic) CGFloat scrollOffsetY;
@property(weak, nonatomic) id<MyCenterCollectionViewControllerDelegate> delegate;
@property(nonatomic) JSDMyCenterContentVC *flexHeaderContainerVC;
@end
NS_ASSUME_NONNULL_END
