//
//  TTPartMaker.h
//  TTStackView
//
//  Created by QDSG on 2021/3/16.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UIColor+HexString.h"

typedef NS_ENUM(NSUInteger, TTPartAlignment) {
    TTPartAlignment_Default,
    TTPartAlignment_Center,
    TTPartAlignment_Left,
    TTPartAlignment_Right,
    TTPartAlignment_Top,
    TTPartAlignment_Bottom
};

typedef NS_ENUM(NSUInteger, TTPartColor) {
    TTPartColor_White,
    TTPartColor_Black,
    TTPartColor_Gray,
    TTPartColor_LightGray,
    TTPartColor_DarkGray,
    TTPartColor_Orange,
    TTPartColor_Red
};

typedef NS_ENUM(NSUInteger, TTPartPriority) {
    TTPartPriority_Default,           // 不设置，按默认来
    TTPartPriority_FittingSizeLevel,  // 50
    TTPartPriority_DefaultLow,        // 250
    TTPartPriority_DefaultHigh,       // 750
    TTPartPriority_Required           // 1000
};

NS_ASSUME_NONNULL_BEGIN

@interface TTPartMaker : NSObject

#pragma mark - 属性

@property (nonatomic) CGSize size;
@property (nonatomic) CGFloat padding;
@property (nonatomic, strong) UIView *view;

/// 如果设置填充，对应的宽、高需要设置为 0
@property (nonatomic) BOOL isFill;

/// 不设置就按照 assembleView 的设置来
@property (nonatomic) TTPartAlignment partAlignment;
/// 对齐方向和 assembleView 的间距
@property (nonatomic) CGFloat alignmentMargin;
/// 需要忽略的约束方向
@property (nonatomic) TTPartAlignment ignoreAlignment;
/// CompressionResistancePriority
@property (nonatomic) TTPartPriority CRPriority;

@property (nonatomic) CGFloat minWidth;
@property (nonatomic) CGFloat maxWidth;

#pragma mark - 控件属性，通用部分

#pragma mark - 底部

/// 底部设置的颜色
@property (nonatomic, strong) UIColor *backColor;
/// 边线颜色
@property (nonatomic, strong) UIColor *backBoardColor;
/// 边线大小
@property (nonatomic) CGFloat backBoardWidth;
/// 边线半径
@property (nonatomic) CGFloat backBoardRadius;
/// 水平间隔
@property (nonatomic) CGFloat backPaddingHorizontal;
/// 垂直间隔
@property (nonatomic) CGFloat backPaddingVertical;
/// 待实现
@property (nonatomic, strong) UIImage *backImage;

#pragma mark - UIButton

@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UIColor *buttonHighlightColor;

#pragma mark - UILabel

@property (nonatomic, copy) NSString *text;
@property (nonatomic, strong) UIFont *font;
@property (nonatomic, strong) UIColor *color;

#pragma mark - UIImageView

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, strong) UIImage *imagePlaceholder;

#pragma mark - Function

#pragma mark - 布局

- (TTPartMaker * _Nonnull (^)(UIView * _Nonnull))customViewEqualTo;
- (TTPartMaker * _Nonnull (^)(CGSize))sizeEqualTo;
- (TTPartMaker * _Nonnull (^)(BOOL))isFillEqualTo;
- (TTPartMaker * _Nonnull (^)(CGFloat))paddingEqualTo;
- (TTPartMaker * _Nonnull (^)(TTPartAlignment))partAlignmentEqualTo;
- (TTPartMaker * _Nonnull (^)(CGFloat))alignmentMarginEqualTo;
- (TTPartMaker * _Nonnull (^)(TTPartAlignment))ignoreAlignmentEqualTo;
- (TTPartMaker * _Nonnull (^)(TTPartPriority))CRPriorityEqualTo;
- (TTPartMaker * _Nonnull (^)(CGFloat))minWidthEqualTo;
- (TTPartMaker * _Nonnull (^)(CGFloat))maxWidthEqualTo;

#pragma mark - 控件属性

#pragma mark - 通用

- (TTPartMaker * _Nonnull (^)(UIColor * _Nonnull))backColorIs;
- (TTPartMaker * _Nonnull (^)(NSString * _Nonnull))backColorHexStringIs;
- (TTPartMaker * _Nonnull (^)(UIColor * _Nonnull))backBoardColorIs;
- (TTPartMaker * _Nonnull (^)(NSString * _Nonnull))backBoardColorHexStringIs;
- (TTPartMaker * _Nonnull (^)(CGFloat))backBoardWidthIs;
- (TTPartMaker * _Nonnull (^)(CGFloat))backBoardRadiusIs;
- (TTPartMaker * _Nonnull (^)(CGFloat))backPaddingHorizontalIs;
- (TTPartMaker * _Nonnull (^)(CGFloat))backPaddingVerticalIs;
- (TTPartMaker * _Nonnull (^)(UIButton * _Nonnull))buttonIs;
- (TTPartMaker * _Nonnull (^)(UIColor * _Nonnull))buttonHighlightColorIs;

#pragma mark - UILabel

- (TTPartMaker * _Nonnull (^)(NSString * _Nonnull))textIs;
- (TTPartMaker * _Nonnull (^)(UIFont * _Nonnull))fontIs;
- (TTPartMaker * _Nonnull (^)(CGFloat))fontSizeIs;
- (TTPartMaker * _Nonnull (^)(UIColor * _Nonnull))colorIs;
/// 16 进制颜色
- (TTPartMaker * _Nonnull (^)(NSString * _Nonnull))colorHexStringIs;
/// 颜色类型
- (TTPartMaker * _Nonnull (^)(TTPartColor))colorTypeIs;

#pragma mark - UIImageView

- (TTPartMaker * _Nonnull (^)(UIImage * _Nonnull))imageIs;
- (TTPartMaker * _Nonnull (^)(NSString * _Nonnull))imageNameIs;
- (TTPartMaker * _Nonnull (^)(NSString * _Nonnull))imageUrlIs;
- (TTPartMaker * _Nonnull (^)(UIImage * _Nonnull))imagePlaceholderIs;
- (TTPartMaker * _Nonnull (^)(NSString * _Nonnull))imagePlaceholderNameIs;

@end

NS_ASSUME_NONNULL_END
