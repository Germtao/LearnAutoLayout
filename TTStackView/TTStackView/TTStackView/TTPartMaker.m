//
//  TTPartMaker.m
//  TTStackView
//
//  Created by QDSG on 2021/3/16.
//

#import "TTPartMaker.h"

typedef NS_ENUM(NSUInteger, TTPartType) {
    TTPartType_Custom,
    TTPartType_UILabel,
    TTPartType_UIImageView
};

@implementation TTPartMaker

#pragma mark - 布局

- (TTPartMaker * _Nonnull (^)(UIView * _Nonnull))customViewEqualTo {
    return ^TTPartMaker *(UIView *customView) {
        self.view = customView;
        return self;
    };
}

- (TTPartMaker * _Nonnull (^)(CGSize))sizeEqualTo {
    return ^TTPartMaker *(CGSize size) {
        self.size = size;
        return self;
    };
}

- (TTPartMaker * _Nonnull (^)(BOOL))isFillEqualTo {
    return ^TTPartMaker *(BOOL isFill) {
        self.isFill = isFill;
        return self;
    };
}

- (TTPartMaker * _Nonnull (^)(CGFloat))paddingEqualTo {
    return ^TTPartMaker *(CGFloat padding) {
        self.padding = padding;
        return self;
    };
}

- (TTPartMaker * _Nonnull (^)(TTPartAlignment))partAlignmentEqualTo {
    return ^TTPartMaker *(TTPartAlignment partAlignment) {
        self.partAlignment = partAlignment;
        return self;
    };
}

- (TTPartMaker * _Nonnull (^)(CGFloat))alignmentMarginEqualTo {
    return ^TTPartMaker *(CGFloat alignmentMargin) {
        self.alignmentMargin = alignmentMargin;
        return self;
    };
}

- (TTPartMaker * _Nonnull (^)(TTPartAlignment))ignoreAlignmentEqualTo {
    return ^TTPartMaker *(TTPartAlignment ignoreAlignment) {
        self.ignoreAlignment = ignoreAlignment;
        return self;
    };
}

- (TTPartMaker * _Nonnull (^)(TTPartPriority))CRPriorityEqualTo {
    return ^TTPartMaker *(TTPartPriority CRPriority) {
        self.CRPriority = CRPriority;
        return self;
    };
}

- (TTPartMaker * _Nonnull (^)(CGFloat))minWidthEqualTo {
    return ^TTPartMaker *(CGFloat minWidth) {
        self.minWidth = minWidth;
        return self;
    };
}

- (TTPartMaker * _Nonnull (^)(CGFloat))maxWidthEqualTo {
    return ^TTPartMaker *(CGFloat maxWidth) {
        self.maxWidth = maxWidth;
        return self;
    };
}

#pragma mark - 控件 通用

- (TTPartMaker * _Nonnull (^)(UIColor * _Nonnull))backColorIs {
    return ^TTPartMaker *(UIColor *backColor) {
        self.backColor = backColor;
        return self;
    };
}

- (TTPartMaker * _Nonnull (^)(NSString * _Nonnull))backColorHexStringIs {
    return ^TTPartMaker *(NSString *hexString) {
        self.backColor = [UIColor colorWithHexString:hexString];
        return self;
    };
}

- (TTPartMaker * _Nonnull (^)(UIColor * _Nonnull))backBoardColorIs {
    return ^TTPartMaker *(UIColor *backBoardColor) {
        self.backBoardColor = backBoardColor;
        return self;
    };
}

- (TTPartMaker * _Nonnull (^)(NSString * _Nonnull))backBoardColorHexStringIs {
    return ^TTPartMaker *(NSString *hexString) {
        self.backBoardColor = [UIColor colorWithHexString:hexString];
        return self;
    };
}

- (TTPartMaker * _Nonnull (^)(CGFloat))backBoardWidthIs {
    return ^(CGFloat width) {
        self.backBoardWidth = width;
        return self;
    };
}

