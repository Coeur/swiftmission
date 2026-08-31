// This file Copyright © Transmission authors and contributors.
// It may be used under the MIT (SPDX: MIT) license.
// License text can be found in the licenses/ folder.

#import "FilterButton.h"
#import "NSStringAdditions.h"

@interface FilterButton ()

/// Button on its left.
@property(nonatomic) IBOutlet FilterButton* previousButton;

@end

@implementation FilterButton

- (instancetype)initWithCoder:(NSCoder*)coder
{
    if ((self = [super initWithCoder:coder]))
    {
        _count = NSNotFound;
    }
    return self;
}

- (void)setFrame:(NSRect)frame
{
    // The native NSButtonTextField is removed from the view hierarchy at unpredictable times by `[NSButtonAppearanceBasedVisualProvider removeTextField]`.
    // That removal is later followed by the re-addition of a new textfield.
    // But the containing NSStackView is also misframing the buttons, ignoring layout constraints.
    // Apple switched development to SwiftUI and will probably not fix this, so we override the frame ourselves.

    if (frame.size.width < 20)
    {
        // Prevent buttons from disappearing
        frame.size.width = 20;
    }
    if (self.previousButton)
    {
        // Prevents the NSStackView superposing the buttons
        frame.origin.x = NSMaxX(self.previousButton.frame) + 1;
    }
    [super setFrame:frame];
}

- (void)setCount:(NSUInteger)count
{
    if (count == _count)
    {
        return;
    }

    _count = count;

    self.toolTip = count == 1 ?
        NSLocalizedString(@"1 transfer", "Filter Button -> tool tip") :
        [NSString localizedStringWithFormat:NSLocalizedString(@"%lu transfers", "Filter Bar Button -> tool tip"), count];
}

@end
