#import "JSDMyCenterViewModel.h"
#import "JSDUserDataManage.h"
@implementation JSDMyCenterModel
@end
@implementation JSDMyCenterViewModel
- (NSArray<JSDMyCenterModel *> *)array {
    if (!_array) {
        _array = [JSDMyCenterModel mj_objectArrayWithKeyValuesArray: [self defaultArray]];
    }
    return _array;
}
- (NSArray* )defaultArray {
    JSDUserDataManage* userDataManage = [JSDUserDataManage sharedInstance];
    BOOL havaPassword = JSDIsString(userDataManage.passwordModel.passwrod) ? YES : NO;
    return @[@{@"title": havaPassword ? @"change Password" : @"set password",
               @"image": @"setting_password",
               @"router": havaPassword ? @"JSDModifiPasswordVC": @"JSDSettingPasswordVC",
              },
             @{@"title": @"password protection",
               @"image": @"password3",
               @"router": @"JSDPasswordSecurityVC",
             }, 
             @{@"title": @"Safety related",
               @"image": @"security_setting",
               @"router": @"JSDSecurityVC",
             },
             @{@"title": @"add category",
               @"image": @"add_type",
               @"router": @"JSDAddTypeVC",
             },
             @{@"title": @"Feedback",
               @"image": @"feedback",
               @"router": @"JSDFeedbackVC",
             },
             @{@"title": @"about us",
               @"image": @"about_my",
               @"router": @"JSDAboutWeVC",
             },];
}
@end
