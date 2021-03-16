//
//  TTAssembleMaker.m
//  TTStackView
//
//  Created by QDSG on 2021/3/16.
//

#import "TTAssembleMaker.h"
#import "TTAssembleView.h"

@implementation TTAssembleMaker

- (TTAssembleMaker * _Nonnull (^)(TTAssembleView * _Nonnull))addAssembleView {
    return ^(TTAssembleView *assembleView) {
        [self.subViews addObject:assembleView];
        return self;
    };
}

- (TTAssembleMaker * _Nonnull (^)(TTPartView * _Nonnull))addPartView {
    return ^(TTPartView *partView) {
        [self.subViews addObject:partView];
        return self;
    };
}

- (TTAssembleMaker * _Nonnull (^)(UIView * _Nonnull))addView {
    return ^(UIView *view) {
        [self.subViews addObject:view];
        return self;
    };
}

- (TTAssembleMaker * _Nonnull (^)(CGFloat))paddingEqualTo {
    return ^(CGFloat padding) {
        self.padding = padding;
        return self;
    };
}

- (TTAssembleMaker * _Nonnull (^)(TTAssembleAlignment))alignmentEqualTo {
    return ^(TTAssembleAlignment alignment) {
        self.alignment = alignment;
        return self;
    };
}

- (TTAssembleMaker * _Nonnull (^)(TTAssembleArrang))arrangEqualTo {
    return ^(TTAssembleArrang arrang) {
        self.arrang = arrang;
        return self;
    };
}

- (TTAssembleMaker * _Nonnull (^)(NSUInteger))extendWithEqualTo {
    return ^(NSUInteger extendWith) {
        self.extendWith = extendWith;
        return self;
    };
}

- (NSMutableArray *)subViews {
    if (!_subViews) {
        _subViews = [NSMutableArray array];
    }
    return _subViews;
}

@end
