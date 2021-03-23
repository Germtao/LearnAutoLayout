//
//  TTHook.m
//  TTHook
//
//  Created by QDSG on 2021/3/23.
//

#import "TTHook.h"
#import <objc/runtime.h>

@implementation TTHook

+ (void)hookClass:(Class)classObject fromSelector:(SEL)fromSelector toSelector:(SEL)toSelector {
    Class cClass = classObject;
    
    // 被替换类的实例方法
    Method fromMethod = class_getInstanceMethod(cClass, fromSelector);
    
    // 替换类的实例方法
    Method toMethod = class_getInstanceMethod(cClass, toSelector);
    
    // class_addMethod 返回成功：表示被替换的方法没实现，然后会通过 class_addMethod 方法先实现；
    // 返回失败：则表示被替换方法已存在，可以直接进行 IMP 指针交换
    if (class_addMethod(cClass, fromSelector, method_getImplementation(toMethod), method_getTypeEncoding(toMethod))) {
        // 进行方法的替换
        class_replaceMethod(cClass, toSelector, method_getImplementation(fromMethod), method_getTypeEncoding(fromMethod));
    } else {
        // 交换 IMP 指针
        method_exchangeImplementations(fromMethod, toMethod);
    }
}

@end
