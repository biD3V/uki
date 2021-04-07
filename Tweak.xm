#import <UIKit/UIKit.h>
#import "UIView+Constraints.h"
#import "UKIPrefs.h"
#import "SileoHeaders.h"

static void loadPrefs() {
	[[UKIPrefs prefs] load];
}

// Empty hooks to prevent errors
%hook SileoTheme
%end

%hook SileoThemeManager
%end

%hook SileoPackageViewController
%property (nonatomic,retain) UIView *packageInfoBackground;

- (void)viewWillAppear:(BOOL)animated {
	%orig(animated);

	UKIPrefs *prefs = [UKIPrefs prefs];

	SileoPackageViewController *cast = self; // set correct class
	UIStackView *package = cast.packageInfoView;

	SileoTheme *theme = [[(SileoThemeManager*)objc_getClass("Sileo.SileoThemeManager") shared] currentTheme];

	// Create background for package
	cast.packageInfoBackground = [UIView new];
	[cast.packageInfoBackground setBackgroundColor:MSHookIvar<UIColor *>(theme, "secondaryBackgroundColor") ?: [UIColor secondarySystemBackgroundColor]];
	[cast.packageInfoBackground.layer setCornerRadius:prefs.corners ? 13 : (prefs.compact ? 23 : 31)];
	[cast.packageInfoBackground.layer setCornerCurve:kCACornerCurveContinuous];
	// Drop Shadow
	[cast.packageInfoBackground.layer setShadowOffset:CGSizeZero];
	[cast.packageInfoBackground.layer setShadowOpacity:0.2];
	[cast.packageInfoBackground.layer setShadowColor:[UIColor blackColor].CGColor];
	[cast.packageInfoBackground.layer setShadowRadius:6];

	[cast.packageInfoBackground setTranslatesAutoresizingMaskIntoConstraints:false];
	[package.superview addSubview:cast.packageInfoBackground];
	[package.superview bringSubviewToFront:package]; // move package info back to top

	if (prefs.compact) {
		[package setLayoutMargins:UIEdgeInsetsMake(8,8,8,8)];
	} else {
		[package setLayoutMargins:UIEdgeInsetsMake(16,16,16,16)];
	}

	// Change constraints
	[package removeSuperConstraints];
	[NSLayoutConstraint activateConstraints:@[
		[package.centerYAnchor constraintEqualToAnchor:cast.depictionHeaderView.bottomAnchor],
		[package.leadingAnchor constraintEqualToAnchor:package.superview.leadingAnchor constant:16],
		[package.trailingAnchor constraintEqualToAnchor:package.superview.trailingAnchor constant:-16]
	]];

	// Background constraints
	[cast.packageInfoBackground fill:package];

	// Round corners of header image
	[cast.depictionHeaderView.layer setMasksToBounds:true];
	[cast.depictionHeaderView.layer setCornerRadius:20];
	[cast.depictionHeaderView.layer setCornerCurve:kCACornerCurveContinuous];
	[cast.depictionHeaderView.layer setMaskedCorners: 12]; // only bottom corners
}

%end

%ctor {
	%init(SileoPackageViewController = objc_getClass("Sileo.PackageViewController"), SileoTheme = objc_getClass("Sileo.SileoTheme"), SileoThemeManager = objc_getClass("Sileo.SileoThemeManager"));
	[UKIPrefs prefs];
	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)loadPrefs, CFSTR("com.bid3v.ukiprefs.changed"), NULL, CFNotificationSuspensionBehaviorCoalesce);
}
