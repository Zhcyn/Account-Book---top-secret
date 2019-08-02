#import "JSDSearchViewCell.h"
@interface JSDSearchViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *accountLabel;
@property (weak, nonatomic) IBOutlet UILabel *passwordLabel;
@end
@implementation JSDSearchViewCell
- (void)awakeFromNib {
    [super awakeFromNib];
    self.titleLabel.adjustsFontSizeToFitWidth = YES;
}
- (void)setModel:(JSDItemListModel *)model {
    _model = model;
    self.titleLabel.text = model.name;
    self.accountLabel.text = model.account;
    self.passwordLabel.text = model.password;
}
@end
