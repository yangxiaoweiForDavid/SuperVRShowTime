//
//  ToolOprationer.h
//  XSpace
//
//  Created by XiaoweiYang on 15/7/26.
//  Copyright (c) 2015年 XiaoweiYang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "RDVTabBarController.h"
#import "CategroyViewController.h"
#import "RecommendViewController.h"
#import "PersonViewController.h"
#import "LocalViewController.h"

#import <UtoVRPlayer/UtoVRPlayer.h>


@interface ToolOprationer : NSObject
{
    
}

@property (nonatomic, strong)  UIView *tipShowView;
@property (nonatomic, strong)  UILabel *tipLbl;
@property (strong, nonatomic)  UIActivityIndicatorView *tipIndictorView;
@property (nonatomic, assign)  float naviBarWitd;
@property (nonatomic, strong)  RDVTabBarController *rdvTabBarController;
@property (nonatomic, strong)  UINavigationController *recommendNavi;
@property (nonatomic, strong)  RecommendViewController *recommendController;
@property (nonatomic, strong)  UINavigationController *categroyNavi;
@property (nonatomic, strong)  CategroyViewController *categroyController;
@property (nonatomic, strong)  UINavigationController *localNavi;
@property (nonatomic, strong)  LocalViewController *localController;
@property (nonatomic, strong)  UINavigationController *personNavi;
@property (nonatomic, strong)  PersonViewController *personController;


+ (ToolOprationer *)sharedInstance;

-(void)customizeNaviHeadInterface;
-(void)setNaviGationItem:(UIViewController *)_controller isLeft:(BOOL)_isLeft button:(UIButton *)_button;
-(void)setNaviGationItemZeroFrame:(UIViewController *)_controller isLeft:(BOOL)_isLeft;
-(void)setNaviGationTittle:(UIViewController *)_controller with:(float)_with high:(float)_high tittle:(NSString *)str;

-(void)showTip:(NSString*)tipStr;
-(void)showTip2:(NSString*)tipStr timeConut:(float)second;
-(void)showRefreshIndactor;
-(void)hideRefreshIndactor;

-(NSString *)getAppUuid;
-(NSString *)UTF8_To_GB2312:(NSString*)utf8string;
-(NSString *)encodeToPercentEscapeString: (NSString *) input;
-(NSString *)decodeFromPercentEscapeString: (NSString *) input;
-(NSString *)getDeviceModel;

-(void)config;
-(void)enterMainView;
-(void)doSetNavigationBar;
-(UIImage *)m_imageWithColor:(UIColor *)color size:(CGSize)size;
-(UIImage *)m_imageWithView:(UIView *)view;
-(UIImage *)m_imageWithView2:(UIView *)view fram:(CGRect)m_fram;

-(void)showVRviewToWindow:(NSArray *)pathArray type:(UVPlayerItemType)type;
-(UITableViewCell*)getTableViewCellForTableview:(UITableView *)tableView className:(NSString *)className nibName:(NSString *)nibName identifier:(NSString*)identifier;

-(float)m_getWidt_str:(NSString *)str m_font:(UIFont *)font higt:(float)higt;
-(float)m_getHigh_str:(NSString *)str m_font:(UIFont *)font widt:(float)widt;

@end


