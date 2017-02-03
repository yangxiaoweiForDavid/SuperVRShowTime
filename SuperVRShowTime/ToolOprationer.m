//
//  ToolOprationer.m
//  XSpace
//
//  Created by XiaoweiYang on 15/7/26.
//  Copyright (c) 2015年 XiaoweiYang. All rights reserved.
//

#import "ToolOprationer.h"
#import "AppDelegate.h"
#import "Config.h"
#import "RDVTabBarItem.h"

#import "UtoVRController.h"

#include <sys/types.h>
#include <sys/sysctl.h>


@interface ToolOprationer ()<UIAlertViewDelegate,RDVTabBarControllerDelegate>
{
    UtoVRController *showContor;
}
@end

@implementation ToolOprationer

@synthesize naviBarWitd;


+ (ToolOprationer *)sharedInstance {
    static ToolOprationer *oprationer = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        oprationer = [[ToolOprationer alloc] init];
        oprationer.naviBarWitd = 0;
    });
    return oprationer;
}

-(void)config{
//    [self doSetNavigationBar];
    
//    NSString *videoPath = [SuperVR_TmpPath stringByAppendingPathComponent:LocalTmpVideoFileName];
//    [FileManagerUtils deleteFolderAndSubFile:videoPath];
    showContor = nil;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(releaseVRSourceNotifactionFuntion) name:ReleaseVRSourceNotifaction object:nil];
}

-(RDVTabBarController *)rdvTabBarController{
    if (!_rdvTabBarController) {
        _rdvTabBarController = [[RDVTabBarController alloc]init];
        _rdvTabBarController.delegate = self;
        [_rdvTabBarController setViewControllers:@[self.recommendNavi, self.categroyNavi, self.localNavi, self.personNavi]];
        NSArray *tabBarItemImages = @[@"tab_recommend", @"tab_categroy", @"tab_local", @"tab_person"];
        NSArray *tabBarNames = @[@"推荐", @"分类", @"播本地", @"个人"];
        NSUInteger index = 0;
        for (RDVTabBarItem *item in [[_rdvTabBarController tabBar] items]) {
            item.title = tabBarNames[index];
            UIImage *selectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_sel",tabBarItemImages[index]]];
            UIImage *unselectedimage = [UIImage imageNamed:tabBarItemImages[index]];
            [item setFinishedSelectedImage:selectedimage withFinishedUnselectedImage:unselectedimage];
            
            NSDictionary *unselectedTitleAttributes = nil;
            NSDictionary *selectedTitleAttributes = nil;
            unselectedTitleAttributes = @{NSFontAttributeName: [UIFont systemFontOfSize:10],NSForegroundColorAttributeName: [UIColor colorWithRed:0.525 green:0.510 blue:0.490 alpha:1.000]};
            selectedTitleAttributes = @{NSFontAttributeName: [UIFont systemFontOfSize:10],
                                        NSForegroundColorAttributeName: [UIColor colorWithRed:0.969 green:0.314 blue:0.380 alpha:1.000]};
            
            item.unselectedTitleAttributes = unselectedTitleAttributes;
            item.selectedTitleAttributes = selectedTitleAttributes;
            item.titlePositionAdjustment = UIOffsetMake(0, 2);
            
            index++;
        }
    }
    return _rdvTabBarController;
}

-(UINavigationController *)recommendNavi{
    if (!_recommendNavi) {
        _recommendNavi = [[UINavigationController alloc] initWithRootViewController:self.recommendController];
    }
    return _recommendNavi;
}

-(RecommendViewController *)recommendController{
    if (!_recommendController) {
        _recommendController = [[RecommendViewController alloc] initWithNibName:@"RecommendViewController" bundle:nil];
    }
    return _recommendController;
}

-(UINavigationController *)categroyNavi{
    if (!_categroyNavi) {
        _categroyNavi = [[UINavigationController alloc] initWithRootViewController:self.categroyController];
    }
    return _categroyNavi;
}

-(CategroyViewController *)categroyController{
    if (!_categroyController) {
        _categroyController = [[CategroyViewController alloc] initWithNibName:@"CategroyViewController" bundle:nil];
    }
    return _categroyController;
}

-(UINavigationController *)localNavi{
    if (!_localNavi) {
        _localNavi = [[UINavigationController alloc] initWithRootViewController:self.localController];
    }
    return _localNavi;
}

