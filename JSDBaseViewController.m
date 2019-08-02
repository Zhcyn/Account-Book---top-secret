#import "JSDBaseViewController.h"
@interface JSDBaseViewController ()
@end
@implementation JSDBaseViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigation];
}
- (void)setupNavigation {
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@""
                                                                   style:UIBarButtonItemStyleDone
                                                                  target:self
                                                                  action:@selector(didTapBack:)];
    UIImage *backImage = [UIImage imageNamed:@"back"];
    backButton.image = backImage;
    backButton.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = backButton;
    self.navigationItem.rightBarButtonItem = nil;
}
- (void)didTapBack:(id)button {
    if (self.navigationController) {
        if (self.navigationController.childViewControllers.count == 1) {
            [self dismissViewControllerAnimated:YES completion:nil];
        } else {
            [self.navigationController popViewControllerAnimated:YES];
        }
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
@end
