#import "UKIPrefs.h"

@implementation UKIPrefs

+ (UKIPrefs *)prefs {
    static dispatch_once_t once;
    static UKIPrefs *shared;
    dispatch_once(&once, ^{
        shared = [UKIPrefs new];
        [shared load];
    });
    return shared;
}

- (void)load {
    self.prefsDict = [[NSDictionary alloc] initWithContentsOfFile:@"/User/Library/Preferences/com.bid3v.ukiprefs.plist"];

    self.compact = [self.prefsDict objectForKey:@"compact"] ? [[self.prefsDict objectForKey:@"compact"] boolValue] : false;
    self.corners = [self.prefsDict objectForKey:@"corners"] ? [[self.prefsDict objectForKey:@"corners"] boolValue] : false;
}

@end