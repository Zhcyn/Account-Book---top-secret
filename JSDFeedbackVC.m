#import "JSDFeedbackVC.h"
#import <MessageUI/MessageUI.h>
@interface JSDFeedbackVC () <MFMailComposeViewControllerDelegate>
@property (nonatomic, strong) UILabel* tipLabel;
@property (nonatomic, strong) MDCRaisedButton* senderEmail;
@property (nonatomic, copy) NSString* emailText;
@end
@implementation JSDFeedbackVC
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
    self.navigationItem.title = @"Feedback";
}
- (void)setupView {
    self.view.backgroundColor = [UIColor jsd_grayColor];
    [self.view addSubview:self.tipLabel];
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(30);
        make.centerX.mas_equalTo(0);
        make.left.mas_equalTo(30);
        make.right.mas_equalTo(-30);
    }];
    self.senderEmail = [[MDCRaisedButton alloc] init];
    [self.senderEmail setTitle:@"send email" forState:UIControlStateNormal];
    [self.senderEmail addTarget:self action:@selector(onTouchSendEmail:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.senderEmail];
    [self.senderEmail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(self.tipLabel.mas_bottom).mas_equalTo(30);
    }];
    if ([MFMailComposeViewController canSendMail]) {
        [self setupEmailAction]; 
    }else{
        UIAlertView* alerView = [[UIAlertView alloc] initWithTitle:@"Tips" message:@"Please open \"(Mail App)\" to set your email account" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alerView show];
    }
}
-(void)setupEmailAction{
    MFMailComposeViewController *mailCompose = [[MFMailComposeViewController alloc] init];
    [mailCompose setMailComposeDelegate:self];
    [mailCompose setToRecipients:@[@"jsonkeny@gmail.com"]];
    [mailCompose setSubject:@"App Use feedback"];
    NSString *emailContent = @" I have found a problem using the App process..";
    [mailCompose setMessageBody:emailContent isHTML:NO];
    [self presentViewController:mailCompose animated:YES completion:nil];
}
- (void)reloadView {
}
#pragma mark - 3.Request Data
- (void)setupData {
}
#pragma mark - 4.UITableViewDataSource and UITableViewDelegate
#pragma mark - MFMailComposeViewControllerDelegate的代理方法：
-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    switch (result) {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail send canceled: User cancels editing");
            break;
        case MFMailComposeResultSaved:
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent: User click to send");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail send errored: %@ : User failed to try to save or send mail", [error localizedDescription]);
            break;
    }
    JSDSnackManage* snackManage = [JSDSnackManage sharedInstance];
    [self dismissViewControllerAnimated:YES completion: ^{
        [snackManage showText:@"Thank you very much for your use, we will carefully review the information you have feedback, and try to improve!"];
    }];
}
#pragma mark - 5.Event Response
- (void)onTouchSendEmail:(id) sender {
    if ([MFMailComposeViewController canSendMail]) {
        [self setupEmailAction]; 
    }else{
        UIAlertView* alerView = [[UIAlertView alloc] initWithTitle:@"Tips" message:@"Please open \"(Mail App)\" to set your email account" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alerView show];
    }
}
#pragma mark - 6.Private Methods
- (void)setupNotification {
}
#pragma mark - 7.GET & SET
- (UILabel *)tipLabel {
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] init];
        _tipLabel.font = [UIFont systemFontOfSize:20];
        _tipLabel.numberOfLines = 0;
        _tipLabel.text = @"Thank you for your use, welcome to give us any suggestions!";
    }
    return _tipLabel;
}
@end
