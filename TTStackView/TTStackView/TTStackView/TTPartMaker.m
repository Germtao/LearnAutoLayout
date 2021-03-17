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

- (TTPartMaker * (^)(UIView *))customViewEqualTo {
    return ^TTPartMaker *(UIView *customView) {
        self.view = customView;
        return self;
    };
}

- (TTPartMaker * (^)(CGSize))sizeEqualTo {
    return ^TTPartMaker *(CGSize size) {
        self.size = size;
        return self;
    };
}

- (TTPartMaker * (^)(BOOL))isFillEqualTo {
    return ^TTPartMaker *(BOOL isFill) {
        self.isFill = isFill;
        return self;
    };
}

- (TTPartMaker * (^)(CGFloat))paddingEqualTo {
    return ^TTPartMaker *(CGFloat padding) {
        self.padding = padding;
        return self;
    };
}

- (TTPartMaker * (^)(TTPartAlignment))partAlignmentEqualTo {
    return ^TTPartMaker *(TTPartAlignment partAlignment) {
        self.partAlignment = partAlignment;
        return self;
    };
}

- (TTPartMaker * (^)(CGFloat))alignmentMarginEqualTo {
    return ^TTPartMaker *(CGFloat alignmentMargin) {
        self.alignmentMargin = alignmentMargin;
        return self;
    };
}

- (TTPartMaker * (^)(TTPartAlignment))ignoreAlignmentEqualTo {
    return ^TTPartMaker *(TTPartAlignment ignoreAlignment) {
        self.ignoreAlignment = ignoreAlignment;
        return self;
    };
}

- (TTPartMaker * (^)(TTPartPriority))CRPriorityEqualTo {
    return ^TTPartMaker *(TTPartPriority CRPriority) {
        self.CRPriority = CRPriority;
        return self;
    };
}

- (TTPartMaker * (^)(CGFloat))minWidthEqualTo {
    return ^TTPartMaker *(CGFloat minWidth) {
        self.minWidth = minWidth;
        return self;
    };
}

- (TTPartMaker * (^)(CGFloat))maxWidthEqualTo {
    return ^TTPartMaker *(CGFloat maxWidth) {
        self.maxWidth = maxWidth;
        return self;
    };
}

#pragma mark - 控件 通用

- (TTPartMaker * (^)(UIColor *))backColorIs {
    return ^TTPartMaker *(UIColor *backColor) {
        self.backColor = backColor;
        return self;
    };
}

- (TTPartMaker * (^)(NSString *))backColorHexStringIs {
    return ^TTPartMaker *(NSString *hexString) {
        self.backColor = [UIColor colorWithHexString:hexString];
        return self;
    };
}

- (TTPartMaker * (^)(UIColor *))backBoardColorIs {
    return ^TTPartMaker *(UIColor *backBoardColor) {
        self.backBoardColor = backBoardColor;
        return self;
    };
}

- (TTPartMaker * (^)(NSString *))backBoardColorHexStringIs {
    return ^TTPartMaker *(NSString *hexString) {
        self.backBoardColor = [UIColor colorWithHexString:hexString];
        return self;
    };
}

- (TTPartMaker * (^)(CGFloat))backBoardWidthIs {
    return ^(CGFloat width) {
        self.backBoardWidth = width;
        return self;
    };
}

- (TTPartMaker * (^)(CGFloat))backBoardRadiusIs {
    return ^(CGFloat radius) {
        self.backBoardRadius = radius;
        return self;
    };
}

- (TTPartMaker * (^)(CGFloat))backPaddingHorizontalIs {
    return ^(CGFloat padding) {
        self.backPaddingHorizontal = padding;
        return self;
    };
}

- (TTPartMaker * (^)(CGFloat))backPaddingVerticalIs {
    return ^(CGFloat padding) {
        self.backPaddingVertical = padding;
        return self;
    };
}

- (TTPartMaker * (^)(UIButton *))buttonIs {
    return ^(UIButton *button) {
        self.button = button;
        return self;
    };
}

- (TTPartMaker * (^)(UIColor *))buttonHighlightColorIs {
    return ^(UIColor *color) {
        self.buttonHighlightColor = color;
        return self;
    };
}

#pragma mark - UILabel

- (TTPartMaker * (^)(NSString *))textIs {
    return ^(NSString *text) {
        self.text = text;
        return self;
    };
}

- (TTPartMaker * (^)(UIFont *))fontIs {
    return ^(UIFont *font) {
        self.font = font;
        return self;
    };
}

- (TTPartMaker * (^)(CGFloat))fontSizeIs {
    return ^(CGFloat fontSize) {
        self.font = [UIFont systemFontOfSize:fontSize];
        return self;
    };
}

- (TTPartMaker * (^)(UIColor *))colorIs {
    return ^(UIColor *color) {
        self.color = color;
        return self;
    };
}

- (TTPartMaker * (^)(NSString *))colorHexStringIs {
    return ^(NSString *hexString) {
        self.color = [UIColor colorWithHexString:hexString];
        return self;
    };
}

- (TTPartMaker * (^)(TTPartColor))colorTypeIs {
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

- (TTPartMaker * (^)(UIImage *))imageIs {
    return ^(UIImage *image) {
        self.image = image;
        return self;
    };
}

- (TTPartMaker * (^)(NSString *))imageNameIs {
    return ^(NSString *imageName) {
        self.image = [UIImage imageNamed:imageName]; // 这里需要根据情况
        return self;
    };
}

- (TTPartMaker * (^)(NSString *))imageUrlIs {
    return ^(NSString *imageUrl) {
        self.imageUrl = imageUrl;
        return self;
    };
}

- (TTPartMaker * (^)(UIImage *))imagePlaceholderIs {
    return ^(UIImage *placeholder) {
        self.imagePlaceholder = placeholder;
        return self;
    };
}

- (TTPartMaker * (^)(NSString *))imagePlaceholderNameIs {
    return ^(NSString *placeholderName) {
        self.imagePlaceholder = [UIImage imageNamed:placeholderName];
        return self;
    };
}

@end
