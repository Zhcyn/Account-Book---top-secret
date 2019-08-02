#import "JSDMyCenterVC.h"
#import <MaterialComponents/MaterialCollectionCells.h>
#import <MDCFlexibleHeaderViewController.h>
#import <MaterialFlexibleHeader.h>
#import <MDCShadowLayer.h>
#import "JSDPublic.h"
#import "JSDMyCenterTextCell.h"
#import "JSDMyCenterViewModel.h"
NSString* const kMyCenterDataUpdateNotifaction = @"myCenterDataUpdateNotifaction";
static CGFloat kMyCenterCollectionViewControllerDefaultHeaderHeight = 164.f;
static CGFloat kMyCenterCollectionViewControllerSmallHeaderHeight = 64.f;
static CGFloat kMyCenterCollectionViewControllerAnimationDuration = 0.33f;
@interface JSDMyCenterVC ()
@property(nonatomic) UIView *logoSmallView;
@property(nonatomic) UIView *logoView;
@property(nonatomic) CGFloat logoScale;
@property(nonatomic) MDCInkTouchController *inkTouchController;
@property (nonatomic, strong) JSDMyCenterViewModel* viewModel;
@end
@implementation JSDMyCenterVC
static NSString * const reuseIdentifier = @"Cell";
#pragma mark - 1.View Controller Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavBar];
    [self setupView];
    [self setupData];
    [self setupNotification];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self centerHeaderWithSize:self.view.frame.size];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - 2.SettingView and Style
- (void)setupNavBar {
    self.navigationItem.title = @"";
}
- (void)setupView {
    self.view.backgroundColor = [UIColor grayColor];
    [self.collectionView registerClass:[JSDMyCenterTextCell class] forCellWithReuseIdentifier:reuseIdentifier];
}
- (void)reloadView {
}
#pragma mark - 3.Request Data
- (void)setupData {
}
#pragma mark - 4.UITableViewDataSource and UITableViewDelegate
#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    self.scrollOffsetY = scrollView.contentOffset.y;
    [self.flexHeaderContainerVC.headerViewController scrollViewDidScroll:scrollView];
    [self centerHeaderWithSize:self.view.frame.size];
    self.logoScale = scrollView.contentOffset.y / - kMyCenterCollectionViewControllerDefaultHeaderHeight;
    if (self.logoScale < 0.5f) {
        self.logoScale = 0.5f;
        [UIView animateWithDuration:kMyCenterCollectionViewControllerAnimationDuration
                              delay:0
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
            self.logoView.layer.opacity = 0;
            self.logoSmallView.layer.opacity = 1.f;
        }
                         completion:^(BOOL finished){
        }];
    } else {
        [UIView animateWithDuration:kMyCenterCollectionViewControllerAnimationDuration
                              delay:0
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
            self.logoView.layer.opacity = 1.f;
            self.logoSmallView.layer.opacity = 0;
        }
                         completion:^(BOOL finished){
        }];
    }
    self.logoView.transform =
    CGAffineTransformScale(CGAffineTransformIdentity, self.logoScale, self.logoScale);
}
#pragma mark <UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.viewModel.array.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    JSDMyCenterTextCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    JSDMyCenterModel* model = self.viewModel.array[indexPath.row];
    cell.textLabel.text = model.title;
    if (JSDIsString(model.image)) {
        cell.imageView.image = [UIImage jsd_imageName:model.image];
    }
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((ScreenWidth - 50) / 2, 100);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 15, 10, 15);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 15;
}
#pragma mark - CollectionViewDeleagte
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [super collectionView:collectionView didSelectItemAtIndexPath:indexPath];
    JSDMyCenterModel* model = self.viewModel.array[indexPath.row];
    if (JSDIsString(model.router)) {
        UIViewController* vc = [[NSClassFromString(model.router) alloc] init];
        JSDBaseNavigationController *navVC = [[JSDBaseNavigationController alloc] initWithRootViewController:vc];
        [self presentViewController:navVC animated:YES completion:nil];
    }
}
#pragma mark - 5.Event Response
#pragma mark - 6.Private Methods
- (void)setupNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateNotication:) name:kMyCenterDataUpdateNotifaction object:nil];
}
- (void)updateNotication:(id)notifacation {
    self.viewModel.array = nil;
    [self.collectionView reloadData];
}
- (void)centerHeaderWithSize:(CGSize)size {
    CGFloat statusBarHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
    CGFloat width = size.width;
    CGRect headerFrame = self.flexHeaderContainerVC.headerViewController.headerView.bounds;
    self.logoView.center = CGPointMake(width / 2.f, headerFrame.size.height / 2.f);
    self.logoSmallView.center =
    CGPointMake(width / 2.f, (headerFrame.size.height - statusBarHeight) / 2.f + statusBarHeight);
}
#pragma mark - 7.GET & SET
- (UIView *)pestoHeaderView {
   CGRect headerFrame = _flexHeaderContainerVC.headerViewController.headerView.bounds;
    UIView *pestoHeaderView = [[UIView alloc] initWithFrame:headerFrame];
    pestoHeaderView.backgroundColor = [UIColor jsd_skyBluecolor];
    pestoHeaderView.layer.masksToBounds = YES;
    pestoHeaderView.autoresizingMask =
    (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    NSString* path = [[NSBundle mainBundle] pathForResource:@"bigLog" ofType:@"jpg"];
    UIImage* image = [UIImage imageWithContentsOfFile:path];
    _logoView = [[UIImageView alloc] initWithImage:image];
    _logoView.contentMode = UIViewContentModeScaleAspectFill;
    _logoView.center =
    CGPointMake(pestoHeaderView.frame.size.width / 2.f, pestoHeaderView.frame.size.height / 2.f);
    [pestoHeaderView addSubview:_logoView];
    UIImage *logoSmallImage = [UIImage imageNamed:@"smalAppLog2"];
    _logoSmallView = [[UIImageView alloc] initWithImage:logoSmallImage];
    _logoSmallView.contentMode = UIViewContentModeScaleAspectFill;
    _logoSmallView.layer.opacity = 0;
    [pestoHeaderView addSubview:_logoSmallView];
    _inkTouchController = [[MDCInkTouchController alloc] initWithView:pestoHeaderView];
    [_inkTouchController addInkView];
    return pestoHeaderView;
}
- (void)setFlexHeaderContainerVC:(JSDMyCenterContentVC *)flexHeaderContainerVC {
    _flexHeaderContainerVC = flexHeaderContainerVC;
    MDCFlexibleHeaderView *headerView = _flexHeaderContainerVC.headerViewController.headerView;
    headerView.trackingScrollView = self.collectionView;
    headerView.maximumHeight = kMyCenterCollectionViewControllerDefaultHeaderHeight;
    headerView.minimumHeight = kMyCenterCollectionViewControllerSmallHeaderHeight;
    headerView.minMaxHeightIncludesSafeArea = NO;
    [headerView addSubview:[self pestoHeaderView]];
    MDCShadowLayer *shadowLayer = [MDCShadowLayer layer];
    [headerView setShadowLayer:shadowLayer
       intensityDidChangeBlock:^(CALayer *layer, CGFloat intensity) {
        CGFloat elevation = MDCShadowElevationAppBar * intensity;
        [(MDCShadowLayer *)layer setElevation:elevation];
    }];
}
- (JSDMyCenterViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[JSDMyCenterViewModel alloc] init];
    }
    return _viewModel;
}
@end
