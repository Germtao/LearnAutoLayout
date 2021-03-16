//
//  TTAssembleView.m
//  TTStackView
//
//  Created by QDSG on 2021/3/16.
//

#import "TTAssembleView.h"
#import <objc/message.h>
#import <Masonry/Masonry.h>
#import "TTPartView.h"

@interface TTAssembleView ()

@property (nonatomic, strong) TTAssembleMaker *maker;

@end

@implementation TTAssembleView

+ (instancetype)createView:(void (^)(TTAssembleMaker * _Nonnull))assembleMaker {
    TTAssembleView *assembleView = [[TTAssembleView alloc] init];
    assembleView.maker = [[TTAssembleMaker alloc] init];
    assembleMaker(assembleView.maker);
    [assembleView buildAssembleView];
    return assembleView;
}

#pragma mark - public

+ (instancetype)formatString:(NSString *)string objectsMap:(NSDictionary *)objsMap {
    return [TTAssembleView createViewWithFormatString:string objectsMap:objsMap completion:nil];
}

+ (void)formatStringAsync:(NSString *)string
               objectsMap:(NSDictionary *)objsMap
               completion:(ParsingFormatStringCompleteBlock)completion {
    __weak __typeof(string) weakString = string;
    __weak __typeof(objsMap) weakObjs = objsMap;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        __strong __typeof(weakString) strongString = weakString;
        __strong __typeof(weakObjs) strongObjs = weakObjs;
        if (strongString) {
            [TTAssembleView createViewWithFormatString:strongString objectsMap:strongObjs completion:completion];
        }
    });
}

+ (instancetype)createViewWithFormatString:(NSString *)string
                                objectsMap:(NSDictionary *)objsMap
                                completion:(ParsingFormatStringCompleteBlock _Nullable)completion {
    // 根据格式化字符串来
    NSScanner *scanner = [NSScanner scannerWithString:string];
    scanner.charactersToBeSkipped = [NSCharacterSet whitespaceAndNewlineCharacterSet]; // 跳过换行和空格
    NSMutableArray *tokens = [NSMutableArray array];
    NSMutableCharacterSet *mCharacterSet = [NSMutableCharacterSet alphanumericCharacterSet];
    [mCharacterSet addCharactersInString:@"./|?!$%#-+_&：“”。，《》！"];
    
    // 下一步需要做个特殊字符串映射对应关系，比如说属性的值里需要“:”这个符号和关键符号冲突了就需要通过映射表来处理
    while (!scanner.isAtEnd) {
        for (NSString *operator in @[@"(",@")",@":",@",",@"[",@"]",@"{",@"}",@"<",@">"]) {
            if ([scanner scanString:operator intoString:NULL]) {
                [tokens addObject:operator];
            }
            NSString *result = nil;
            if ([scanner scanCharactersFromSet:mCharacterSet intoString:&result]) {
                [tokens addObject:result];
            }
        }
    }
    
    if (completion) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSArray *strongTokens = tokens;
            NSDictionary *strongObjsMap = objsMap;
            if ([strongTokens isKindOfClass:[NSArray class]]) {
                if (strongTokens.count > 0) {
                    [TTAssembleView createViewWithFormatArray:strongTokens objectsMap:strongObjsMap completion:completion];
                }
            }
        });
        return [[TTAssembleView alloc] init];
    } else {
        return [TTAssembleView createViewWithFormatArray:tokens objectsMap:objsMap completion:completion];
    }
}

#pragma mark - private

