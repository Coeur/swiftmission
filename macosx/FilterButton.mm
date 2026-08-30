// This file Copyright © Transmission authors and contributors.
// It may be used under the MIT (SPDX: MIT) license.
// License text can be found in the licenses/ folder.

#import "FilterButton.h"
#import "NSStringAdditions.h"

@interface FilterButton ()
/// Native NSButtonTextField that holds the correct frame.
@property(nonatomic, strong) NSTextField* originalTextField;
/// Copy never removed from the subviews.
@property(nonatomic, strong) NSTextField* mimicTextField;

@property(nonatomic) IBOutlet FilterButton *previousButton;

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

- (void)addSubview:(NSView *)view
{
    // The native NSButtonTextField is removed from the view hierarchy at impredictable times by `[NSButtonAppearanceBasedVisualProvider removeTextField]`.
    // That removal is sometimes followed by the re-addition of a new textfield.
    // Apple switched development to SwiftUI and will probably not fix this.
    // A workaround is to handle our own NSTextField copy instead (https://stackoverflow.com/a/43163892).
    if (NO && [view isKindOfClass:NSTextField.class]) {
        _originalTextField = (NSTextField*)view;
        if (!_mimicTextField) {
            // Two solutions for doing a copy
            // #1 an exact copy of NSButtonTextField (less prone to errors)
            NSKeyedArchiver *coder = [[NSKeyedArchiver alloc] initRequiringSecureCoding:NO];
            [view encodeWithCoder:coder];
            NSKeyedUnarchiver *decoder = [[NSKeyedUnarchiver alloc] initForReadingFromData:coder.encodedData error:nil];
            decoder.requiresSecureCoding = NO;
            _mimicTextField = [[view.class alloc] initWithCoder:decoder];

            // #2 a manual NSTextField copy (if previous solution stops working)
//            _titleTextField = [[NSTextField alloc] initWithFrame:view.frame];
//            _titleTextField.backgroundColor = [(NSTextField*)view backgroundColor];
//            _titleTextField.bezeled = [(NSTextField*)view isBezeled];
//            _titleTextField.drawsBackground = [(NSTextField*)view drawsBackground];
//            _titleTextField.editable = [(NSTextField*)view isEditable];
//            _titleTextField.lineBreakMode = [(NSTextField*)view lineBreakMode];
//            _titleTextField.attributedStringValue = [(NSTextField*)view attributedStringValue];
        }
        _mimicTextField.frame = _originalTextField.frame;
        [super addSubview:_mimicTextField];
    } else {
        [super addSubview:view];
    }
}

- (void)setFrame:(NSRect)frame
{
    if (frame.size.width > self.superview.bounds.size.width / 2) {
        // We cap to the intrinsicContentSize
//        frame.size.width = _mimicTextField.intrinsicContentSize.width;
    }
    if (frame.size.width < 20) {
        // Prevent buttons from disappearing
        frame.size.width = 20;
    }
    if (self.previousButton) {
        // Prevents the StackView superposing the buttons
        frame.origin.x = self.previousButton.frame.origin.x + self.previousButton.frame.size.width + 1;
    }
    [super setFrame:frame];
//    if (_originalTextField.superview) {
//        // native behavior
//        _mimicTextField.frame = _originalTextField.frame;
//    } else {
//        // fallback behavior...
//        _mimicTextField.frame.size = _mimicTextField.intrinsicContentSize;
//    }
}

- (void)willRemoveSubview:(NSView *)subview
{
    [super willRemoveSubview:subview];
    if (subview == _originalTextField) {
    }
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
