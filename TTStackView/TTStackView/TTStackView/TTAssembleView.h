//
//  TTAssembleView.h
//  TTStackView
//
//  Created by QDSG on 2021/3/16.
//

#import <UIKit/UIKit.h>
#import "TTAssembleMaker.h"

@class TTPartView;

NS_ASSUME_NONNULL_BEGIN

@interface TTAssembleView : UIView

@property (nonatomic, strong, readonly) TTAssembleMaker *maker;

+ (instancetype)createView:(void(^)(TTAssembleMaker * _Nonnull make))assembleMaker;

/// 主线程格式化字符串，创建 assembleView
/// @param string 字符串
/// @param objsMap 对象字典
+ (instancetype)formatString:(NSString *)string
                  objectsMap:(NSDictionary *)objsMap;

/// 异步线程格式化字符串，内部实现异步处理，外部需要父视图或类持有 string 和 objsMap，
/// 如果在方法栈里设置的话，string 和 objsMap 在异步还没开始执行前出栈时会被释放。
/// @param string 字符串
/// @param objsMap 对象字典
/// @param completion 完成回调
+ (void)formatStringAsync:(NSString *)string
               objectsMap:(NSDictionary *)objsMap
               completion:(ParsingFormatStringCompleteBlock)completion;

/// 提供可异步操作回调主线程block，内部没实现异步处理，需要在外部进行。
/// @param string 字符串
/// @param objsMap 对象字典
/// @param completion 完成回调
+ (instancetype)createViewWithFormatString:(NSString *)string
                                objectsMap:(NSDictionary *)objsMap
                                completion:(ParsingFormatStringCompleteBlock _Nullable)completion;

/// 简化 NSString 的 format
FOUNDATION_EXPORT NSString *ASS(NSString *format, ...) NS_FORMAT_FUNCTION(1, 2);

@end

NS_ASSUME_NONNULL_END