-(LocalViewController *)localController{
    if (!_localController) {
        _localController = [[LocalViewController alloc] initWithNibName:@"LocalViewController" bundle:nil];
    }
    return _localController;
}

-(UINavigationController *)personNavi{
    if (!_personNavi) {
        _personNavi = [[UINavigationController alloc] initWithRootViewController:self.personController];
    }
    return _personNavi;
}

-(PersonViewController *)personController{
    if (!_personController) {
        _personController = [[PersonViewController alloc] initWithNibName:@"PersonViewController" bundle:nil];
    }
    return _personController;
}

- (void)enterMainView{
    [[AppDelegate getMainAppDelegate].window setRootViewController:self.rdvTabBarController];
    [[AppDelegate getMainAppDelegate].window makeKeyAndVisible];
}


#pragma mark -
#pragma mark - RDVTabBarControllerDelegate

- (BOOL)tabBarController:(RDVTabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    return YES;
}

- (void)tabBarController:(RDVTabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
}

#pragma mark -
#pragma mark navigation bar

- (void)customizeNaviHeadInterface {
    
    UINavigationBar *navigationBarAppearance = [UINavigationBar appearance];
    
    UIImage *backgroundImage = [UIImage imageNamed:@"navigationbar"];
    NSDictionary *textAttributes =  @{
                                        NSFontAttributeName : [UIFont boldSystemFontOfSize:18],
                                        NSForegroundColorAttributeName : [UIColor blackColor],
                                      };
    
    [navigationBarAppearance setBackgroundImage:backgroundImage forBarMetrics:UIBarMetricsDefault];
    [navigationBarAppearance setTitleTextAttributes:textAttributes];
}

-(void)setNaviGationItem:(UIViewController *)_controller isLeft:(BOOL)_isLeft button:(UIButton *)_button
{
    [_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_button setTitleColor:[UIColor colorWithRed:117.0/255 green:175.0/255 blue:229.0/255 alpha:1] forState:UIControlStateHighlighted];
    if (_isLeft == YES)
    {
        [_button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    }
    else
    {
        [_button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    }
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:_button];
    UIBarButtonItem *flexible = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    if (self.naviBarWitd != 0)
    {
        flexible.width = self.naviBarWitd;
        self.naviBarWitd = 0;
    }
    else
    {
        flexible.width = -8.f;
    }
    
    if (_isLeft == YES)
    {
        _controller.navigationItem.leftBarButtonItems = @[flexible,barButton];
    }
    else
    {
        _controller.navigationItem.rightBarButtonItems = @[flexible,barButton];
    }
}

-(void)setNaviGationItemZeroFrame:(UIViewController *)_controller isLeft:(BOOL)_isLeft{
    UIButton *naiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    naiBtn.frame = CGRectZero;
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:naiBtn];
    UIBarButtonItem *flexible = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    if (DEVICE_IS_IPHONE6_PLUS) {
        flexible.width = -26;
    }else{
        flexible.width = -22;
    }
    if (_isLeft) {
        _controller.navigationItem.leftBarButtonItems = @[flexible,barButton];
    }else{
        _controller.navigationItem.rightBarButtonItems = @[flexible,barButton];
    }
}

-(void)setNaviGationTittle:(UIViewController *)_controller with:(float)_with high:(float)_high tittle:(NSString *)str
{
    _controller.edgesForExtendedLayout = UIRectEdgeNone;
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _with, _high)];
    title.text = str;
    title.textAlignment = NSTextAlignmentCenter;
    title.backgroundColor = [UIColor clearColor];
    title.textColor = [UIColor whiteColor];
    title.font = [UIFont fontWithName:@"HelveticaNeue" size:20];
    _controller.navigationItem.titleView = title;
}


-(UIView *)tipShowView{
    if (!_tipShowView) {
        _tipShowView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Device_Width, Device_Hight)];
        _tipShowView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
        [_tipShowView addSubview:self.tipLbl];
        self.tipLbl.frame = CGRectMake(0, 0, _tipShowView.frame.size.width-20, 50);
        self.tipLbl.center = _tipShowView.center;
        self.tipIndictorView.center = _tipShowView.center;
        [_tipShowView addSubview:self.tipIndictorView];
    }
    return _tipShowView;
}

