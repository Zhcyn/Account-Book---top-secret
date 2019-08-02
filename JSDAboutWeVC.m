#import "JSDAboutWeVC.h"
#import "JSDPublic.h"
@interface JSDAboutWeVC ()
@end
@implementation JSDAboutWeVC
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
    self.navigationItem.title = @"about us";
}
- (void)setupView {
    self.view.backgroundColor = [UIColor jsd_grayColor];
    [self.collectionView registerClass:[MDCCollectionViewTextCell class] forCellWithReuseIdentifier:@"cell"];
    self.styler.cellStyle = MDCCollectionViewCellStyleCard;
}
- (void)reloadView {
}
#pragma mark - 3.Request Data
- (void)setupData {
}
#pragma mark - 4.UITableViewDataSource and UITableViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 2;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MDCCollectionViewTextCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    if (indexPath.row == 0) {
        cell.textLabel.text = @"App version";
        cell.detailTextLabel.text = @"1.0.0";
    } else if (indexPath.row == 1) {
        cell.textLabel.text = @"Data Security";
        cell.detailTextLabel.numberOfLines = 3;
        cell.detailTextLabel.text = @"Please be assured that the App data information (account password, etc.) is only stored in the phone and will not be backed up by the server.";
    } else {
        cell.detailTextLabel.numberOfLines = 2;
        cell.textLabel.text = @"Official website";
        cell.detailTextLabel.text = @"https://www.jianshu.com/p/216691edbd0d";
    }
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [super collectionView:collectionView didSelectItemAtIndexPath:indexPath];
    if (indexPath.row == 2) {
        JSDSnackManage* snackManage = [JSDSnackManage sharedInstance];
        UIPasteboard* pasterboard = [[UIPasteboard alloc] init];
        pasterboard.string = @"https://www.jianshu.com/p/216691edbd0d";
        [snackManage showText:@"The official website has been copied to the clipboard"];
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize size = [super collectionView:collectionView layout:collectionViewLayout sizeForItemAtIndexPath:indexPath];
    return CGSizeMake(size.width, 100);
}
#pragma mark - 5.Event Response
#pragma mark - 6.Private Methods
- (void)setupNotification {
}
#pragma mark - 7.GET & SET
@end
