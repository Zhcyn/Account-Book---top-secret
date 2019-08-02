#import "MDCCollectionViewCell.h"
#import "JSDPublic.h"
NS_ASSUME_NONNULL_BEGIN
@interface JSDItemShowViewCell : MDCCollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@end
NS_ASSUME_NONNULL_END
