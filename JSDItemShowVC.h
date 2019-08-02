#import "JSDBaseCollectionController.h"
#import "JSDPublic.h"
NS_ASSUME_NONNULL_BEGIN
@interface JSDItemShowVC : JSDBaseCollectionController
@property (nonatomic, strong) JSDItemListModel* model;
@property (nonatomic, copy) NSString* typeName;
@property (nonatomic, strong) JSDItemListViewModel* viewModel;
@end
NS_ASSUME_NONNULL_END