+ (TTAssembleView *)createViewWithFormatArray:(NSArray *)array
                                   objectsMap:(NSDictionary *)objsMap
                                   completion:(ParsingFormatStringCompleteBlock _Nullable)completion {
    TTAssembleView *assembleView = [TTAssembleView createView:^(TTAssembleMaker * _Nonnull make) {
        if (completion) {
            make.parsingCompletion = completion;
        } else {
            make.parsingCompletion = nil;
        }
        
        NSMutableArray *assembleProperties = [NSMutableArray array]; // assembleView 的属性数组
        NSMutableArray *partsArray = [NSMutableArray array];         // 用来装所有partView的array的array，二级array
        NSMutableArray *partArray = [NSMutableArray array];          // 单个partView的数组
        
        BOOL isParsingAssembleProperty = NO;    // 正在处理assemble的属性
        BOOL isParsingPart = NO;                // 正在处理part view
        BOOL isParsingPartContainAssemble = NO; // 正在处理part view里包含assemble的情况
        NSUInteger partContainAssembleCount = 0; // part view里包含assemble对层级的计数，当为0时判断为解析结束
        NSUInteger i = 0;
        
        for (NSString *token in array) {
            // 校验是否是合适的assemble view字符串
            if (i == 0) {
                if ([token isEqualToString:@"{"]) {
                    i++;
                    continue;
                } else {
                    break;
                }
            }
            
            // 处理排序方向和对齐方向
            if (i == 1 && token.length == 2) {
                NSString *arrangStr = [token substringWithRange:NSMakeRange(0, 1)];
                NSString *alignmentStr = [token substringWithRange:NSMakeRange(1, 1)];
                
                if ([arrangStr isEqualToString:@"v"]) {
                    make.arrangEqualTo(TTAssembleArrang_Vertical);
                }
                if ([arrangStr isEqualToString:@"h"]) {
                    make.arrangEqualTo(TTAssembleArrang_Horizontal);
                }
                
                if ([alignmentStr isEqualToString:@"c"]) {
                    make.alignmentEqualTo(TTAssembleAlignment_Center);
                }
                if ([alignmentStr isEqualToString:@"l"]) {
                    make.alignmentEqualTo(TTAssembleAlignment_Left);
                }
                if ([alignmentStr isEqualToString:@"r"]) {
                    make.alignmentEqualTo(TTAssembleAlignment_Right);
                }
                if ([alignmentStr isEqualToString:@"t"]) {
                    make.alignmentEqualTo(TTAssembleAlignment_Top);
                }
                if ([alignmentStr isEqualToString:@"b"]) {
                    make.alignmentEqualTo(TTAssembleAlignment_Bottom);
                }
            }
            
            #pragma mark - 处理assemble view的属性
            
            if (i == 2 && [token isEqualToString:@"("]) {
                isParsingAssembleProperty = YES;
            }
            // 灌数组
            if (isParsingAssembleProperty) {
                if ([token isEqualToString:@"("] || [token isEqualToString:@")"]) {
                    // 对应的()符号不用灌
                } else {
                    [assembleProperties addObject:token];
                }
            }
            // 结束处理assemble view的属性
            if (isParsingAssembleProperty && [token isEqualToString:@")"]) {
                isParsingAssembleProperty = NO;
            }
            
            #pragma mark - 处理part view
            
            if ([token isEqualToString:@"["]) {
                isParsingPart = YES;
            }
            // 灌数组
            if (isParsingPart) {
                if ([token isEqualToString:@"{"]) {
                    isParsingPartContainAssemble = YES;
                    partContainAssembleCount += 1;
                }
                if ([token isEqualToString:@"}"]) {
                    partContainAssembleCount -= 1;
                    if (partContainAssembleCount == 0) {
                        // 这时assemble view的灌结束
                        isParsingPartContainAssemble = NO;
                    }
                }
                if (([token isEqualToString:@"["] || [token isEqualToString:@"]"]) && !isParsingPartContainAssemble) {
                    // 对应的[]符号不用灌
                } else {
                    [partArray addObject:token];
                }
            }
            // 结束处理 part view
            if (isParsingPart && [token isEqualToString:@"]"] && !isParsingPartContainAssemble) {
                [partsArray addObject:partArray];
                partArray = [NSMutableArray array];
                isParsingPart = NO;
            }
            
            i++;
        }
        
        // 遍历解析到的assemble view的属性
        NSMutableDictionary *keyValuePropertyMap = [TTAssembleView parsingPropertyFormatArray:assembleProperties objectsMap:objsMap];
        NSArray *keys = [keyValuePropertyMap allKeys];
        for (NSString *key in keys) {
            if ([key isEqualToString:@"padding"]) {
                make.paddingEqualTo([keyValuePropertyMap[key] floatValue]);
            }
            if ([key isEqualToString:@"extendWith"]) {
                make.extendWithEqualTo([keyValuePropertyMap[key] floatValue]);
            }
        }
        
        // part view解析
        for (NSMutableArray *partArray in partsArray) {
            make.addPartView([TTAssembleView createPartViewWithFormatArray:partArray objectsMap:objsMap]);
        }
    }];
    return assembleView;
}

