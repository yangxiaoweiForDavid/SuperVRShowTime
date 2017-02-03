//
//  SGFocusImageFrame.m
//  ScrollViewLoop
//
//  Created by Vincent Tang on 13-7-18.
//  Copyright (c) 2013年 Vincent Tang. All rights reserved.
//

#import "SGFocusImageFrame.h"
#import "SGFocusImageItem.h"
#import <objc/runtime.h>
#import "UIImageView+WebCache.h"


@interface SGFocusImageFrame () {
}
@end


@implementation SGFocusImageFrame
@synthesize delegate = _delegate;


- (id)initWithFrame:(CGRect)frame delegate:(id<SGFocusImageFrameDelegate>)delegate  switchTime:(float)time focusImageItems:(SGFocusImageItem *)firstItem, ...
{
    self = [super initWithFrame:frame];
    if (self) {
        NSMutableArray *imageItems = [NSMutableArray array];
        SGFocusImageItem *eachItem;
        va_list argumentList;
        if (firstItem)
        {
            [imageItems addObject: firstItem];
            va_start(argumentList, firstItem);
            while((eachItem = va_arg(argumentList, SGFocusImageItem *)))
            {
                [imageItems addObject: eachItem];
            }
            va_end(argumentList);
        }
        objc_setAssociatedObject(self, (__bridge const void *)SG_FOCUS_ITEM_ASS_KEY, imageItems, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
        [self setupViews];
        [self setDelegate:delegate];
        
        SWITCH_FOCUS_PICTURE_INTERVAL = time;
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame delegate:(id<SGFocusImageFrameDelegate>)delegate switchTime:(float)time imageItems:(NSArray *)items isAuto:(BOOL)isAuto
{
    self = [super initWithFrame:frame];
    if (self)
    {
        NSMutableArray *imageItems = [NSMutableArray arrayWithArray:items];
        objc_setAssociatedObject(self, (__bridge const void *)SG_FOCUS_ITEM_ASS_KEY, imageItems, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
        [self setupViews];
        [self setDelegate:delegate];
        
        isAutoPlay = isAuto;
        SWITCH_FOCUS_PICTURE_INTERVAL = time;
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame delegate:(id<SGFocusImageFrameDelegate>)delegate switchTime:(float)time imageItems:(NSArray *)items
{
    return [self initWithFrame:frame delegate:delegate switchTime:time imageItems:items isAuto:YES];
}


- (void)initData_delegate:(id<SGFocusImageFrameDelegate>)delegate placeHolderImage:(UIImage *)placeHolderImage{
    [self setDelegate:delegate];
    self.placeHolderImage = placeHolderImage;
    [self setupViews];
}

- (void)dealloc
{
    objc_setAssociatedObject(self, (__bridge const void *)SG_FOCUS_ITEM_ASS_KEY, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    _scrollView.delegate = nil;
}

- (void)setHiddenPageControl:(BOOL)hiddenPageControl
{
    _hiddenPageControl = hiddenPageControl;
    _pageControl.hidden = _hiddenPageControl;
}

#pragma mark - private methods
- (void)setupViews
{
    _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    _scrollView.scrollsToTop = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    UITapGestureRecognizer *tapGestureRecognize = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestureRecognizer:)];
    tapGestureRecognize.delegate = self;
    tapGestureRecognize.numberOfTapsRequired = 1;
    [_scrollView addGestureRecognizer:tapGestureRecognize];

    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(10, self.frame.size.height -20, DEVICE_SCREEN_WIDTH-20, 10)];
    _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    _pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    _pageControl.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    _pageControl.userInteractionEnabled = NO;
    _pageControl.hidden = _hiddenPageControl;
    [self addSubview:_scrollView];
    [self addSubview:_pageControl];
    
    NSArray *imageItems = objc_getAssociatedObject(self, (__bridge const void *)SG_FOCUS_ITEM_ASS_KEY);
    [self addImageViews:imageItems];
}

#pragma mark 添加视图
-(void)addImageViews:(NSArray *)aImageItems{
    _scrollView.frame = self.bounds;
    for (UIView *lView in _scrollView.subviews) {
        [lView removeFromSuperview];
    }
    float space = 0;
    for (int i = 0; i < aImageItems.count; i++) {
        SGFocusImageItem *item = [aImageItems objectAtIndex:i];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * self.frame.size.width+space, space, self.frame.size.width-space*2, self.frame.size.height-2*space)];
        imageView.backgroundColor = [UIColor clearColor];

        if (item.imageUrl && ![item.imageUrl isEqualToString:@""]) {
            [imageView sd_setImageWithURL:[NSURL URLWithString:item.imageUrl] placeholderImage:_placeHolderImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            }];
        }else{
            [imageView setImage:[UIImage imageNamed:item.imageLocalName]];
        }
        
        imageView.contentMode = UIViewContentModeScaleToFill;
        imageView.clipsToBounds = YES;
        [_scrollView addSubview:imageView];
    }
    _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width * aImageItems.count, _scrollView.frame.size.height);
    if ([aImageItems count]>1){
        [_scrollView setContentOffset:CGPointMake(DEVICE_SCREEN_WIDTH, 0) animated:NO] ;
        if (isAutoPlay){
            [self performSelector:@selector(switchFocusImageItems) withObject:nil afterDelay:SWITCH_FOCUS_PICTURE_INTERVAL];
        }
    }
    _pageControl.numberOfPages = aImageItems.count>1?aImageItems.count -2:aImageItems.count;
    _pageControl.currentPage = 0;
}

