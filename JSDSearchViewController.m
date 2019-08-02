#import "JSDSearchViewController.h"
#import "JSDPublic.h"
#import "JSDSearchViewModel.h"
#import <MaterialActivityIndicator.h>
#import <MaterialCollectionCells.h>
#import "JSDItemShowVC.h"
#import "JSDSearchViewCell.h"
@interface JSDSearchViewController () <UISearchBarDelegate>
@property (nonatomic, strong) UISearchBar* searchBar;
@property (nonatomic, strong) NSString* lastSearchText;
@property (nonatomic, strong) JSDSearchViewModel* searchManage;
@end
@implementation JSDSearchViewController
static NSString * const reuseIdentifier = @"Cell";
#pragma mark - 1.View Controller Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavBar];
    [self setupView];
    [self setupData];
    [self setupNotification];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - 2.SettingView and Style
- (void)setupNavBar {
    self.navigationItem.title = @"";
    UISearchBar* searchBar = [[UISearchBar alloc] init];
    _searchBar = searchBar;
    searchBar.showsCancelButton = YES;
    searchBar.delegate = self;
    searchBar.placeholder = @"Please enter a keyword search";
    [searchBar becomeFirstResponder];
    self.navigationItem.titleView = searchBar;
}
- (void)setupView {
    self.view.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerNib:[UINib nibWithNibName:@"JSDSearchViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier: reuseIdentifier];
    [self.collectionView registerClass:[MDCCollectionViewTextCell class]
            forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                   withReuseIdentifier:UICollectionElementKindSectionHeader];
    [self.collectionView registerClass:[MDCCollectionViewTextCell class]
            forSupplementaryViewOfKind:UICollectionElementKindSectionFooter
                   withReuseIdentifier:UICollectionElementKindSectionFooter];
}
- (void)reloadView {
}
#pragma mark - 3.Request Data
- (void)setupData {
}
#pragma mark <UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.searchManage.resultArray.count ? self.searchManage.resultArray.count : 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.searchManage.resultArray.count ? 1 : 0;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    JSDSearchViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.model = self.searchManage.resultArray[indexPath.section];
    return cell;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    MDCCollectionViewTextCell *supplementaryView =
    [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                       withReuseIdentifier:kind
                                              forIndexPath:indexPath];
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        NSString* text;
        if (self.searchManage.resultArray.count) {
            text = [NSString stringWithFormat:@"Search for included keywords \"%@\" Related data \"%ld\" ", self.searchBar.text, self.searchManage.resultArray.count];
        } else {
            if (JSDIsString(self.searchBar.text)) {
                text = @"No search for keyword content, please re-enter";
            } else {
                text = @"Search content keywords include (name, account, password, remarks)";
            }
        }
        supplementaryView.textLabel.text = text;
    } else if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        supplementaryView.contentView.backgroundColor = [UIColor grayColor];
    }
    return supplementaryView;
}
#pragma mark <UICollectionViewLayoutDelegate>
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.collectionView.jsd_width, 50);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (!section) {
        return CGSizeMake(self.collectionView.jsd_width, 50);
    } else {
        return CGSizeZero;
    }
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (section == 0) {
        return UIEdgeInsetsMake(5, 0, 0, 0);
    } else {
        return UIEdgeInsetsMake(1, 0, 0, 0);
    }
}
#pragma mark <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self.searchBar endEditing:YES];
    [super collectionView:collectionView didSelectItemAtIndexPath:indexPath];
    JSDItemShowVC* showVC = [[JSDItemShowVC alloc] init];
    showVC.model = self.searchManage.resultArray[indexPath.section];
    [self.navigationController pushViewController:showVC animated:YES];
}
#pragma mark - searchDeleagte
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [self.searchBar endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if (!JSDIsString(searchBar.text)) { 
        self.searchManage.resultArray = nil;
        self.lastSearchText = nil;
        [self.collectionView reloadData];
    }
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    if (searchBar.text.length) {
        if (![self.lastSearchText isEqualToString:searchBar.text]) {
            MDCActivityIndicator *activityIndicator = [[MDCActivityIndicator alloc] init];
            activityIndicator.center = CGPointMake(self.view.jsd_width / 2, self.view.jsd_height / 2);
            [self.view addSubview:activityIndicator];
            [activityIndicator startAnimating];
            @weakify(self)
            [self.searchManage executeSearchWithText:searchBar.text type:nil complection:^{
                @strongify(self)
                    [activityIndicator stopAnimating];
                    if (self.searchManage.resultArray.count) {
                        [self.searchBar endEditing:YES];
                    }
                    self.lastSearchText = searchBar.text;
                    [self.collectionView reloadData];
            }];
        } else {
        }
    }
}
#pragma mark - 5.Event Response
- (void)clickCollectionView:(id)sender
{
    CGPoint pointTouch = [sender locationInView:self.collectionView];
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:pointTouch];
    if (indexPath == nil) {
    } else {
        [self collectionView:self.collectionView didSelectItemAtIndexPath:indexPath];
    }
    [self.searchBar endEditing:YES];
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.searchBar endEditing:YES];
}
#pragma mark - 6.Private Methods
- (void)setupNotification {
}
#pragma mark - 7.GET & SET
- (JSDSearchViewModel *)searchManage {
    if (!_searchManage) {
        _searchManage = [[JSDSearchViewModel alloc] init];
    }
    return _searchManage;
}
@end
