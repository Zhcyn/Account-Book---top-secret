#import "JSDTabBarController.h"
#import "JSDHomeViewController.h"
#import "JSDBaseNavigationController.h"
#import "JSDMyCenterVC.h"
#import "JSDPlusButton.h"
#import "JSDPublic.h"
#import <MaterialAppBar.h>
#import "JSDMyCenterContentVC.h"
@interface JSDTabBarController ()
@end
@implementation JSDTabBarController
- (instancetype)init {
    if (!(self = [super init])) {
        return nil;
    }
    UIEdgeInsets imageInsets = UIEdgeInsetsZero;
    UIOffset titlePositionAdjustment = UIOffsetMake(0, -3.5);
    CYLTabBarController* tabBarController = [CYLTabBarController tabBarControllerWithViewControllers:self.viewControllers  tabBarItemsAttributes:[self tabBarItemsAttributesForController] imageInsets:imageInsets titlePositionAdjustment:titlePositionAdjustment];
    [self customizeTabBarAppearance:tabBarController];
    self.navigationController.navigationBar.hidden = YES;
    return (self = (JSDTabBarController *)tabBarController);
}
- (void)customizeTabBarAppearance:(CYLTabBarController *)tabBarController {
    [tabBarController setTintColor:[UIColor jsd_skyBluecolor]];
}
- (NSArray *)tabBarItemsAttributesForController {
    NSDictionary *firstTabBarItemsAttributes = @{
        CYLTabBarItemTitle : @"Home",
        CYLTabBarItemImage : @"home_defalut",
        CYLTabBarItemSelectedImage : @"home_selected",  
    };
    NSDictionary *secondTabBarItemsAttributes = @{
        CYLTabBarItemTitle : @"User",
        CYLTabBarItemImage : @"my_defalut",
        CYLTabBarItemSelectedImage : @"my_selected",
    };
    NSArray *tabBarItemsAttributes = @[
        firstTabBarItemsAttributes,
        secondTabBarItemsAttributes,
    ];
    return tabBarItemsAttributes;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [JSDPlusButton registerPlusButton];
}
#pragma mark -- set  && get
- (NSArray *)viewControllers {
    UIViewController *homeViewController = [[JSDHomeViewController alloc] init];
    UIViewController *homeNavigationController = [[JSDBaseNavigationController alloc]
                                                   initWithRootViewController:homeViewController];
    [homeViewController cyl_setHideNavigationBarSeparator:NO];
    JSDMyCenterContentVC *myCenterVC = [[JSDMyCenterContentVC alloc] init];
    NSArray *viewControllers = @[
        homeNavigationController,
        myCenterVC,
    ];
    return viewControllers;
}
@end
