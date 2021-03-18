//
//  Coordinate.m
//  ArchitectureOCDemo
//
//  Created by QDSG on 2021/3/18.
//

#import "Coordinate.h"

@interface Coordinate ()

@property (nonatomic, strong) NSMutableDictionary *classMap;

#pragma mark - 状态机

@property (nonatomic, copy) NSString *p_currentState;

#pragma mark - 中间件

@property (nonatomic, strong) NSMutableDictionary *middlewareMap;
@property (nonatomic, strong) NSString *chainMiddlewareKey;

#pragma mark - 观察者

@property (nonatomic, strong) NSMutableDictionary *observerIdentifierMap;
@property (nonatomic, strong) NSString *chainIdentifier;

#pragma mark - 工厂模式

@property (nonatomic, strong) NSMutableDictionary *factoryMap;
@property (nonatomic, strong) NSString *chainFactoryClass;

@end

@implementation Coordinate

- (void)eval:(NSString *)script {}

#pragma mark - Reducer

- (id)classMethod:(NSString *)classMethod {
    return [self classMethod:classMethod parameters:nil];
}

- (id)classMethod:(NSString *)classMethod parameters:(NSDictionary * _Nullable)parameters {
    NSArray *sep = [classMethod componentsSeparatedByString:@" "];
    NSString *classStr = @"";
    NSString *methodStr = @"";
    if (sep.count == 2) {
        classStr = sep[0];
        methodStr = [NSString stringWithFormat:@"%@:", sep[1]];
    } else {
        return nil;
    }
    
    // Factory
    // 由于后面的执行都会用到 class 所以需要优先处理 class 的变形体
    NSString *factory = [self.factoryMap objectForKey:classStr];
    if (factory) {
        classStr = [NSString stringWithFormat:@"%@_factory_%@", classStr, factory];
        classMethod = [NSString stringWithFormat:@"%@ %@", classStr, sep[1]];
    }
    
    // Middleware 中间件
    id middleware = [self.middlewareMap objectForKey:classMethod];
    if (middleware) {
        [self perform:middleware];
    }
    
    NSObject *obj = self.classMap[classStr];
    if (obj == nil) {
        Class objClass = NSClassFromString(classStr);
        obj = [[objClass alloc] init];
        self.classMap[classStr] = obj;
    }
    
    SEL method = NSSelectorFromString(methodStr);
    // State action 状态处理
    if (![self.p_currentState isEqual:@"init"]) {
        NSString *stateMethodStr = [NSString stringWithFormat:@"%@_state_%@:", sep[1], self.p_currentState];
        SEL stateMethod = NSSelectorFromString(stateMethodStr);
        if ([obj respondsToSelector:stateMethod]) {
            return [self executeMethod:stateMethod object:obj parameters:parameters];
        }
    }
    
    // 普通 action
    SEL notFoundMethod = NSSelectorFromString(@"notFound:");
    if ([obj respondsToSelector:method]) {
        return [self executeMethod:method object:obj parameters:parameters];
    } else if ([obj respondsToSelector:notFoundMethod]) {
        return [self executeMethod:method object:obj parameters:parameters];
    } else {
        [self.classMap removeObjectForKey:classStr];
        return nil;
    }
    
    return nil;
}

- (id  _Nonnull (^)(CoordinateAction * _Nonnull))dispatch {
    return ^Coordinate *(CoordinateAction *action) {
        return [self dispatch:action];
    };
}

- (id)dispatch:(CoordinateAction *)action {
    if (action.toState.length > 0) {
        self.p_currentState = action.toState;
    }
    return [self classMethod:action.classMethod parameters:action.parameters];
}

#pragma mark - 中间件

- (void)middleware:(NSString *)whenClassMethod thenAddDispatch:(CoordinateAction *)action {
    if (whenClassMethod.length < 1 || !action) {
        return;
    }
    
    NSMutableArray *mArr = [self.middlewareMap objectForKey:whenClassMethod];
    if (!mArr) {
        mArr = [NSMutableArray array];
    }
    [mArr addObject:action];
    self.middlewareMap[whenClassMethod] = mArr;
}

- (Coordinate * _Nonnull (^)(NSString * _Nonnull))middleware {
    return ^Coordinate *(NSString *middleware) {
        if (middleware.length > 0) {
            self.chainMiddlewareKey = middleware;
        }
        return self;
    };
}

- (Coordinate * _Nonnull (^)(CoordinateAction * _Nonnull))addMiddlewareAction {
    return ^Coordinate *(CoordinateAction *action) {
        if (!action) {
            return self;
        }
        
        NSMutableArray *mArr = [self.middlewareMap objectForKey:self.chainMiddlewareKey];
        if (!mArr) {
            mArr = [NSMutableArray array];
        }
        [mArr addObject:action];
        self.middlewareMap[self.chainMiddlewareKey] = mArr;
        return self;
    };
}

#pragma mark - 状态机

- (NSString *)currentState {
    return self.p_currentState;
}

