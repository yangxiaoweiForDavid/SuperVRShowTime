//
//  SGFocusImageFrame.h
//  ScrollViewLoop
//
//  Created by Vincent Tang on 13-7-18.
//  Copyright (c) 2013年 Vincent Tang. All rights reserved.
//

#import <UIKit/UIKit.h>


@class SGFocusImageItem;
@class SGFocusImageFrame;

#pragma mark - SGFocusImageFrameDelegate
@protocol SGFocusImageFrameDelegate <NSObject>
@optional
- (void)foucusImageFrame:(SGFocusImageFrame *)imageFrame didSelectItem:(SGFocusImageItem *)item;
- (void)foucusImageFrame:(SGFocusImageFrame *)imageFrame currentItem:(NSInteger)index;
@end


#define DEVICE_SCREEN_WIDTH                   [UIScreen mainScreen].bounds.size.width
static NSString *SG_FOCUS_ITEM_ASS_KEY        = @"yang_loopScrollview";
static CGFloat SWITCH_FOCUS_PICTURE_INTERVAL  = 5.0;
static BOOL isAutoPlay                        = YES;


@interface SGFocusImageFrame : UIView <UIGestureRecognizerDelegate, UIScrollViewDelegate>
{
    UIScrollView *_scrollView;
    UIPageControl *_pageControl;
}

- (void)initData_delegate:(id<SGFocusImageFrameDelegate>)delegate placeHolderImage:(UIImage *)placeHolderImage;
- (id)initWithFrame:(CGRect)frame delegate:(id<SGFocusImageFrameDelegate>)delegate switchTime:(float)time imageItems:(NSArray *)items isAuto:(BOOL)isAuto;
- (id)initWithFrame:(CGRect)frame delegate:(id<SGFocusImageFrameDelegate>)delegate switchTime:(float)time focusImageItems:(SGFocusImageItem *)items, ... NS_REQUIRES_NIL_TERMINATION;
- (id)initWithFrame:(CGRect)frame delegate:(id<SGFocusImageFrameDelegate>)delegate switchTime:(float)time imageItems:(NSArray *)items;

- (void)scrollToIndex:(NSInteger)aIndex;
-(void)changeImageViewsContent:(NSArray *)aArray;
- (void)setupViews;

@property (nonatomic, assign) BOOL hiddenPageControl;
@property (nonatomic, weak) id<SGFocusImageFrameDelegate> delegate;
@property (nonatomic, strong) UIImage *placeHolderImage;

@end
