#import <Foundation/Foundation.h>
#import <Cephei/HBPreferences.h>
#import <UIKit/UIKit.h>

static bool kEnabled = false;
static NSData *kChosenImageDM = nil;
static NSData *kChosenImageLM = nil;

@interface SUICFlamesView : UIView
@property (nonatomic, retain) UIImageView *customImage;
@end