- (TTAssembleView *)buildAssembleView {
    TTAssembleMaker *assembleMaker = self.maker;
    if (assembleMaker.subViews.count <= 0) {
        return self;
    }
    
    UIView __block *lastView = nil;
    NSUInteger i = 0;
    NSUInteger count = assembleMaker.subViews.count;
    for (id obj in assembleMaker.subViews) {
        UIView *view = nil;
        TTPartView *partView = nil;
        if ([obj isKindOfClass:[TTPartView class]]) {
            partView = (TTPartView *)obj;
            view = partView.maker.view;
        } else {
            view = (UIView *)obj;
        }
        [self addSubview:view];
        
        // 设置权重
        if (partView.maker.CRPriority != TTPartPriority_Default) {
            switch (partView.maker.CRPriority) {
                case TTPartPriority_FittingSizeLevel:
                    [view setContentCompressionResistancePriority:UILayoutPriorityFittingSizeLevel
                                                          forAxis:UILayoutConstraintAxisHorizontal];
                    break;
                case TTPartPriority_DefaultLow:
                    [view setContentCompressionResistancePriority:UILayoutPriorityDefaultLow
                                                          forAxis:UILayoutConstraintAxisHorizontal];
                    break;
                case TTPartPriority_DefaultHigh:
                    [view setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh
                                                          forAxis:UILayoutConstraintAxisHorizontal];
                    break;
                case TTPartPriority_Required:
                    [view setContentCompressionResistancePriority:UILayoutPriorityRequired
                                                          forAxis:UILayoutConstraintAxisHorizontal];
                    break;
                    
                default:
                    break;
            }
        }
        
        // 设置布局约束
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            // 通用情况处理
            CGFloat viewPadding = assembleMaker.padding;
            if ([obj isKindOfClass:[TTAssembleView class]]) {
                //
            } else if ([obj isKindOfClass:[TTPartView class]]) {
                // 大小
                if (partView.maker.size.width > 0) {
                    make.width.equalTo(@(partView.maker.size.width));
                }
                
                if (partView.maker.size.height > 0) {
                    make.height.equalTo(@(partView.maker.size.height));
                }
                
                // 根据排列方式是否填充满，如果设置填充，对应的宽高需要设置为0
                if (partView.maker.isFill) {
                    if (assembleMaker.arrang == TTAssembleArrang_Horizontal) {
                        make.height.equalTo(self);
                    } else if (assembleMaker.arrang == TTAssembleArrang_Vertical) {
                        make.width.equalTo(self);
                    }
                }
                
                // 间隔设置
                if (partView.maker.padding != 0) {
                    viewPadding = partView.maker.padding;
                }
            }
            
            CGFloat partViewMarginOffset = 0; // 对齐时，partView设置的间距
            if (partView.maker.alignmentMargin > 0) {
                partViewMarginOffset = partView.maker.alignmentMargin;
            }
            
            // 排序设置
            if (assembleMaker.arrang == TTAssembleArrang_Horizontal) {
                BOOL hNeedAsAlignment = YES; // 是否需要 assemble 配置
                // 水平情况
                if (partView.maker.partAlignment != TTPartAlignment_Default) {
                    // 如果有PartView自定义布局的情况
                    hNeedAsAlignment = NO;
                    if (partView.maker.partAlignment == TTPartAlignment_Left) {
                        // 在只有一个视图，或者这一个part视图是assemble的情况
                        make.left.equalTo(self).offset(partViewMarginOffset);
                        hNeedAsAlignment = YES;
                    } else if (partView.maker.partAlignment == TTPartAlignment_Right) {
                        // 在只有一个视图，或者这一个part视图是assemble的情况
                        hNeedAsAlignment = YES;
                        make.right.equalTo(self).offset(partViewMarginOffset);
                    } else if (partView.maker.partAlignment == TTPartAlignment_Center) {
                        make.centerY.equalTo(self).offset(partViewMarginOffset);
                    } else if (partView.maker.partAlignment == TTPartAlignment_Top) {
                        make.top.equalTo(self).offset(partViewMarginOffset);
                    } else if (partView.maker.partAlignment == TTPartAlignment_Bottom) {
                        make.bottom.equalTo(self).offset(partViewMarginOffset);
                    }
                }
                
                // 需要按照 assemble maker 来配置的情况
                if (hNeedAsAlignment) {
                    if (assembleMaker.alignment == TTAssembleAlignment_Center) {
                        make.centerY.equalTo(self);
                    } else if (assembleMaker.alignment == TTAssembleAlignment_Top) {
                        make.top.equalTo(self);
                    } else if (assembleMaker.alignment == TTPartAlignment_Bottom) {
                        make.bottom.equalTo(self);
                    }
                }
                
                // 由内部撑大 AssembleView
                if (assembleMaker.extendWith == i + 1) {
                    make.top.bottom.equalTo(self);
                }
                
                if (partView.maker.ignoreAlignment == TTPartAlignment_Left) {
                    // 如果设置忽略左约束，就不设置约束
                } else {
                    make.left.equalTo(lastView ? lastView.mas_right : self.mas_left).offset(lastView ? viewPadding : 0);
                }
                
                // 最后一个元素
                if (i == count - 1) {
                    make.right.equalTo(self);
                }
                
                // lessThanOrEqualTo 和 greaterThanOrEqualTo 的设置
                if (partView.maker.minWidth > 0) {
                    make.width.greaterThanOrEqualTo(@(partView.maker.minWidth));
                }
                
                if (partView.maker.maxWidth > 0) {
                    make.width.lessThanOrEqualTo(@(partView.maker.maxWidth));
                }
            }
            else if (assembleMaker.arrang == TTAssembleArrang_Vertical) {
                // 垂直情况
                if (partView.maker.partAlignment != TTPartAlignment_Default) {
                    // 如果有PartView自定义布局的情况
                    if (partView.maker.partAlignment == TTPartAlignment_Left) {
                        make.left.equalTo(self).offset(partViewMarginOffset);
                    } else if (partView.maker.partAlignment == TTPartAlignment_Right) {
                        make.right.equalTo(self).offset(partViewMarginOffset);
                    } else if (partView.maker.partAlignment == TTPartAlignment_Center) {
                        make.centerX.equalTo(self).offset(partViewMarginOffset);
                    } else if (partView.maker.partAlignment == TTPartAlignment_Top) {
                        make.top.equalTo(self).offset(partViewMarginOffset);
                    } else if (partView.maker.partAlignment == TTPartAlignment_Bottom) {
                        make.bottom.equalTo(self).offset(partViewMarginOffset);
                    }
                } else {
                    // 按Assemble View的maker设置来
                    if (assembleMaker.alignment == TTAssembleAlignment_Center) {
                        make.centerX.equalTo(self);
                    } else if (assembleMaker.alignment == TTAssembleAlignment_Left) {
                        make.left.equalTo(self);
                    } else if (assembleMaker.alignment == TTPartAlignment_Right) {
                        make.right.equalTo(self);
                    }
                }
                
                // 由内部撑大AssembleView
                if (assembleMaker.extendWith == i + 1) {
                    make.left.right.equalTo(self);
                }
                
                make.right.lessThanOrEqualTo(self);
                
                if (partView.maker.ignoreAlignment == TTPartAlignment_Top) {
                    // 如果设置忽略上约束, 就不设置上约束
                } else {
                    make.top.equalTo(lastView ? lastView.mas_bottom : self.mas_top).offset(lastView ? viewPadding : 0);
                }
                
                // 最后一个
                if (i == count - 1) {
                    make.bottom.equalTo(self);
                }
            }
        }];
        
        lastView = view;
        i++;
    }
    
    if (assembleMaker.parsingCompletion) {
        assembleMaker.parsingCompletion(self);
    }
    return self;
}

