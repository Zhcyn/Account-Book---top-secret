#import "JSDSearchViewModel.h"
#import "JSDHomeModel.h"
#import "JSDFlagColorModel.h"
@interface JSDSearchViewModel ()
@property (nonatomic, strong) JSDFlagColorModel* colorModel;
@end
@implementation JSDSearchViewModel
- (void)executeSearchWithText:(NSString *)text type:(NSString *)type complection:(void (^)(void))complection {
    _searchText = text;
    _type = type;
    NSMutableArray* templateArray = [[NSMutableArray alloc] init];
    NSLog(@"%ld", self.listArray.count);
    for (JSDItemListViewModel* listModel in self.listArray) {
        for (JSDItemListModel* itemModel in listModel.itemList) {
            if ([itemModel.name localizedCaseInsensitiveContainsString:text]) {
                [templateArray addObject:itemModel];
                continue;
            } else if ([itemModel.account localizedCaseInsensitiveContainsString:text]) {
                [templateArray addObject:itemModel];
                continue;
            } else if ([itemModel.password localizedCaseInsensitiveContainsString:text]) {
                [templateArray addObject:itemModel];
                continue;
            } else if ([self.colorModel.colorNameArray containsObject:text]) {
                if (JSDIsString(itemModel.type)) {
                    NSInteger index = [self.colorModel.colorNameArray indexOfObject:text];
                    if ([itemModel.type isEqualToString:self.colorModel.colorArray[index]]) {
                        [templateArray addObject:itemModel];
                    }
                }
                continue;
            } else if ([itemModel.remark localizedCaseInsensitiveContainsString:text]) {
                [templateArray addObject:itemModel];
                continue;
            }
        }
    }
    self.resultArray = templateArray;
    complection ? complection () : NULL;
}
- (NSMutableArray<JSDItemListModel *> *)listArray {
    if (!_listArray) {
        NSArray* typeArray = [[JSDHomeViewModel alloc] init].typeArray;
        NSMutableArray* tempArray = [[NSMutableArray alloc] init];
        for (JSDHomeModel* model in typeArray) {
            JSDItemListViewModel* listModel = [[JSDItemListViewModel alloc] init];
            listModel.type = model.title;
            if (listModel.itemList.count) {
                [tempArray addObject:listModel];
            }
        }
        _listArray = tempArray;
    }
    return _listArray;
}
- (JSDFlagColorModel *)colorModel {
    if (!_colorModel) {
        _colorModel = [[JSDFlagColorModel alloc] init];
    }
    return _colorModel;
}
@end
