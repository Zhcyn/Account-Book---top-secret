#import "JSDItemShowViewCell.h"
@implementation JSDItemShowViewCell
- (void)awakeFromNib {
    [super awakeFromNib];
    _titleLabel.font = [MDCTypography subheadFont];
    _titleLabel.textColor = [UIColor colorWithWhite:0 alpha:[MDCTypography subheadFontOpacity]];
    _titleLabel.shadowColor = nil;
    _titleLabel.shadowOffset = CGSizeZero;
    _titleLabel.textAlignment = NSTextAlignmentNatural;
    _titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    _titleLabel.numberOfLines = 2;
    _detailLabel.font = [MDCTypography body1Font];
    _detailLabel.textColor = [UIColor colorWithWhite:0 alpha:[MDCTypography captionFontOpacity]];
    _detailLabel.shadowColor = nil;
    _detailLabel.shadowOffset = CGSizeZero;
    _detailLabel.textAlignment = NSTextAlignmentNatural;
    _detailLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    _detailLabel.numberOfLines = 1;
    _detailLabel.font = [UIFont systemFontOfSize:13];
}
@end
