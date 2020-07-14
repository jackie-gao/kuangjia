//
//  NSString+LSExtension.m
//  shanShuiHotel
//
//  Created by larson on 2018/12/24.
//  Copyright © 2018年 qingYunHotelInfo. All rights reserved.
//

#import "NSString+LSExtension.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (LSExtension)

#pragma mark - <根据文字内容获取文字的宽度>
- (CGFloat)getTextWidthWithViewHeight:(CGFloat)height textFont:(UIFont *)textFont
{
    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    CGSize size = [self boundingRectWithSize:CGSizeMake(MAXFLOAT, height) options:options attributes:@{NSFontAttributeName : textFont} context:nil].size;
    
    return size.width;
}



#pragma mark - <根据文字内容获取文字的高度>
- (CGFloat)getTextHeightWithViewWidth:(CGFloat)width textFont:(UIFont *)textFont
{
    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    CGSize size = [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:options attributes:@{NSFontAttributeName : textFont} context:nil].size;

    return size.height;
}



#pragma mark - <加密的手机号>
- (NSString *)phoneNumEncryption
{
    NSString *encryptionNum = [self substringWithRange:NSMakeRange(3, 4)];
    
    return [self stringByReplacingOccurrencesOfString:encryptionNum withString:@"****"];
}



#pragma mark - <时间字符串转月日字符串>
- (NSString *)dateStringConversionMonthAndDay
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [dateFormatter dateFromString:self];
    
    return [date getMonthAndDay];
}



#pragma mark - <随机key>
+ (NSString *)randomKey
{
    // UUID
    NSString *UUIDString;
    CFUUIDRef UUIDRef = CFUUIDCreate(NULL);
    CFStringRef UUIDStringRef = CFUUIDCreateString(NULL, UUIDRef);
    UUIDString = (NSString *)CFBridgingRelease(UUIDStringRef);
    CFRelease(UUIDRef);
    // 当前时间
    double time = CFAbsoluteTimeGetCurrent();
    // MD5加密
    return [[NSString stringWithFormat:@"%@%f", UUIDString, time] MD5];
}



#pragma mark - <MD5加密>
- (NSString *)MD5
{
    const char *input = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(input, (CC_LONG)strlen(input), result);
    NSMutableString *digest = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [digest appendFormat:@"%02x", result[i]];
    }
    
    return digest;
}



#pragma mark - <富文本>
- (NSMutableAttributedString *)setAttributedWithBeginIndex:(NSInteger)beginIndex endIndex:(NSInteger)endIndex font:(NSInteger)fontSize
{
    NSMutableAttributedString *attributed = [[NSMutableAttributedString alloc]initWithString:self];
    NSRange range = NSMakeRange(beginIndex, endIndex - beginIndex);
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSFontAttributeName] = [UIFont systemFontOfSize:fontSize];
    [attributed addAttributes:dict range:range];

    return attributed;
}

- (NSMutableAttributedString *)setAttributedWithBeginIndex:(NSInteger)beginIndex endIndex:(NSInteger)endIndex attributedTextColor:(UIColor *)attributedTextColor font:(NSInteger)fontSize
{
    NSMutableAttributedString *attributed = [[NSMutableAttributedString alloc]initWithString:self];
    NSRange range = NSMakeRange(beginIndex, endIndex - beginIndex);
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSFontAttributeName] = [UIFont systemFontOfSize:fontSize];
    dict[NSForegroundColorAttributeName] = attributedTextColor;
    [attributed addAttributes:dict range:range];
    
    return attributed;
}

// 转化html标签为富文本
+ (NSMutableAttributedString *)praseHtmlStr:(NSString *)htmlStr
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithData:[htmlStr dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,NSCharacterEncodingDocumentAttribute :@(NSUTF8StringEncoding)} documentAttributes:nil error:nil];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:NSMakeRange(0, attributedString.length)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:kRGBColor(51, 51, 51) range:NSMakeRange(0, attributedString.length)];
    NSMutableParagraphStyle *para = [[NSMutableParagraphStyle alloc]init];
    para.paragraphSpacing = 15;
    [attributedString addAttribute:NSParagraphStyleAttributeName value:para range:NSMakeRange(0, attributedString.length)];
    
    return attributedString;
}

// 正则去除网络标签
+ (NSString *)getZZwithString:(NSString *)string
{
    
    NSRegularExpression *regularExpretion=[NSRegularExpression regularExpressionWithPattern:@"<[^>]*>|\n"
                                                                                    options:0
                                                                                      error:nil];
    string=[regularExpretion stringByReplacingMatchesInString:string options:NSMatchingReportProgress range:NSMakeRange(0, string.length) withTemplate:@""];
    
    return string;
}



