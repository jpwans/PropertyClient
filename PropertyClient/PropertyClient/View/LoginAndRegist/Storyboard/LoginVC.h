

#import <UIKit/UIKit.h>

@interface LoginVC : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *_userNameField;
@property (strong, nonatomic) IBOutlet UITextField *_passWordField;
@property (strong, nonatomic) IBOutlet UIButton *_loginButton;
@property (strong, nonatomic) IBOutlet UIImageView *_rememberPassImageView;
@property (strong, nonatomic) IBOutlet UIButton *_rememberPassButton;

@property (weak, nonatomic) IBOutlet UIImageView *logoImageVIew;
@property (weak, nonatomic) IBOutlet UIView *logoview;


- (void)loginOutForRetsetPassword;
@end

