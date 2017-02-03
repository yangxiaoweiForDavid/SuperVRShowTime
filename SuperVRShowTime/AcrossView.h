//
//  AcrossView.h
//  SuperVRShowTime
//
//  Created by yangxiaowei on 16/9/5.
//  Copyright © 2016年 XiaoweiYang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DoAcrossViewDelegate <NSObject>
@required
-(void)doCliecAcrossBtn_tag:(int)tag;
@end

@interface AcrossView : UIView

-(void)reflashData:(NSArray *)dataArray delegate:(id<DoAcrossViewDelegate>)delegate;

@end


@interface AcrossView2 : UIView

-(void)reflashData:(NSArray *)dataArray delegate:(id<DoAcrossViewDelegate>)delegate;

@end
