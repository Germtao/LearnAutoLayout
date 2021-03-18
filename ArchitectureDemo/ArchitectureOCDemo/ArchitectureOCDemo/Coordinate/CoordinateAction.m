//
//  CoordinateAction.m
//  ArchitectureOCDemo
//
//  Created by QDSG on 2021/3/18.
//

#import "CoordinateAction.h"

@interface CoordinateAction ()

@property (nonatomic, strong) NSString *chainClass;

@end

@implementation CoordinateAction

#pragma mark - Class Methods

+ (CoordinateAction *)classMethod:(NSString *)classMethod {
    return [CoordinateAction classMethod:classMethod parameters:nil];
}

+ (CoordinateAction *)classMethod:(NSString *)classMethod
                       parameters:(NSMutableDictionary * _Nullable)parameters {
    return [CoordinateAction classMethod:classMethod parameters:parameters toState:nil];
}

+ (CoordinateAction *)classMethod:(NSString *)classMethod
                       parameters:(NSMutableDictionary * _Nullable)parameters
                          toState:(NSString * _Nullable)toState {
    CoordinateAction *action = [[CoordinateAction alloc] init];
    action.classMethod = classMethod;
    action.parameters = parameters;
    action.toState = toState;
    return action;
}

#pragma mark - Chain Helpers

+ (CoordinateAction * _Nonnull (^)(NSString * _Nonnull))classMethodIs {
    return ^CoordinateAction *(NSString *classMethod) {
        CoordinateAction *action = [[CoordinateAction alloc] init];
        action.classMethod = classMethod;
        return action;
    };
}

+ (CoordinateAction * _Nonnull (^)(NSString * _Nonnull))classIs {
    return ^CoordinateAction *(NSString *cls) {
        CoordinateAction *action = [[CoordinateAction alloc] init];
        action.chainClass = cls;
        return action;
    };
}

- (CoordinateAction * _Nonnull (^)(NSString * _Nonnull))methodIs {
    return ^CoordinateAction *(NSString *method) {
        self.classMethod = [NSString stringWithFormat:@"%@ %@", self.chainClass, method];
        return self;
    };
}

- (CoordinateAction * _Nonnull (^)(NSMutableDictionary * _Nonnull))parametersIs {
    return ^CoordinateAction *(NSMutableDictionary *params) {
        self.parameters = params;
        return self;
    };
}

- (CoordinateAction * _Nonnull (^)(NSString * _Nonnull))toStateIs {
    return ^CoordinateAction *(NSString *toState) {
        self.toState = toState;
        return self;
    };
}

+ (CoordinateAction * _Nonnull (^)(Class  _Nonnull __unsafe_unretained))classCheck {
    return ^CoordinateAction *(Class cls) {
        CoordinateAction *action = [[CoordinateAction alloc] init];
        action.chainClass = CLASS(cls);
        return action;
    };
}

- (CoordinateAction * _Nonnull (^)(SEL _Nonnull))methodCheck {
    return ^CoordinateAction *(SEL s) {
        NSString *selStr = ACTION(s);
        NSString *clearSelStr = [selStr substringToIndex:selStr.length - 1];
        self.classMethod = [NSString stringWithFormat:@"%@ %@", self.chainClass, clearSelStr];
        return self;
    };
}

@end
