//
//  Coordinate.h
//  ArchitectureOCDemo
//
//  Created by QDSG on 2021/3/18.
//

#import <Foundation/Foundation.h>
#import "CoordinateAction.h"
#import "Dic.h"

NS_ASSUME_NONNULL_BEGIN

@interface Coordinate : NSObject

/// 解指令执行
- (void)eval:(NSString *)script;

#pragma mark - Reducer
#pragma mark - 下面几种是不同的调用写法，最终的执行是一致的。

/// 可以设置更改当前状态
- (id)dispatch:(CoordinateAction *)action;
- (id)classMethod:(NSString *)classMethod;
- (id)classMethod:(NSString *)classMethod parameters:(NSDictionary * _Nullable)parameters;

- (id (^)(CoordinateAction *))dispatch;

#pragma mark - Middleware 中间件

/// 当设置的方法执行时，先执行指定的方法，可用于观察某方法的执行，然后通知其它 com 执行观察方法进行响应
- (void)middleware:(NSString *)whenClassMethod thenAddDispatch:(CoordinateAction *)action;

/// Middleware 链式写法支持
- (Coordinate *(^)(NSString *))middleware;
- (Coordinate *(^)(CoordinateAction *))addMiddlewareAction;

#pragma mark - State 状态机

/// 当前状态
- (NSString *)currentState;

/// 更新当前状态
/// @param state 状态
- (void)updateCurrentState:(NSString *)state;

/// State 链式写法支持
- (Coordinate *(^)(NSString *))updateCurrentState;

#pragma mark - Observer 观察者

- (void)observerWithIdentifier:(NSString *)identifier observerAction:(CoordinateAction *)action;
- (void)notifyObservers:(NSString *)identifier;

- (Coordinate *(^)(NSString *))observerWithIdentifier;
- (Coordinate *(^)(CoordinateAction *))addObserver;

#pragma mark - Factory 工厂模式

- (void)factoryClass:(NSString *)fClass useFactory:(NSString *)factory;

- (Coordinate *(^)(NSString *))factoryClass;
- (Coordinate *(^)(NSString *))factory;

@end

NS_ASSUME_NONNULL_END
