//
//  TTAssembleMaker.m
//  TTStackView
//
//  Created by QDSG on 2021/3/16.
//

#import "TTAssembleMaker.h"
#import "TTAssembleView.h"

@implementation TTAssembleMaker

- (TTAssembleMaker * (^)(TTAssembleView *))addAssembleView {
    return ^(TTAssembleView *assembleView) {
        [self.subViews addObject:assembleView];
        return self;
    };
}

- (TTAssembleMaker * (^)(TTPartView *))addPartView {
    return ^(TTPartView *partView) {
        [self.subViews addObject:partView];
        return self;
    };
}

- (TTAssembleMaker * (^)(UIView *))addView {
    return ^(UIView *view) {
        [self.subViews addObject:view];
        return self;
    };
}

- (TTAssembleMaker * (^)(CGFloat))paddingEqualTo {
    return ^(CGFloat padding) {
        self.padding = padding;
        return self;
    };
}

- (TTAssembleMaker * (^)(TTAssembleAlignment))alignmentEqualTo {
    return ^(TTAssembleAlignment alignment) {
        self.alignment = alignment;
        return self;
    };
}

- (TTAssembleMaker * (^)(TTAssembleArrang))arrangEqualTo {
    return ^(TTAssembleArrang arrang) {
        self.arrang = arrang;
        return self;
    };
}

- (TTAssembleMaker * (^)(NSUInteger))extendWithEqualTo {
    return ^(NSUInteger extendWith) {
        self.extendWith = extendWith;
        return self;
    };
}

#pragma mark - getter

- (NSMutableArray *)subViews {
    if (!_subViews) {
        _subViews = [NSMutableArray array];
    }
    return _subViews;
}

@end
