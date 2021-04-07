@interface SileoPackageViewController : UIViewController

@property (nonatomic,retain) UIView *depictionHeaderView;
@property (nonatomic,retain) UIStackView *packageInfoView;
// new
@property (nonatomic,retain) UIView *packageInfoBackground;

@end

@interface SileoTheme : NSObject

@property (nonatomic,retain) UIColor *secondaryBackgroundColor;

@end

@interface SileoThemeManager

@property (nonatomic,retain) SileoTheme *currentTheme;
@property (nonatomic,retain) SileoThemeManager *shared;

+ (SileoThemeManager *)shared;

@end