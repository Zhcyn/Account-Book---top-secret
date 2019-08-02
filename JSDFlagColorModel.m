#import "JSDFlagColorModel.h"
@implementation JSDFlagColorModel
- (NSArray *)colorArray {
    if (!_colorArray) {
        _colorArray = @[@"#FF0000", @"#FFC0CB", @"#800080", @"#0000FF", @"#FFA500",@"#FFFF00",@"#A52A2A", @"#FF4500", @"#008000"
        ];
    }
    return _colorArray;
}
- (NSArray *)colorNameArray {
    if (!_colorNameArray) {
        _colorNameArray = @[@"Red", @"Pink",@"Purple", @"Blue", @"Orange", @"Yellow",@"Brown",@"Green"];
    }
    return _colorNameArray;
}
@end
