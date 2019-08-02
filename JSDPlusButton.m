#import "JSDPlusButton.h"
#import "JSDPublic.h"
#import "JSDAddTypeVC.h"
#import "JSDBaseNavigationController.h"
#import "JSDAddNoteToTypeVC.h"
@implementation JSDPlusButton
+ (id)plusButton {
    JSDPlusButton* flatButton = [[JSDPlusButton alloc] init];
    [flatButton setImage:[UIImage jsd_imageName:@"add"] forState:UIControlStateNormal];
    [flatButton jsd_setsize:CGSizeMake(60, 60)];
    return flatButton;
}
+ (UIViewController *)plusChildViewController {
    JSDAddNoteToTypeVC* addNoteToTypeVC = [[JSDAddNoteToTypeVC alloc] init];
    JSDBaseNavigationController* addTypenavigationVC = [[JSDBaseNavigationController alloc] initWithRootViewController:addNoteToTypeVC];
    addNoteToTypeVC.viewModel = [[JSDItemListViewModel alloc] initWithType:@"Account"];
    return addTypenavigationVC;
}
+ (NSUInteger)indexOfPlusButtonInTabBar {
    return 1;
}
+ (CGFloat)multiplierOfTabBarHeight:(CGFloat)tabBarHeight {
    return 0.1;
}
@end