#pragma mark - helpers

/// 格式化字符串创建Part View
+ (TTPartView *)createPartViewWithFormatArray:(NSMutableArray *)array objectsMap:(NSDictionary *)objsMap {
    return [TTPartView createView:^(TTPartMaker *make) {
        NSArray *allObjKeys = objsMap.allKeys;
        
        NSMutableArray *properties = [NSMutableArray array];
        NSMutableArray *assembleArray = [NSMutableArray array];
        
        BOOL isParsingProperty = NO; //正在处理属性
        BOOL isParsingAssemble = NO; //正在处理assemble view数组
        NSInteger partContainAssembleCount = 0;      //part view里包含assemble对层级的计数，当为0时判断为解析结束
        NSUInteger i = 0;
        
        for (NSString *token in array) {
            // 处理assemble view
            if ([token isEqualToString:@"{"]) {
                isParsingAssemble = YES;
                partContainAssembleCount += 1;
            }
            if (isParsingAssemble) {
                [assembleArray addObject:token];
            }
            if ([token isEqualToString:@"}"]) {
                partContainAssembleCount -= 1;
                if (partContainAssembleCount == 0) {
                    // assemble view 处理结束
                    isParsingAssemble = NO;
                }
            }
            
            // 处理 property
            if ([token isEqualToString:@"("] && !isParsingAssemble) {
                isParsingProperty = YES;
            }
            if (isParsingProperty) {
                if ([token isEqualToString:@"["] || [token isEqualToString:@"]"]) {
                    // 这里就不用记录这两个符号了
                } else {
                    [properties addObject:token];
                }
            }
            if ([token isEqualToString:@")"] && !isParsingAssemble) {
                isParsingProperty = NO;
            }
            
            // 处理自定义视图
            if (!isParsingAssemble && !isParsingProperty) {
                for (NSString *key in allObjKeys) {
                    if ([key isEqualToString:token]) {
                        make.customViewEqualTo(objsMap[key]);
                    }
                }
            }
            
            i++;
        }
        
        // assemble view的情况就用递归完成
        if (assembleArray.count > 0) {
            make.customViewEqualTo([TTAssembleView createViewWithFormatArray:assembleArray objectsMap:objsMap completion:nil]);
        }
        
        // 开始设置 part 属性
        if (properties.count > 0) {
            NSMutableDictionary *map = [TTAssembleView parsingPropertyFormatArray:properties objectsMap:objsMap];
            NSArray *allKeys = [map allKeys];
            CGFloat width = 0;
            CGFloat height = 0;
            for (NSString *key in allKeys) {
                // 设置布局
                if ([key isEqualToString:@"width"]) {
                    width = [map[key] floatValue];
                }
                if ([key isEqualToString:@"height"]) {
                    height = [map[key] floatValue];
                }
                if ([key isEqualToString:@"isFill"]) {
                    if ([map[key] integerValue] > 0) {
                        make.isFillEqualTo(YES);
                    } else {
                        make.isFillEqualTo(NO);
                    }
                }
                if ([key isEqualToString:@"padding"]) {
                    make.paddingEqualTo([map[key] floatValue]);
                }
                if ([key isEqualToString:@"partAlignment"]) {
                    if ([map[key] isEqualToString:@"center"]) {
                        make.partAlignmentEqualTo(TTPartAlignment_Center);
                    } else if ([map[key] isEqualToString:@"left"]) {
                        make.partAlignmentEqualTo(TTPartAlignment_Left);
                    } else if ([map[key] isEqualToString:@"right"]) {
                        make.partAlignmentEqualTo(TTPartAlignment_Right);
                    } else if ([map[key] isEqualToString:@"top"]) {
                        make.partAlignmentEqualTo(TTPartAlignment_Top);
                    } else if ([map[key] isEqualToString:@"bottom"]) {
                        make.partAlignmentEqualTo(TTPartAlignment_Bottom);
                    }
                }
                if ([key isEqualToString:@"ignoreAlignment"]) {
                    if ([map[key] isEqualToString:@"center"]) {
                        make.ignoreAlignmentEqualTo(TTPartAlignment_Center);
                    } else if ([map[key] isEqualToString:@"left"]) {
                        make.ignoreAlignmentEqualTo(TTPartAlignment_Left);
                    } else if ([map[key] isEqualToString:@"right"]) {
                        make.ignoreAlignmentEqualTo(TTPartAlignment_Right);
                    } else if ([map[key] isEqualToString:@"top"]) {
                        make.ignoreAlignmentEqualTo(TTPartAlignment_Top);
                    } else if ([map[key] isEqualToString:@"bottom"]) {
                        make.ignoreAlignmentEqualTo(TTPartAlignment_Bottom);
                    }
                }
                if ([key isEqualToString:@"alignmentMargin"]) {
                    make.alignmentMarginEqualTo([map[key] floatValue]);
                }
                // 设置权重
                if ([key isEqualToString:@"crp"]) {
                    if ([map[key] isEqualToString:@"fit"]) {
                        make.CRPriorityEqualTo(TTPartPriority_FittingSizeLevel);
                    } else if ([map[key] isEqualToString:@"low"]) {
                        make.CRPriorityEqualTo(TTPartPriority_DefaultLow);
                    } else if ([map[key] isEqualToString:@"high"]) {
                        make.CRPriorityEqualTo(TTPartPriority_DefaultHigh);
                    } else if ([map[key] isEqualToString:@"required"]) {
                        make.CRPriorityEqualTo(TTPartPriority_Required);
                    }
                }
                // 设置最大最小宽
                if ([key isEqualToString:@"minWidth"]) {
                    make.minWidthEqualTo([map[key] floatValue]);
                } else if ([key isEqualToString:@"maxWidth"]) {
                    make.maxWidthEqualTo([map[key] floatValue]);
                }
                // 设置控件通用
                if ([key isEqualToString:@"backColor"]) {
                    if ([map[key] isKindOfClass:[UIColor class]]) {
                        UIColor *color = (UIColor *)map[key];
                        make.backColorIs(color);
                    } else {
                        make.backColorHexStringIs(map[key]);
                    }
                }
                if ([key isEqualToString:@"backColorHexString"]) {
                    make.backColorHexStringIs(map[key]);
                }
                if ([key isEqualToString:@"backPaddingHorizontal"]) {
                    make.backPaddingHorizontalIs([map[key] floatValue]);
                }
                if ([key isEqualToString:@"backPaddingVertical"]) {
                    make.backPaddingVerticalIs([map[key] floatValue]);
                }
                if ([key isEqualToString:@"backBorderColor"]) {
                    if ([map[key] isKindOfClass:[UIColor class]]) {
                        UIColor *color = (UIColor *)map[key];
                        make.backBoardColorIs(color);
                    } else {
                        make.backBoardColorHexStringIs(map[key]);
                    }
                }
                if ([key isEqualToString:@"backBorderColorHexString"]) {
                    make.backBoardColorHexStringIs(map[key]);
                }
                if ([key isEqualToString:@"backBorderWidth"]) {
                    make.backBoardWidthIs([map[key] floatValue]);
                }
                if ([key isEqualToString:@"backBorderRadius"] || [key isEqualToString:@"radius"]) {
                    make.backBoardRadiusIs([map[key] floatValue]);
                }
                if ([key isEqualToString:@"button"]) {
                    make.buttonIs(map[key]);
                }
                if ([key isEqualToString:@"buttonHighlightColor"]) {
                    if ([map[key] isKindOfClass:[UIColor class]]) {
                        make.buttonHighlightColorIs(map[key]);
                    }
                }
                
                // 设置文本属性
                if ([key isEqualToString:@"text"]) {
                    make.textIs(map[key]);
                }
                if ([key isEqualToString:@"fontSize"]) {
                    make.fontSizeIs([map[key] floatValue]);
                }
                if ([key isEqualToString:@"font"]) {
                    if ([map[key] isKindOfClass:[UIFont class]]) {
                        make.fontIs((UIFont *)map[key]);
                    } else {
                        make.fontSizeIs([map[key] floatValue]);
                    }
                }
                if ([key isEqualToString:@"color"]) {
                    if ([map[key] isKindOfClass:[UIColor class]]) {
                        make.colorIs((UIColor *)map[key]);
                    } else {
                        make.colorHexStringIs(map[key]);
                    }
                }
                if ([key isEqualToString:@"colorHexString"]) {
                    make.colorHexStringIs(map[key]);
                }
                if ([key isEqualToString:@"imageName"]) {
                    make.imageNameIs(map[key]);
                }
                if ([key isEqualToString:@"image"]) {
                    if ([map[key] isKindOfClass:[UIImage class]]) {
                        make.imageIs((UIImage *)map[key]);
                    } else {
                        make.imageUrlIs(map[key]);
                    }
                }
                if ([key isEqualToString:@"imageUrl"]) {
                    make.imageUrlIs(map[key]);
                }
            }
            // 处理多个值需要组合的情况
            if (width > 0 || height > 0) {
                make.sizeEqualTo(CGSizeMake(width, height));
            }
        }
    }];
}

