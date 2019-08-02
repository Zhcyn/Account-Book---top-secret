#import <Foundation/Foundation.h>
#import "JSDItemListViewModel.h"
@interface JSDSearchViewModel : NSObject
@property (nonatomic, strong) NSMutableArray<JSDItemListModel* >* listArray; 
@property (nonatomic, strong) NSMutableArray<JSDItemListModel* >* resultArray; 
@property (nonatomic, copy) NSString* type; 
@property (nonatomic, copy) NSString* searchText; 
- (void)executeSearchWithText:(NSString *)text type:(NSString *)type complection:(void (^)(void))complection;
@end