-(UILabel *)tipLbl{
    if (!_tipLbl) {
        _tipLbl = [[UILabel alloc] init];
        _tipLbl.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        _tipLbl.textColor = [UIColor whiteColor];
        _tipLbl.font = [UIFont systemFontOfSize:15];
        _tipLbl.textAlignment = NSTextAlignmentCenter;
        _tipLbl.lineBreakMode = NSLineBreakByTruncatingMiddle;
        _tipLbl.numberOfLines = 0;
    }
    return _tipLbl;
}

-(UIActivityIndicatorView *)tipIndictorView{
    if (!_tipIndictorView) {
        _tipIndictorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    }
    return _tipIndictorView;
}

- (void)showTip:(NSString*)tipStr;
{
    [self showTip2:tipStr timeConut:2];
}

- (void)showTip2:(NSString*)tipStr timeConut:(float)second
{
    [self.tipShowView removeFromSuperview];
    [self.tipIndictorView setHidden:YES];
    [self.tipIndictorView stopAnimating];
    [self.tipLbl setHidden:NO];
    self.tipLbl.text = tipStr;
    [[AppDelegate getMainAppDelegate].window addSubview:self.tipShowView];
    
    if (second > 0) {
        [NSTimer scheduledTimerWithTimeInterval:second target:self selector:@selector(hideRefreshIndactor) userInfo:nil repeats:NO];
    }
}

-(void)showRefreshIndactor;
{
    [self.tipShowView removeFromSuperview];
    [self.tipLbl setHidden:YES];
    [self.tipIndictorView setHidden:NO];
    [self.tipIndictorView startAnimating];
    [[AppDelegate getMainAppDelegate].window addSubview:self.tipShowView];
}

-(void)hideRefreshIndactor
{
    [self.tipIndictorView stopAnimating];
    [self.tipShowView removeFromSuperview];
}



-(NSString *)getAppUuid
{
    CFUUIDRef theUUID = CFUUIDCreate(NULL);
    CFStringRef string = CFUUIDCreateString(NULL, theUUID);
    
    return (__bridge NSString *)string;
}


//转码中文
- (NSString*)UTF8_To_GB2312:(NSString*)utf8string{
    NSString *tempStr1 = [utf8string stringByReplacingOccurrencesOfString:@"\\u"withString:@"\\U"];
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\""withString:@"\\\""];
    NSString *tempStr3 = [[@"\""stringByAppendingString:tempStr2]stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString* returnStr = [NSPropertyListSerialization propertyListWithData:tempData options:NSPropertyListImmutable format:NULL error:NULL];
    
    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n"withString:@"\n"];
}

- (NSString *)encodeToPercentEscapeString: (NSString *) input
{
    NSString *outputStr = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)input,
                                                              NULL,
                                                              (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                              kCFStringEncodingUTF8));
    return outputStr;
}

- (NSString *)decodeFromPercentEscapeString: (NSString *) input
{
    NSMutableString *outputStr = [NSMutableString stringWithString:input];
    [outputStr replaceOccurrencesOfString:@"+"
                               withString:@" "
                                  options:NSLiteralSearch
                                    range:NSMakeRange(0, [outputStr length])];
    
    return [outputStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}



-(void)doSetNavigationBar
{
    UIColor *a = [UIColor colorWithRed:39.0/255 green:63.0/255 blue:94.0/255 alpha:1];
    UIImage *image1 = [self m_imageWithColor:a size:CGSizeMake(Device_Width, 64)];
    [[UINavigationBar appearance] setBackgroundImage:image1 forBarMetrics:UIBarMetricsDefault];
    
    
    UIColor *color = [UIColor whiteColor];
    [[UINavigationBar appearance] setTitleTextAttributes: @{
                                                            NSForegroundColorAttributeName: color,
                                                            NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue" size:17]
                                                            }];
    
    UIColor *color2 = [UIColor colorWithRed:152.0/255 green:152.0/255 blue:152.0/255 alpha:1];
    [[UINavigationBar appearance] setTintColor:color2];
    NSDictionary *attributes_nor = [NSDictionary dictionaryWithObjectsAndKeys:
                                    color2, NSForegroundColorAttributeName,
                                    [UIFont fontWithName:@"HelveticaNeue-Light" size:17], NSFontAttributeName ,nil];
    [[UIBarButtonItem appearance] setTitleTextAttributes: attributes_nor forState: UIControlStateNormal];
    
    UIColor *titleHighlightedColor = color2;
    NSDictionary *attributes_dis = [NSDictionary dictionaryWithObjectsAndKeys:
                                    titleHighlightedColor, NSForegroundColorAttributeName,
                                    [UIFont fontWithName:@"HelveticaNeue-Light" size:17], NSFontAttributeName,nil];
    [[UIBarButtonItem appearance] setTitleTextAttributes: attributes_dis forState: UIControlStateHighlighted];
}

-(UIImage*)m_imageWithColor:(UIColor *)color size:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, CGRectMake(0, 0, size.width, size.height));
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (UIImage *)m_imageWithView:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

