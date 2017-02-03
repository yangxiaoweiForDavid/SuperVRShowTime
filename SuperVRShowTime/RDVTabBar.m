// RDVTabBar.m
// RDVTabBarController
//
// Copyright (c) 2013 Robert Dimitrov
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "RDVTabBar.h"
#import "RDVTabBarItem.h"

@interface RDVTabBar () {
    
}

@property (nonatomic) CGFloat itemWidth;
@property (nonatomic) UIView *backgroundView;
@property (nonatomic) UIImageView *backgroundImageView;
@property (nonatomic) UIView *itemsView;

@end

@implementation RDVTabBar

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInitialization];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInitialization];
    }
    return self;
}

- (id)init {
    return [self initWithFrame:CGRectZero];
}

- (void)commonInitialization {
    
    _backgroundView = [[UIView alloc] init];
    _backgroundView.backgroundColor = [UIColor clearColor];
    [self addSubview:_backgroundView];
    
    self.itemsView = [[UIView alloc] init];
    self.itemsView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.itemsView];
    
    _backgroundImageView = [[UIImageView alloc] init];
    _backgroundImageView.image = [UIImage imageNamed:@"bottom_btn"];
    [self.itemsView addSubview:_backgroundImageView];
    
    [self setTranslucent:NO];
}


- (void)layoutSubviews {
    CGSize frameSize = self.frame.size;
    CGFloat minimumContentHeight = [self minimumContentHeight];
    
    [[self backgroundView] setFrame:CGRectMake(0, frameSize.height - minimumContentHeight,
                                            frameSize.width, frameSize.height)];
    
    [[self backgroundImageView] setFrame:CGRectMake(0, 0,
                                               frameSize.width, 48)];
    
    [[self itemsView] setFrame:CGRectMake(0, 0,
                                                    frameSize.width, frameSize.height)];
    
    
    //david
    float off_x = 0;//70
    
    [self setItemWidth:roundf((frameSize.width - off_x - [self contentEdgeInsets].left -
                               [self contentEdgeInsets].right) / [[self items] count])];
    NSInteger index = 0;

    // Layout items
    for (RDVTabBarItem *item in [self items]) {
        float offsetX = 0;
        if (index < 2) {
            offsetX = 0;
        } else {
            offsetX = off_x;
        }
        
        CGFloat itemHeight = [item itemHeight];
        
        if (!itemHeight) {
            itemHeight = frameSize.height;
        }
        
        
        [item setFrame:CGRectMake(offsetX + self.contentEdgeInsets.left + (index * self.itemWidth),
                                  0,
                                  self.itemWidth, 48)];
        [item setNeedsDisplay];
        
        index++;
    }
}

#pragma mark - Configuration

- (void)setItemWidth:(CGFloat)itemWidth {
    if (itemWidth > 0) {
        _itemWidth = itemWidth;
    }
}

- (void)setItems:(NSArray *)items {
    for (RDVTabBarItem *item in _items) {
        [item removeFromSuperview];
    }
    
    _items = [items copy];
    for (RDVTabBarItem *item in _items) {
        [item addTarget:self action:@selector(tabBarItemWasSelected:) forControlEvents:UIControlEventTouchDown];
        [self.itemsView addSubview:item];
    }
}

- (void)setHeight:(CGFloat)height {
    [self setFrame:CGRectMake(CGRectGetMinX(self.frame), CGRectGetMinY(self.frame),
                              CGRectGetWidth(self.frame), height)];
}

- (CGFloat)minimumContentHeight {
    CGFloat minimumTabBarContentHeight = CGRectGetHeight([self frame]);
    
    for (RDVTabBarItem *item in [self items]) {
        CGFloat itemHeight = [item itemHeight];
        if (itemHeight && (itemHeight < minimumTabBarContentHeight)) {
            minimumTabBarContentHeight = itemHeight;
        }
    }
    
    return minimumTabBarContentHeight;
}

#pragma mark - Item selection

- (void)tabBarItemWasSelected:(id)sender {
    if ([[self delegate] respondsToSelector:@selector(tabBar:shouldSelectItemAtIndex:)]) {
        NSInteger index = [self.items indexOfObject:sender];
        if (![[self delegate] tabBar:self shouldSelectItemAtIndex:index]) {
            return;
        }
    }
    
    [self setSelectedItem:sender];
    
    if ([[self delegate] respondsToSelector:@selector(tabBar:didSelectItemAtIndex:)]) {
        NSInteger index = [self.items indexOfObject:self.selectedItem];
        [[self delegate] tabBar:self didSelectItemAtIndex:index];
    }
}

- (void)setSelectedItem:(RDVTabBarItem *)selectedItem {
    if (selectedItem == _selectedItem) {
        return;
    }
    [_selectedItem setSelected:NO];
    
    _selectedItem = selectedItem;
    [_selectedItem setSelected:YES];
}

- (void)midBtnAction:(id)sender
{
    if ([[self delegate] respondsToSelector:@selector(tabBar:didSelectItemAtIndex:)]) {
        [[self delegate] tabBar:self didSelectMidBtn:sender];
    }
}

#pragma mark - Translucency

- (void)setTranslucent:(BOOL)translucent {
    _translucent = translucent;
}

@end
