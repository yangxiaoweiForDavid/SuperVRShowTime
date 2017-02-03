//
//  WrongMsgViewController.h
//  ksudi
//
//  Created by MacroHong on 15/5/26.
//  Copyright (c) 2015年 com.oeffect. All rights reserved.
//

#import <UIKit/UIKit.h>



//网络错误
#define NetError      @"-1001"



@interface WrongMsgViewController : UIViewController<UIAlertViewDelegate>

+(void)showCodeMsg:(NSString *)codeStr;
+(void)showMsg:(NSString *)Str;

@end