- (TTPartMaker * _Nonnull (^)(CGFloat))backBoardRadiusIs {
    return ^(CGFloat radius) {
        self.backBoardRadius = radius;
        return self;
    };
}

- (TTPartMaker * _Nonnull (^)(CGFloat))backPaddingHorizontalIs {
    return ^(CGFloat padding) {
        self.backPaddingHorizontal = padding;
        return self;
    };
}

- (TTPartMaker * _Nonnull (^)(CGFloat))backPaddingVerticalIs {
    return ^(CGFloat padding) {
        self.backPaddingVertical = padding;
        return self;
    };
}

- (TTPartMaker * _Nonnull (^)(UIButton * _Nonnull))buttonIs {
    return ^(UIButton *button) {
        self.button = button;
        return self;
    };
}

- (TTPartMaker * _Nonnull (^)(UIColor * _Nonnull))buttonHighlightColorIs {
    return ^(UIColor *color) {
        self.buttonHighlightColor = color;
        return self;
    };
}

#pragma mark - UILabel

- (TTPartMaker * _Nonnull (^)(NSString * _Nonnull))textIs {
    return ^(NSString *text) {
        self.text = text;
        return self;
    };
}

- (TTPartMaker * _Nonnull (^)(UIFont * _Nonnull))fontIs {
    return ^(UIFont *font) {
        self.font = font;
        return self;
    };
}

- (TTPartMaker * _Nonnull (^)(CGFloat))fontSizeIs {
    return ^(CGFloat fontSize) {
        self.font = [UIFont systemFontOfSize:fontSize];
        return self;
    };
}

- (TTPartMaker * _Nonnull (^)(UIColor * _Nonnull))colorIs {
    return ^(UIColor *color) {
        self.color = color;
        return self;
    };
}

- (TTPartMaker * _Nonnull (^)(NSString * _Nonnull))colorHexStringIs {
    return ^(NSString *hexString) {
        self.color = [UIColor colorWithHexString:hexString];
        return self;
    };
}

- (TTPartMaker * _Nonnull (^)(TTPartColor))colorTypeIs {
    return ^(TTPartColor type) {
        switch (type) {
            case TTPartColor_White:
                self.color = [UIColor whiteColor];
                break;
            case TTPartColor_Black:
                self.color = [UIColor blackColor];
                break;
            case TTPartColor_Gray:
                self.color = [UIColor grayColor];
                break;
            case TTPartColor_LightGray:
                self.color = [UIColor lightGrayColor];
                break;
            case TTPartColor_DarkGray:
                self.color = [UIColor darkGrayColor];
                break;
            case TTPartColor_Orange:
                self.color = [UIColor orangeColor];
                break;
            case TTPartColor_Red:
                self.color = [UIColor redColor];
                break;
        }
        return self;
    };
}

#pragma mark - UIImageView

- (TTPartMaker * _Nonnull (^)(UIImage * _Nonnull))imageIs {
    return ^(UIImage *image) {
        self.image = image;
        return self;
    };
}

- (TTPartMaker * _Nonnull (^)(NSString * _Nonnull))imageNameIs {
    return ^(NSString *imageName) {
        self.image = [UIImage imageNamed:imageName]; // 这里需要根据情况
        return self;
    };
}

- (TTPartMaker * _Nonnull (^)(NSString * _Nonnull))imageUrlIs {
    return ^(NSString *imageUrl) {
        self.imageUrl = imageUrl;
        return self;
    };
}

- (TTPartMaker * _Nonnull (^)(UIImage * _Nonnull))imagePlaceholderIs {
    return ^(UIImage *placeholder) {
        self.imagePlaceholder = placeholder;
        return self;
    };
}

- (TTPartMaker * _Nonnull (^)(NSString * _Nonnull))imagePlaceholderNameIs {
    return ^(NSString *placeholderName) {
        self.imagePlaceholder = [UIImage imageNamed:placeholderName];
        return self;
    };
}

@end
