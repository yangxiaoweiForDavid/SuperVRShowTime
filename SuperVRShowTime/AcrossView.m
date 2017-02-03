//
//  AcrossView.m
//  SuperVRShowTime
//
//  Created by yangxiaowei on 16/9/5.
//  Copyright © 2016年 XiaoweiYang. All rights reserved.
//

#import "AcrossView.h"
#import "CommonClass.h"

@interface AcrossView()

@property(nonatomic,strong)id<DoAcrossViewDelegate> clickDelegate;
@property(nonatomic,strong)UIScrollView *contentScroller;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,assign)float topSpace;
@property(nonatomic,assign)float midSpace;
@property(nonatomic,assign)float bottomSpace;
@property(nonatomic,assign)float leftSpace;
@property(nonatomic,assign)float iconHigh;
@property(nonatomic,assign)float tittleHigh;

@end


@implementation AcrossView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self =[super initWithFrame:frame]) {
        _topSpace = 15;
        _midSpace = 5;
        _bottomSpace = 15;
//        _leftSpace = 10;
        _iconHigh = 48;
        _tittleHigh = 12;
        _dataArray = [[NSMutableArray alloc] init];
        _contentScroller = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, Device_Width, _topSpace+_iconHigh+_midSpace+_tittleHigh+_bottomSpace)];
        _contentScroller.backgroundColor = [UIColor whiteColor];
        [_contentScroller setShowsVerticalScrollIndicator:YES];
        [self addSubview:_contentScroller];
    }
    return self;
}

-(void)reflashData:(NSArray *)dataArray delegate:(id<DoAcrossViewDelegate>)delegate{
    
    NSInteger itemCount = dataArray.count;
    _leftSpace = (Device_Width - _iconHigh*itemCount)/(itemCount + 1);
    
    _clickDelegate = delegate;
    [_dataArray removeAllObjects];
    [_dataArray addObjectsFromArray:dataArray];
    for (UIView *v in _contentScroller.subviews) {
        [v removeFromSuperview];
    }
    float start_x = _leftSpace;
    for (int i=0; i<_dataArray.count; i++) {
        AcrossData *data = _dataArray[i];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:data.imageUrl] forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor clearColor];
        btn.frame = CGRectMake(start_x, _topSpace, _iconHigh, _iconHigh);
        btn.tag = i;
        [btn addTarget:self action:@selector(doClick:) forControlEvents:UIControlEventTouchUpInside];
        [_contentScroller addSubview:btn];
        
        UILabel *tittle = [[UILabel alloc] init];
        tittle.text = data.tittle;
        tittle.font = [UIFont systemFontOfSize:14];
        tittle.textColor = [UIColor blackColor];
        tittle.backgroundColor = [UIColor clearColor];
        tittle.textAlignment = NSTextAlignmentCenter;
        tittle.frame = CGRectMake(start_x-_leftSpace/2, _topSpace+_iconHigh+_midSpace, _leftSpace+_iconHigh, _tittleHigh);
        [_contentScroller addSubview:tittle];
        
        start_x += _iconHigh+_leftSpace;
    }
    [_contentScroller setContentSize:CGSizeMake(start_x, _contentScroller.frame.size.height)];
    if (start_x>Device_Width) {
        [_contentScroller setShowsHorizontalScrollIndicator:YES];
    }else{
        [_contentScroller setShowsHorizontalScrollIndicator:NO];
    }
}

-(void)doClick:(UIButton *)sender{
    if (_clickDelegate && [_clickDelegate respondsToSelector:@selector(doCliecAcrossBtn_tag:)]) {
        [_clickDelegate doCliecAcrossBtn_tag:(int)sender.tag];
    }
}


@end

