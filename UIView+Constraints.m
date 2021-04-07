#import "UIView+Constraints.h"

@implementation UIView (Constraints)

- (void)removeSuperConstraints {
    for (NSLayoutConstraint *c in self.superview.constraints) {
        if (c.firstItem == self || c.secondItem == self) [self.superview removeConstraint:c];
    }
}

- (void)fill:(UIView *)view {
    [NSLayoutConstraint activateConstraints:@[
        [self.leadingAnchor constraintEqualToAnchor:view.leadingAnchor],
        [self.trailingAnchor constraintEqualToAnchor:view.trailingAnchor],
        [self.topAnchor constraintEqualToAnchor:view.topAnchor],
        [self.bottomAnchor constraintEqualToAnchor:view.bottomAnchor],
    ]];
}

@end