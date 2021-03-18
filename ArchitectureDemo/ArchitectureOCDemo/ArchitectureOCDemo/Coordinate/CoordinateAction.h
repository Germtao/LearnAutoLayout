//
//  CoordinateAction.h
//  ArchitectureOCDemo
//
//  Created by QDSG on 2021/3/18.
//

#import <Foundation/Foundation.h>

#define CLASS(cls) NSStringFromClass((cls))
#define ACTION(s)  NSStringFromSelector((s))

NS_ASSUME_NONNULL_BEGIN

@interface CoordinateAction : NSObject

@property (nonatomic, strong) NSString *classMethod;
@property (nonatomic, strong) NSMutableDictionary *parameters;

/// state
@property (nonatomic, strong) NSString *toState;

#pragma mark - Class Methods

+ (CoordinateAction *)classMethod:(NSString *)classMethod;
+ (CoordinateAction *)classMethod:(NSString *)classMethod
                       parameters:(NSMutableDictionary * _Nullable)parameters;
+ (CoordinateAction *)classMethod:(NSString *)classMethod
                       parameters:(NSMutableDictionary * _Nullable)parameters
                          toState:(NSString * _Nullable)toState;

#pragma mark - Chain Helpers

/// 类和方法
+ (CoordinateAction *(^)(NSString *))classMethodIs;
/// 类
+ (CoordinateAction *(^)(NSString *))classIs;
/// 方法
- (CoordinateAction *(^)(NSString *))methodIs;
/// 可选：参数
- (CoordinateAction *(^)(NSMutableDictionary *))parametersIs;
/// 可选：更改状态
- (CoordinateAction *(^)(NSString *))toStateIs;

#pragma mark - 能在编译期检查类和方法的方法

+ (CoordinateAction *(^)(Class))classCheck;
- (CoordinateAction *(^)(SEL))methodCheck;

@end

NS_ASSUME_NONNULL_END
