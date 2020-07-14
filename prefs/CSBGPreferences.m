#import "CSBGPreferences.h"

@implementation CSBGPreferences
- (instancetype)init {
	self = [super init];
	if (self) {
		HBAppearanceSettings *appearanceSettings = [[HBAppearanceSettings alloc] init];
		appearanceSettings.tintColor = [UIColor colorWithRed: 0.00 green: 0.48 blue: 1.00 alpha: 1.00];
		appearanceSettings.tableViewCellSeparatorColor = [UIColor clearColor];
		self.hb_appearanceSettings = appearanceSettings;
		self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]  initWithTitle:@"Apply" style:UIBarButtonItemStylePlain target:self action:@selector(apply:)];
	}
	return self;
}
- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [self loadSpecifiersFromPlistName:@"Root" target:self];
	}
	return _specifiers;
}
- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	CGRect frame = self.table.bounds;
	frame.origin.y = -frame.size.height;
	[self.navigationController.navigationController.navigationBar setShadowImage: [UIImage new]];
	self.navigationController.navigationController.navigationBar.translucent = YES;
}
- (void)apply:(id)sender {
	UIAlertController *ApplyChanges = [
		UIAlertController alertControllerWithTitle:@"Apply Changes?"
		message:@"Are you sure you want to apply changes?"
		preferredStyle:UIAlertControllerStyleAlert
	];
	UIAlertAction *noApply = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleDefault handler:nil];
	UIAlertAction *yesApply = [
		UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
			pid_t pid;
			const char* args[] = {"killall", "backboardd", NULL};
			posix_spawn(&pid, "/usr/bin/killall", NULL, NULL, (char* const*)args, NULL);
		}
	];
	[ApplyChanges addAction:noApply];
	[ApplyChanges addAction:yesApply];
	[self presentViewController:ApplyChanges animated: YES completion: nil];
}
- (void)viewSourceCode {
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://github.com/TylerD3V/CustomSiriBG13"]];
}
@end