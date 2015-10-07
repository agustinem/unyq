

#import <UIKit/UIKit.h>

@interface APLViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageOverlay;
@property (strong, nonatomic) IBOutlet UIView *viewOver;

@property bool isReturn;
@property NSString *fileName;
@property NSString *imageNameOverlay;
@property UINavigationController *nav;
@property bool OnlyOne;
@end
