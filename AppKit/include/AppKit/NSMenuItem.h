/* Copyright (c) 2006-2007 Christopher J. W. Lloyd

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
the Software, and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE. */

#import <AppKit/NSCell.h>
#import <AppKit/NSUserInterfaceValidation.h>
#import <Foundation/NSObject.h>
#import <AppKit/NSUserInterfaceItemIdentification.h>

@class NSMenu, NSImage, NSAttributedString;

@interface NSMenuItem : NSObject <NSCopying, NSValidatedUserInterfaceItem, NSUserInterfaceItemIdentification> {
    NSMenu *_menu;
    NSString *_title;
    NSAttributedString *_atitle;
    id _target;
    SEL _action;
    NSString *_keyEquivalent;
    unsigned _keyEquivalentModifierMask;
    NSString *_mnemonic;
    unsigned _mnemonicLocation;
    NSMenu *_submenu;
    NSInteger _tag;
    NSInteger _indentationLevel;
    BOOL _enabled;
    BOOL _hidden;
    NSControlStateValue _state;
    id _representedObject;
    NSImage *_image;
    NSImage *_onStateImage;
    NSImage *_offStateImage;
    NSImage *_mixedStateImage;
    BOOL _alternate;
    BOOL _allowsKeyEquivalentWhenHidden;
    NSUserInterfaceItemIdentifier _identifier;
}

@property(getter=isAlternate) BOOL alternate;
@property BOOL allowsKeyEquivalentWhenHidden;

+ (NSMenuItem *) separatorItem;

- (instancetype) initWithTitle: (NSString *) title
                        action: (SEL) action
                 keyEquivalent: (NSString *) keyEquivalent;

- (NSMenu *) menu;
- (NSString *) title;
- (NSAttributedString *) attributedTitle;
- (NSString *) mnemonic;
- (unsigned) mnemonicLocation;
- (id) target;
- (SEL) action;
- (NSInteger) indentationLevel;
- (NSInteger) tag;
- (NSControlStateValue) state;
- (NSString *) keyEquivalent;
- (unsigned) keyEquivalentModifierMask;
- (NSImage *) image;
- (NSImage *) onStateImage;
- (NSImage *) offStateImage;
- (NSImage *) mixedStateImage;

- representedObject;

- (BOOL) hasSubmenu;
- (NSMenu *) submenu;

- (BOOL) isSeparatorItem;
- (BOOL) isEnabled;
- (BOOL) isHidden;

- (void) setTitle: (NSString *) title;
- (void) setAttributedTitle: (NSAttributedString *) title;
- (void) setTitleWithMnemonic: (NSString *) mnemonic;
- (void) setMnemonicLocation: (unsigned) location;
- (void) setTarget: target;
- (void) setAction: (SEL) action;
- (void) setIndentationLevel: (NSInteger) indentationLevel;
- (void) setTag: (NSInteger) tag;
- (void) setState: (NSControlStateValue) state;
- (void) setKeyEquivalent: (NSString *) keyEquivalent;
- (void) setKeyEquivalentModifierMask: (unsigned) mask;
- (void) setImage: (NSImage *) image;
- (void) setOnStateImage: (NSImage *) image;
- (void) setOffStateImage: (NSImage *) image;
- (void) setMixedStateImage: (NSImage *) image;
- (void) setRepresentedObject: object;
- (void) setSubmenu: (NSMenu *) submenu;
- (void) setEnabled: (BOOL) flag;
- (void) setHidden: (BOOL) flag;

- (NSString *) _keyEquivalentDescription;

@end
