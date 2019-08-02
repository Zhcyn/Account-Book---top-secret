#import "JSDMyCenterContentVC.h"
#import <MDCAppBar.h>
#import "JSDPublic.h"
#import "JSDMyCenterVC.h"
#import <LocalAuthentication/LocalAuthentication.h>
@interface JSDMyCenterContentVC () <MyCenterCollectionViewControllerDelegate>
@property(nonatomic, strong) MDCAppBar *appBar;
@property(nonatomic, strong) JSDMyCenterVC *collectionViewController;
@end
@implementation JSDMyCenterContentVC
#pragma mark - 1.View Controller Life Cycle
- (instancetype)init {
    JSDMyCenterVC* collectionViewController = [[JSDMyCenterVC alloc] init];
    self = [super initWithContentViewController: collectionViewController];
    if (self) {
        _collectionViewController = collectionViewController;
        _collectionViewController.flexHeaderContainerVC = self;
        _collectionViewController.delegate = self;
        _appBar = [[MDCAppBar alloc] init];
        [self addChildViewController:_appBar.headerViewController];
        _appBar.headerViewController.headerView.backgroundColor = [UIColor clearColor];
        _appBar.navigationBar.tintColor = [UIColor whiteColor];
    }
    return self;
}
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
    [self.appBar addSubviewsToParent];
}
- (void)setupView {
    self.view.backgroundColor = [UIColor jsd_grayColor];
}
- (void)reloadView {
}
#pragma mark - 3.Request Data
- (void)setupData {
}
#pragma mark - 4.UITableViewDataSource and UITableViewDelegate
#pragma mark - 5.Event Response
- (void)didSelectSettings {
}
#pragma mark - 6.Private Methods
- (void)setupNotification {
}
#pragma mark - 7.GET & SET
@end
