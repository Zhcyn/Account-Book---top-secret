#import "JSDMyCenterTextCell.h"
#import "JSDPublic.h"
@implementation JSDMyCenterTextCell
- (void)awakeFromNib {
    [super awakeFromNib];
    self.layer.cornerRadius = 10;
    self.layer.masksToBounds = YES;
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.textLabel.adjustsFontSizeToFitWidth = YES;
        self.layer.cornerRadius = 10;
        self.layer.masksToBounds = YES;
    }
    return self;
}
@end
