//
//  UIColor+HexString.h
//  TTStackView
//
//  Created by QDSG on 2021/3/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (HexString)

+ (instancetype)colorWithHexString:(NSString *)hexString;

@end

NS_ASSUME_NONNULL_END
