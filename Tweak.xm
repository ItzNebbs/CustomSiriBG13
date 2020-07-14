#import "Tweak.h"

%hook SUICFlamesView
	%property (nonatomic, retain) UIImage *customImage;
	- (void)layoutSubviews {
		%orig;
		if (kEnabled) {
			NSData *imageData = nil;
			if ([UITraitCollection currentTraitCollection].userInterfaceStyle == UIUserInterfaceStyleDark) {
				imageData = kChosenImageDM;
			} else {
				imageData = kChosenImageLM;
			}
			UIImage *chosenImage = [UIImage imageWithData:imageData];
			self.customImage = [[UIImageView alloc] initWithImage: chosenImage];
			self.customImage.frame = [UIScreen mainScreen].bounds;
			self.customImage.contentMode = UIViewContentModeScaleAspectFit;
			self.customImage.userInteractionEnabled = NO;
			self.customImage.alpha = 0;
			self.customImage.hidden = NO;
			[UIView animateWithDuration:0.4
				animations:^{
					self.customImage.alpha = 1;
				}
			];
			[self insertSubview:self.customImage atIndex:0];
		}
	}
%end

%ctor {
	HBPreferences *prefs = [[HBPreferences alloc] initWithIdentifier:@"xyz.tylerd3v.customsiribg13"];
	kEnabled = [([prefs objectForKey:@"kEnabled"] ?: @(NO)) boolValue];
	kChosenImageDM = [prefs objectForKey:@"kChosenImageDM"];
	kChosenImageLM = [prefs objectForKey:@"kChosenImageLM"];
}