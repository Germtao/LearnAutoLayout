//
//  TTAssembleMaker.h
//  TTStackView
//
//  Created by QDSG on 2021/3/16.
//

#import <Foundation/Foundation.h>
#import "TTPartView.h"

@class TTAssembleView;

typedef NS_ENUM(NSUInteger, TTAssembleAlignment) {
    TTAssembleAlignment_Center,
    TTAssembleAlignment_Left,
    TTAssembleAlignment_Right,
    TTAssembleAlignment_Top,
    TTAssembleAlignment_Bottom
};

typedef NS_ENUM(NSUInteger, TTAssembleArrang) {
    TTAssembleArrang_Horizontal,
    TTAssembleArrang_Vertical
};

typedef void(^ParsingFormatStringCompleteBlock)(TTAssembleView * _Nullable assembleView);

NS_ASSUME_NONNULL_BEGIN

@interface TTAssembleMaker : NSObject

/// 存放所有子视图
@property (nonatomic, strong) NSMutableArray *subViews;

/// 间隔距离
@property (nonatomic) CGFloat padding;

/// 对齐方式
@property (nonatomic) TTAssembleAlignment alignment;

/// 排列方式（水平、垂直）
@property (nonatomic) TTAssembleArrang arrang;

/// 由第几个PartView来撑开AssembleView的大小
@property (nonatomic) NSUInteger extendWith;

@property (nonatomic, copy) ParsingFormatStringCompleteBlock _Nullable parsingCompletion;


- (TTAssembleMaker * (^)(TTAssembleView *))addAssembleView;
- (TTAssembleMaker * (^)(TTPartView *))addPartView;
- (TTAssembleMaker * (^)(UIView *))addView;

- (TTAssembleMaker * (^)(CGFloat))paddingEqualTo;
- (TTAssembleMaker * (^)(TTAssembleAlignment))alignmentEqualTo;
- (TTAssembleMaker * (^)(TTAssembleArrang))arrangEqualTo;
- (TTAssembleMaker * (^)(NSUInteger))extendWithEqualTo;

@end

NS_ASSUME_NONNULL_END
