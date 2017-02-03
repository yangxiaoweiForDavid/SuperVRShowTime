//
//  NSString+Categories.h
//  EkuKangDA
//
//  Created by answer-Huang on 3/28/14.
//  Copyright (c) 2014 eku. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Categories)

/**
 *  计算 MD5 值
 *
 *  @param input
 *
 *  @return
 */
- (NSString *)md5;

/**
 *  计算 sha-1
 *
 *  @return 计算后的结果
 */
- (NSString*)sha1;

/**
 *  检测字符串是否为空（nil或者空字符串）
 *
 *  @param trim 是否忽略前后空白字符
 *
 *  @return 是否为空
 */
+(BOOL)isEmpty:(NSString *)str trim:(BOOL)trim;

/**
 *  对 URL 进行编码
 *
 *  @return 编码后的 URL
 */
- (NSString *)urlEncode;

#pragma mark - 字符串校验处理
/**
 *  校验空字符串
 *
 *  @param string 需要校验的字符串
 *
 *  @return YES/NO
 */
+ (BOOL)checkStringEmpty:(NSString *)string;

/**
 *  校验手机号码是否合法
 *
 *  @param mobileNum 手机号码
 *
 *  @return YES/NO
 */
- (BOOL)isMobileNum;

/**
 *  校验电话号码是否合法
 *
 *  @param telPhoneNum 电话号码字符串
 *
 *  @return YES/NO
 */
- (BOOL)checkTelPhoneNum;

/**
 *  校验email地址是否合法
 *
 *  @param email email字符串
 *
 *  @return YES/NO
 */
- (BOOL)checkValidateEmail;

#pragma mark - JSON处理
/**
 *  序列化对象为json格式字符串
 *
 *  @param obj 将要序列化对象
 *
 *  @return json格式字符串
 */
+ (NSString *)SerializationObjToJson:(id)obj;

#pragma mark - 字符串宽高信息
/**
 *  计算字符串高度
 *
 *  @param text       要计算的字符串
 *  @param font       字体
 *  @param labelWidth 宽度
 *
 *  @return 内容高度
 */
- (CGFloat)getContentHeightWithFont:(UIFont *)font labelWidth:(CGFloat)labelWidth;

/**
 *  计算字符串的宽高
 *
 *  @param text       要计算的字符串
 *  @param font       字体
 *  @param labelWidth 宽度
 *
 *  @return 字符串宽高
 */
- (CGSize)getContentSizeFont:(UIFont *)font width:(CGFloat)width;

/**
 *  计算字符串宽度
 *
 *  @param text 要计算字符串
 *  @param font 字体
 *
 *  @return 内容宽度
 */
- (CGFloat)getContentWidthFont:(UIFont *)font;

/**
 *  字符串md5值
 *
 *  @param string
 *
 *  @return 字符串MD5值
 */
- (NSString *)getStringMD5;


@end