#pragma mark 改变添加视图内容
- (void)switchFocusImageItems{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(switchFocusImageItems) object:nil];
    CGFloat targetX = _scrollView.contentOffset.x + _scrollView.frame.size.width;
    NSArray *imageItems = objc_getAssociatedObject(self, (__bridge const void *)SG_FOCUS_ITEM_ASS_KEY);
    targetX = (int)(targetX/DEVICE_SCREEN_WIDTH) * DEVICE_SCREEN_WIDTH;
    [self moveToTargetPosition:targetX];
    if ([imageItems count]>1 && isAutoPlay){
        [self performSelector:@selector(switchFocusImageItems) withObject:nil afterDelay:SWITCH_FOCUS_PICTURE_INTERVAL];
    }
}

- (void)moveToTargetPosition:(CGFloat)targetX{
    BOOL animated = YES;
    [_scrollView setContentOffset:CGPointMake(targetX, 0) animated:animated];
}

-(void)changeImageViewsContent:(NSArray *)aArray{
    NSMutableArray *tempArray = [NSMutableArray arrayWithArray:aArray];
    NSUInteger length = tempArray.count;
    NSMutableArray *itemArray = [NSMutableArray arrayWithCapacity:length+2];
    if (length > 1){
        NSDictionary *dict = tempArray[length - 1];
        SGFocusImageItem *item = [[SGFocusImageItem alloc] initWithDict:dict tag:-1];
        [itemArray addObject:item];
    }
    for (int i = 0; i < length; i++){
        NSDictionary *dict = tempArray[i];
        SGFocusImageItem *item = [[SGFocusImageItem alloc] initWithDict:dict tag:i];
        [itemArray addObject:item];
    }
    if (length >1){
        NSDictionary *dict = tempArray[0];
        SGFocusImageItem *item = [[SGFocusImageItem alloc] initWithDict:dict tag:length];
        [itemArray addObject:item];
    }
    
    objc_setAssociatedObject(self, (__bridge const void *)SG_FOCUS_ITEM_ASS_KEY, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, (__bridge const void *)SG_FOCUS_ITEM_ASS_KEY, itemArray, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self addImageViews:itemArray];
}

#pragma mark - singleTapGestureRecognizer
- (void)singleTapGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
{
    NSArray *imageItems = objc_getAssociatedObject(self, (__bridge const void *)SG_FOCUS_ITEM_ASS_KEY);
    int page = (int)(_scrollView.contentOffset.x / _scrollView.frame.size.width);
    if (page > -1 && page < imageItems.count) {
        SGFocusImageItem *item = [imageItems objectAtIndex:page];
        if ([self.delegate respondsToSelector:@selector(foucusImageFrame:didSelectItem:)]) {
            [self.delegate foucusImageFrame:self didSelectItem:item];
        }
    }
}


#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    float targetX = scrollView.contentOffset.x;
    NSArray *imageItems = objc_getAssociatedObject(self, (__bridge const void *)SG_FOCUS_ITEM_ASS_KEY);
    if ([imageItems count]>=3)
    {
        if (targetX >= DEVICE_SCREEN_WIDTH * ([imageItems count] -1)) {
            targetX = DEVICE_SCREEN_WIDTH;
            [_scrollView setContentOffset:CGPointMake(targetX, 0) animated:NO];
        }
        else if(targetX <= 0)
        {
            targetX = DEVICE_SCREEN_WIDTH *([imageItems count]-2);
            [_scrollView setContentOffset:CGPointMake(targetX, 0) animated:NO];
        }
    }
    NSInteger page = (_scrollView.contentOffset.x+DEVICE_SCREEN_WIDTH/2.0) / DEVICE_SCREEN_WIDTH;
    if ([imageItems count] > 1)
    {
        page --;
        if (page >= _pageControl.numberOfPages)
        {
            page = 0;
        }else if(page <0)
        {
            page = _pageControl.numberOfPages -1;
        }
    }
    if (page!= _pageControl.currentPage)
    {
        if ([self.delegate respondsToSelector:@selector(foucusImageFrame:currentItem:)])
        {
            [self.delegate foucusImageFrame:self currentItem:page];
        }
    }
    _pageControl.currentPage = page;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate)
    {
        CGFloat targetX = _scrollView.contentOffset.x + _scrollView.frame.size.width;
        targetX = (int)(targetX/DEVICE_SCREEN_WIDTH) * DEVICE_SCREEN_WIDTH;
        [self moveToTargetPosition:targetX];
    }
}

- (void)scrollToIndex:(NSInteger)aIndex
{
    NSArray *imageItems = objc_getAssociatedObject(self, (__bridge const void *)SG_FOCUS_ITEM_ASS_KEY);
    if ([imageItems count]>1)
    {
        if (aIndex >= ([imageItems count]-2))
        {
            aIndex = [imageItems count]-3;
        }
        [self moveToTargetPosition:DEVICE_SCREEN_WIDTH*(aIndex+1)];
    }
    else
    {
        [self moveToTargetPosition:0];
    }
    [self scrollViewDidScroll:_scrollView];
}

@end
