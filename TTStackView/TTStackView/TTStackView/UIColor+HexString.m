//
//  UIColor+HexString.m
//  TTStackView
//
//  Created by QDSG on 2021/3/16.
//

#import "UIColor+HexString.h"

@implementation UIColor (HexString)

+ (instancetype)colorWithHexString:(NSString *)hexString {
    NSString *stringToConvert = [[hexString stringByReplacingOccurrencesOfString:@"#" withString:@""] uppercaseString];
        
    NSScanner *scanner = [NSScanner scannerWithString:stringToConvert];
    unsigned hexNum;
    if (![scanner scanHexInt:&hexNum]) return nil;
    return [self colorWithRGBHex:hexNum];
}

+ (UIColor *)colorWithRGBHex:(UInt32)hex {
    int r = (hex >> 16) & 0xFF;
    int g = (hex >> 8) & 0xFF;
    int b = (hex) & 0xFF;
    
    return [UIColor colorWithRed:r / 255.0f
                           green:g / 255.0f
                            blue:b / 255.0f
                           alpha:1.0f];
}

@end
