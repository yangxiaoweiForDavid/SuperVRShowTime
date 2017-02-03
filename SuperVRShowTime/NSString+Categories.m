//
//  NSString+Categories.m
//  EkuKangDA
//
//  Created by answer-Huang on 3/28/14.
//  Copyright (c) 2014 eku. All rights reserved.
//

#import "NSString+Categories.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (Categories)

/**
 *  计算 MD5 值
 *
 *  @param input
 *
 *  @return
 */
- (NSString *) md5
{
    const char *cStr = [self UTF8String];
    unsigned char digest[16];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), digest );
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(NSUInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++){
        [output appendFormat:@"%02x", digest[i]];
    }
    
    return  output;
    
}

- (NSString*) sha1
{
    const char *encoding = [self cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:encoding length:self.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, (CC_LONG)data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}


/**
 *  检测字符串是否为空（nil或者空字符串）
 *
 *  @param trim 是否忽略前后空白字符
 *
 *  @return 是否为空
 */
+(BOOL)isEmpty:(NSString *)str trim:(BOOL)trim{
    if(str == nil || str.length == 0){
        return YES;
    }else{
        if(trim){
            return [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length == 0;
        }
    }
    return NO;
}

/**
 *  对 URL 进行编码
 *
 *  @return 编码后的 URL
 */
- (NSString *)urlEncode {
    return [[self stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

//------------------------------

#pragma mark - 字符串校验处理
/**
 *  校验空字符串
 *
 *  @param string 需要校验的字符串
 *
 *  @return YES/NO
 */
+ (BOOL)checkStringEmpty:(NSString *)string{
    if ((NSNull *)string == [NSNull null]) {
        return YES;
    }
    if (string == nil || [string length] == 0) {
        return YES;
    } else if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0) {
        return YES;
    }
    return NO;
 
}

/**
 *  校验手机号码是否合法
 *
 *  @param mobileNum 手机号码
 *
 *  @return YES/NO
 */
- (BOOL)isMobileNum{
    if ([NSString checkStringEmpty:self]) {
        return NO;
    }
    
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString *MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    
    if ([regextestmobile evaluateWithObject:self]) {
        return YES;
    } else {
        return NO;
    }
}

/**
 *  校验电话号码是否合法
 *
 *  @param telPhoneNum 电话号码字符串
 *
 *  @return YES/NO
 */
- (BOOL)checkTelPhoneNum{
    if ([NSString checkStringEmpty:self]) {
        return NO;
    }
    
    NSString *telPhone = @"^(0[0-9]{2,3})?([2-9][0-9]{6,7})+(\\-[0-9]{1,4})?$|(^400[0-9]{7}$)";
    
    NSPredicate *regextestphone = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", telPhone];
    
    if ([regextestphone evaluateWithObject:self]) {
        return YES;
    } else {
        return NO;
    }
}

/**
 *  校验email地址是否合法
 *
 *  @param email email字符串
 *
 *  @return YES/NO
 */
- (BOOL)checkValidateEmail{
    if ([NSString checkStringEmpty:self]) {
        return NO;
    }
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

#pragma mark - JSON处理
/**
 *  序列化对象为json格式字符串
 *
 *  @param obj 将要序列化对象
 *
 *  @return json格式字符串
 */
+ (NSString *)SerializationObjToJson:(id)obj {
    if (obj == nil) {
        return  nil;
    }
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:obj options:NSJSONWritingPrettyPrinted error:&error];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

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
- (CGFloat)getContentHeightWithFont:(UIFont *)font labelWidth:(CGFloat)labelWidth {
    CGSize constraint = CGSizeMake(labelWidth, 20000.f);
    
    CGRect rect = [self boundingRectWithSize:constraint options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName] context:nil];
    CGSize size = rect.size;
    
    return ceilf(size.height + 1);
}

/**
 *  计算字符串的宽高
 *
 *  @param text       要计算的字符串
 *  @param font       字体
 *  @param labelWidth 宽度
 *
 *  @return 字符串宽高
 */
- (CGSize)getContentSizeFont:(UIFont *)font width:(CGFloat)width
{
    CGSize constraint = CGSizeMake(width, 20000.f);
    
    CGRect rect = [self boundingRectWithSize:constraint options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName] context:nil];
    CGSize size = rect.size;
    
    return size;
}

/**
 *  计算字符串宽度
 *
 *  @param text 要计算字符串
 *  @param font 字体
 *
 *  @return 内容宽度
 */
- (CGFloat)getContentWidthFont:(UIFont *)font {
    
    CGSize constraint = CGSizeMake(10000.f, 20000.f);
    CGRect rect = [self boundingRectWithSize:constraint options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName] context:nil];
    CGSize size = rect.size;
    return ceilf(size.width + 1);
}

/**
 *  字符串md5值
 *
 *  @param string
 *
 *  @return 字符串MD5值
 */
- (NSString *)getStringMD5{
    if ([NSString checkStringEmpty:self]) {
        return nil;
    }
    
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

@end