#pragma mark - <类型判断>
// 是否是手机号
- (BOOL)isMobileNumber
{
    NSString *pattern = @"^1+[34578]+\\d{9}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    
    return [pred evaluateWithObject:self];
}

// 是否是邮箱
- (BOOL)isEmail
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:self];
}

// 是否是车牌
- (BOOL)isLicensePlate
{
    NSString *carRegex = @"^[A-Za-z]{1}[A-Za-z_0-9]{5}$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    
    return [carTest evaluateWithObject:self];
}

// 是否含有表情字符
- (BOOL)isContainsEmoji
{
    __block BOOL isEomji = NO;
    [self enumerateSubstringsInRange:NSMakeRange(0, self.length) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString * _Nullable substring, NSRange substringRange, NSRange enclosingRange, BOOL * _Nonnull stop) {
        const unichar hs = [substring characterAtIndex:0];
        if (0xd800 <= hs && hs <= 0xdbff) {
            if (substring.length > 1) {
                const unichar ls = [substring characterAtIndex:1];
                const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                if (0x1d000 <= uc && uc <= 0x1f77f) {
                    isEomji = YES;
                }
            }
        }
        else if (substring.length > 1) {
            const unichar ls = [substring characterAtIndex:1];
            if (ls == 0x20e3 || ls == 0xfe0f) {
                isEomji = YES;
            }
        }
        else {
            if (0x2100 <= hs && hs <= 0x27ff && hs != 0x263b) {
                isEomji = YES;
            } else if (0x2B05 <= hs && hs <= 0x2b07) {
                isEomji = YES;
            } else if (0x2934 <= hs && hs <= 0x2935) {
                isEomji = YES;
            } else if (0x3297 <= hs && hs <= 0x3299) {
                isEomji = YES;
            } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50|| hs == 0x231a) {
                isEomji = YES;
            }
        }
    }];
    
    return isEomji;
}

// 是否含有特殊字符，不包含中文
- (BOOL)isContainsSpecialCharacters
{
    NSString *str =@"^[A-Za-z0-9\\u4e00-\u9fa5]+$";
    NSPredicate *strTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", str];
    
    return ![strTest evaluateWithObject:self];
}

// 是否含有特殊字符，包含中文
- (BOOL)isContainsSpecialCharactersAndChinese
{
    NSString *regex = @"[\u4e00-\u9fa5|0-9|a-zA-Z]";
    NSPredicate *strTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    return [strTest evaluateWithObject:self];
}

// 是否包含空格
- (BOOL)isBlack
{
    NSRange range = [self rangeOfString:@" "];
    if (range.location != NSNotFound) {
        return YES;
    } else {
        return NO;
    }
}




// 昵称验证
- (BOOL)validateNickName
{
    NSString *userNameRegex = @"^[A-Za-z0-9\u4e00-\u9fa5]{1,24}+$";
    NSPredicate *userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",userNameRegex];
    
    return [userNamePredicate evaluateWithObject:self];
}

// 邮箱验证
- (BOOL)isValidEmail
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:self];
}

// 电话号码验证
- (BOOL)isValidMobileNumber
{
    NSString* const MOBILE = @"^1(3|4|5|7|8)\\d{9}$";
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    
    return [predicate evaluateWithObject:self];
}

// 验证码验证
- (BOOL)isValidVerifyCode
{
    NSString *pattern = @"^[0-9]{4}";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    
    return [predicate evaluateWithObject:self];
}

// 姓名验证
- (BOOL)isValidRealName
{
    NSString *nicknameRegex = @"^[\u4e00-\u9fa5]{2,8}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nicknameRegex];
    
    return [predicate evaluateWithObject:self];
}

// 只包含中文
- (BOOL)isOnlyChinese
{
    NSString * chineseTest=@"^[\u4e00-\u9fa5]{0,}$";
    NSPredicate*chinesePredicate=[NSPredicate predicateWithFormat:@"SELF MATCHES %@",chineseTest];
    
    return [chinesePredicate evaluateWithObject:self];
}

// 银行卡号验证
- (BOOL)isValidBankCardNumber
{
    NSString* const BANKCARD = @"^(\\d{16}|\\d{19})$";
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", BANKCARD];
    
    return [predicate evaluateWithObject:self];
}

// 密码验证
- (BOOL)isValidAlphaNumberPassword
{
//    NSString *regex = @"^(?!\\d+$|[a-zA-Z]+$)\\w{6,12}$";     // 必须数字和字母组合
    NSString *regex = @"^[A-Za-z0-9]{6,16}$";                   // 可以纯数字和字母
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    return [identityCardPredicate evaluateWithObject:self];
}

@end
