//
//  FilterStackView.mm
//  Transmission
//
//  Created by Antoine Cœur on 30/08/2026.
//  Copyright © 2026 The Transmission Project. All rights reserved.
//

#import "FilterStackView.h"

NS_ASSUME_NONNULL_BEGIN

@interface FilterStackView () <NSStackViewDelegate>

@end

@implementation FilterStackView

- (nullable instancetype)initWithCoder:(NSCoder *)coder
{
//    [self setDelegate:self];
    return [super initWithCoder:coder];
}

- (void)layoutSubtreeIfNeeded
{
    [super layoutSubtreeIfNeeded];
}

- (void)setFrame:(NSRect)frame
{
    [super setFrame:frame];

//    for (NSView *view in self.views) {
//        NSStackViewVisibilityPriority x = [self visibilityPriorityForView:view];
//        if (x != NSStackViewVisibilityPriorityMustHold) {
//            NSLog(@"Antoine visibility %@", @(x));
//            [self setVisibilityPriority:NSStackViewVisibilityPriorityMustHold forView:view];
//        }
//    }
}

- (void)stackView:(NSStackView *)stackView willDetachViews:(NSArray<NSView *> *)views
{
    NSLog(@"willDetachViews %@", views);
}

@end

NS_ASSUME_NONNULL_END
