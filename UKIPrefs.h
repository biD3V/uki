#import <Foundation/Foundation.h>

@interface UKIPrefs : NSObject

@property (nonatomic,retain) NSDictionary *prefsDict;
@property (nonatomic) BOOL compact;
@property (nonatomic) BOOL corners;

+ (UKIPrefs *)prefs;
- (void)load;

@end