- (void)updateCurrentState:(NSString *)state {
    if (state.length < 1) {
        return;
    }
    
    self.p_currentState = state;
}

- (Coordinate * _Nonnull (^)(NSString * _Nonnull))updateCurrentState {
    return ^Coordinate *(NSString *state) {
        if (state.length > 0) {
            self.p_currentState = state;
        }
        return self;
    };
}

#pragma mark - 观察者

- (void)observerWithIdentifier:(NSString *)identifier observerAction:(CoordinateAction *)action {
    if (identifier.length < 1 || !action) {
        return;
    }
    
    NSMutableArray *mArr = [self.observerIdentifierMap objectForKey:identifier];
    if (!mArr) {
        mArr = [NSMutableArray array];
    }
    [mArr addObject:action];
    self.observerIdentifierMap[identifier] = mArr;
}

- (void)notifyObservers:(NSString *)identifier {
    NSMutableArray *mArr = [self.observerIdentifierMap objectForKey:identifier];
    if (mArr.count > 0) {
        for (CoordinateAction *action in mArr) {
            self.dispatch(action);
        }
    }
}

- (Coordinate * _Nonnull (^)(NSString * _Nonnull))observerWithIdentifier {
    return ^Coordinate *(NSString *identifier) {
        if (identifier.length > 0) {
            self.chainIdentifier = identifier;
        }
        return self;
    };
}

- (Coordinate * _Nonnull (^)(CoordinateAction * _Nonnull))addObserver {
    return ^Coordinate *(CoordinateAction *action) {
        NSMutableArray *mArr = [self.observerIdentifierMap objectForKey:self.chainIdentifier];
        if (!mArr) {
            mArr = [NSMutableArray array];
        }
        [mArr addObject:action];
        self.observerIdentifierMap[self.chainIdentifier] = mArr;
        return self;
    };
}

#pragma mark - 工厂模式

- (void)factoryClass:(NSString *)fClass useFactory:(NSString *)factory {
    if (fClass.length < 1 || factory.length < 1) {
        return;
    }
    self.factoryMap[fClass] = factory;
}

- (Coordinate * _Nonnull (^)(NSString * _Nonnull))factoryClass {
    return ^Coordinate *(NSString *fClass) {
        self.chainFactoryClass = fClass;
        return self;
    };
}

- (Coordinate * _Nonnull (^)(NSString * _Nonnull))factory {
    return ^Coordinate *(NSString *factory) {
        self.factoryMap[self.chainFactoryClass] = factory;
        return self;
    };
}

#pragma mark - Helpers

- (void)perform:(id)action {
    if ([action isKindOfClass:[CoordinateAction class]]) {
        [self dispatch:action];
    } else if ([action isKindOfClass:[NSMutableArray class]]) {
        for (CoordinateAction *act in action) {
            [self dispatch:act];
        }
    }
}

- (id)executeMethod:(SEL)method object:(NSObject *)object parameters:(NSDictionary *)parameters {
    NSMethodSignature *signature = [object methodSignatureForSelector:method];
    if (signature == nil) {
        return nil;
    }
    
    const char *retType = [signature methodReturnType];
    
    if (strcmp(retType, @encode(void)) == 0) {
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
        [invocation setArgument:&parameters atIndex:2];
        [invocation setSelector:method];
        [invocation setTarget:object];
        [invocation invoke];
        return nil;
    }
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    return [object performSelector:method withObject:parameters];
#pragma clang diagnostic pop
}

#pragma mark - getter

- (NSMutableDictionary *)classMap {
    if (!_classMap) {
        _classMap = [[NSMutableDictionary alloc] init];
    }
    return _classMap;
}

- (NSMutableDictionary *)middlewareMap {
    if (!_middlewareMap) {
        _middlewareMap = [[NSMutableDictionary alloc] init];
    }
    return _middlewareMap;
}

- (NSString *)p_currentState {
    if (!_p_currentState) {
        _p_currentState = @"init";
    }
    return _p_currentState;
}

- (NSMutableDictionary *)observerIdentifierMap {
    if (!_observerIdentifierMap) {
        _observerIdentifierMap = [[NSMutableDictionary alloc] init];
    }
    return _observerIdentifierMap;
}

- (NSString *)chainMiddlewareKey {
    if (!_chainMiddlewareKey) {
        _chainMiddlewareKey = @"empty";
    }
    return _chainMiddlewareKey;
}

- (NSString *)chainIdentifier {
    if (!_chainIdentifier) {
        _chainIdentifier = @"empty";
    }
    return _chainIdentifier;
}

- (NSMutableDictionary *)factoryMap {
    if (!_factoryMap) {
        _factoryMap = [[NSMutableDictionary alloc] init];
    }
    return _factoryMap;
}

- (NSString *)chainFactoryClass {
    if (!_chainFactoryClass) {
        _chainFactoryClass = @"empty";
    }
    return _chainFactoryClass;
}

@end