/// 将属性数组转成键值对应的字典
+ (NSMutableDictionary *)parsingPropertyFormatArray:(NSMutableArray *)array objectsMap:(NSDictionary *)objsMap {
    NSArray *allObjKeys = objsMap.allKeys;
    // 遍历解析到的assemble view的属性
    [array addObject:@","]; // 处理最后一个没添加,的情况
    
    BOOL isParsingOneProperty = NO;
    NSString *parsingKey = @"";
    BOOL isParsingObjsMap = NO;
    
    NSMutableDictionary *keyValueProperties = [NSMutableDictionary dictionary];
    for (NSString *str in array) {
        // 属性
        if (!isParsingOneProperty) {
            isParsingOneProperty = YES;
            parsingKey = str;
        } else if ([str isEqualToString:@":"]) {
            // 直接略过
        } else if ([str isEqualToString:@","]) {
            // 需要结束
            isParsingOneProperty = NO;
        } else if (isParsingOneProperty) {
            if ([str isEqualToString:@"<"]) {
                isParsingObjsMap = YES;
            } else if ([str isEqualToString:@">"]) {
                isParsingObjsMap = NO;
            } else if (isParsingObjsMap) {
                // 处理objsMap传入的属性
                for (NSString *key in allObjKeys) {
                    if ([key isEqualToString:str]) {
                        keyValueProperties[parsingKey] = objsMap[key];
                    }
                }
            } else {
                keyValueProperties[parsingKey] = str;
            }
        }
    }
    return keyValueProperties;
}

@end
