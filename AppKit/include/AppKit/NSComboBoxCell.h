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

#import <AppKit/NSTextFieldCell.h>

@class NSButtonCell;

@interface NSComboBoxCell : NSTextFieldCell <NSCoding> {
    id _dataSource;
    NSSize _intercellSpacing;
    CGFloat _itemHeight;
    NSInteger _numberOfVisibleItems;

    BOOL _usesDataSource;
    BOOL _hasVerticalScroller;
    BOOL _completes;
    BOOL _isButtonBordered;
    BOOL _buttonEnabled;
    BOOL _buttonPressed;

    NSMutableArray *_objectValues;
}

- dataSource;
- (BOOL) usesDataSource;
- (BOOL) isButtonBordered;
- (CGFloat) itemHeight;
- (BOOL) hasVerticalScroller;
- (NSSize) intercellSpacing;
- (BOOL) completes;
- (NSInteger) numberOfVisibleItems;

- (void) setDataSource: value;
- (void) setUsesDataSource: (BOOL) value;
- (void) setButtonBordered: (BOOL) value;
- (void) setItemHeight: (CGFloat) value;
- (void) setHasVerticalScroller: (BOOL) value;
- (void) setIntercellSpacing: (NSSize) value;
- (void) setCompletes: (BOOL) completes;
- (void) setNumberOfVisibleItems: (NSInteger) value;

- (NSInteger) numberOfItems;
- (NSArray *) objectValues;
- itemObjectValueAtIndex: (NSInteger) index;
- (NSInteger) indexOfItemWithObjectValue: object;
- (void) addItemWithObjectValue: object;
- (void) addItemsWithObjectValues: (NSArray *) objects;
- (void) removeAllItems;
- (void) removeItemAtIndex: (NSInteger) index;
- (void) removeItemWithObjectValue: value;
- (void) insertItemWithObjectValue: value atIndex: (NSInteger) index;

- (NSInteger) indexOfSelectedItem;
- objectValueOfSelectedItem;
- (void) selectItemAtIndex: (NSInteger) index;
- (void) selectItemWithObjectValue: value;
- (void) deselectItemAtIndex: (NSInteger) index;

- (void) scrollItemAtIndexToTop: (NSInteger) index;
- (void) scrollItemAtIndexToVisible: (NSInteger) index;

- (void) noteNumberOfItemsChanged;
- (void) reloadData;

- (NSString *) completedString: (NSString *) string;

@end

@protocol NSComboBoxCellDataSource <NSObject>
- (NSString *) comboBoxCell: (NSComboBoxCell *) cell
            completedString: (NSString *) string;
@end