- (UIImage *)m_imageWithView2:(UIView *)view fram:(CGRect)m_fram
{
    UIGraphicsBeginImageContext(view.bounds.size);
    UIRectClip(view.frame);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    CGImageRef sourceImageRef = [theImage CGImage];
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, m_fram);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    CGImageRelease(newImageRef);
    return newImage;
}


- (NSString*)platform{
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString* platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    free(machine);
    return platform;
}

-(NSString *)getDeviceModel{
    NSString *platform = [self platform];
    if ([platform isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([platform isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([platform isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([platform isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,2"])    return @"Verizon iPhone 4";
    
    if ([platform isEqualToString:@"iPhone4,1"])    return @"iPhone 4s";
    if ([platform isEqualToString:@"iPhone5,1"])    return @"iPhone 5 A1428";
    if ([platform isEqualToString:@"iPhone5,2"])    return @"iPhone 5 A1429";
    if ([platform isEqualToString:@"iPhone5,3"])    return @"iPhone 5c A1532";
    if ([platform isEqualToString:@"iPhone5,4"])    return @"iPhone 5c A1526";
    if ([platform isEqualToString:@"iPhone6,1"])    return @"iPhone 5s A1533";
    if ([platform isEqualToString:@"iPhone6,2"])    return @"iPhone 5s A1528";
    
    if ([platform isEqualToString:@"iPhone7,1"])    return @"iPhone 6Plus";
    if ([platform isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([platform isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([platform isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    
    if ([platform isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([platform isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([platform isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([platform isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([platform isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([platform isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([platform isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
    if ([platform isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([platform isEqualToString:@"i386"])         return @"Simulator";
    return platform;
}


-(void)showVRviewToWindow:(NSArray *)pathArray type:(UVPlayerItemType)type{
    if (showContor) {
        return;
    }
    NSMutableArray *items = [NSMutableArray array];
    for (NSString *path in pathArray) {
        UVPlayerItem *item = [[UVPlayerItem alloc] initWithPath:path type:type];
        [items addObject:item];
    }
    showContor = nil;
    showContor = [[UtoVRController alloc] init];   
    [showContor initWithDataShow:items];
}

-(void)releaseVRSourceNotifactionFuntion{
    showContor = nil;
}

-(UITableViewCell*)getTableViewCellForTableview:(UITableView *)tableView className:(NSString *)className nibName:(NSString *)nibName identifier:(NSString*)identifier{
    Class someClass = NSClassFromString(className);
    id dataCell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (dataCell == nil){
        NSArray* nibs = [[NSBundle mainBundle] loadNibNamed:nibName owner:self options:nil];
        for (id oneObject in nibs){
            if ([oneObject isKindOfClass:[someClass class]]){
                dataCell = oneObject;
            }
        }
    }
    return dataCell;
}

- (float)m_getWidt_str:(NSString *)str m_font:(UIFont *)font higt:(float)higt
{
    if (!str || [str isKindOfClass:[NSNull class]]) {
        str = @"";
    }
    CGSize size;
    NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil];
    size=[str boundingRectWithSize:CGSizeMake(MAXFLOAT, higt) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:dic context:nil].size;
    return size.width+1;
}

- (float)m_getHigh_str:(NSString *)str m_font:(UIFont *)font widt:(float)widt
{
    if (!str || [str isKindOfClass:[NSNull class]]) {
        str = @"";
    }
    CGSize size;
    NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil];
    size=[str boundingRectWithSize:CGSizeMake(widt, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:dic context:nil].size;
    return size.height+1;
}


@end

